#!/usr/bin/env python

from glob import glob
from skimage.io import imread
from skimage.color import rgb2lab, lab2rgb
import gradio as gr
import numpy as np
from random import shuffle


class GraysGUI(object):
    """Recolorization GUI System"""

    def __init__(self, share=False):
        self.share = share
        self.height = 300

        self.methods = [
            "shuffle_channel",
        ]

        # Define GUI Layout
        css = r"img { image-rendering: pixelated; }"
        with gr.Blocks(css=css) as self.demo:
            with gr.Box():
                with gr.Box(), gr.Row():
                    view_gt = gr.Image(
                        label="GT",
                        interactive=False).style(height=self.height)
                with gr.Box(), gr.Row():
                    view_R = gr.Image(
                        label="Red",
                        interactive=False).style(height=self.height)
                    view_G = gr.Image(
                        label="Green",
                        interactive=False).style(height=self.height)
                    view_B = gr.Image(
                        label="Blue",
                        interactive=False).style(height=self.height)
                with gr.Box(), gr.Row():
                    view_IR = gr.Image(
                        label="Using Red Luminance",
                        interactive=False).style(height=self.height)
                    view_IG = gr.Image(
                        label="Using Green Luminance",
                        interactive=False).style(height=self.height)
                    view_IB = gr.Image(
                        label="Using Blue Luminance",
                        interactive=False).style(height=self.height)
                with gr.Box(), gr.Row():
                    view_RG = gr.Image(
                        label="Only Red&Green",
                        interactive=False).style(height=self.height)
                    view_GB = gr.Image(
                        label="Only Green&Blue",
                        interactive=False).style(height=self.height)
                    view_BR = gr.Image(
                        label="Only Blue&Red",
                        interactive=False).style(height=self.height)
            gr.Examples(sorted(glob("srcs/*")), inputs=view_gt)

            with gr.Box(), gr.Row():
                num_infer = gr.Slider(minimum=1, maximum=1024, value=16)
                btn_id = gr.Button("Identity").style(height=self.height)
                btn_shuffle = gr.Button("Shuffle Channel").style(
                    height=self.height)
                btn_scale_shift = gr.Button("Scale & Shift").style(
                    height=self.height)
                btn_gray = gr.Button("Convert Gray").style(height=self.height)
            with gr.Box(), gr.Column():
                gallery = gr.Gallery().style(grid=4)

            # Define Events
            btn_id.click(lambda x, num: [x for _ in range(num)],
                         inputs=[view_gt, num_infer],
                         outputs=[gallery])
            btn_shuffle.click(self.shuffle,
                              inputs=[view_gt, num_infer],
                              outputs=[gallery])
            btn_scale_shift.click(self.scaleshift,
                                  inputs=[gallery],
                                  outputs=[gallery])
            btn_gray.click(self.gray, inputs=[gallery], outputs=[gallery])

            view_gt.change(self.extract_each_channel,
                           inputs=view_gt,
                           outputs=[view_R, view_G, view_B])

            view_gt.change(self.augment_with_luma,
                           inputs=view_gt,
                           outputs=[view_IR, view_IG, view_IB])

            view_gt.change(self.extract_two_channel,
                           inputs=view_gt,
                           outputs=[view_RG, view_GB, view_BR])

    def extract_two_channel(self, x):
        rg = x.copy()
        gb = x.copy()
        br = x.copy()
        rg[..., 2] = 0
        gb[..., 0] = 0
        br[..., 1] = 0
        return rg, gb, br

    def launch(self):
        self.demo.launch(share=self.share)

    def extract_each_channel(self, x):
        r = np.tile(x[..., 0:1], (1, 1, 3))
        g = np.tile(x[..., 1:2], (1, 1, 3))
        b = np.tile(x[..., 2:3], (1, 1, 3))
        return r, g, b

    def augment_with_luma(self, x):
        x_ = x / 255 * 100
        r = x_[..., 0:1]
        g = x_[..., 1:2]
        b = x_[..., 2:3]

        lab = rgb2lab(x)
        ab = lab[..., 1:]

        x_ir = lab2rgb(np.concatenate((r, ab), axis=-1))
        x_ig = lab2rgb(np.concatenate((g, ab), axis=-1))
        x_ib = lab2rgb(np.concatenate((b, ab), axis=-1))

        x_ir = (x_ir * 255).astype('uint8')
        x_ig = (x_ig * 255).astype('uint8')
        x_ib = (x_ib * 255).astype('uint8')

        return x_ir, x_ig, x_ib

    def shuffle(self, x, num_iter):
        num_iter = int(num_iter)

        order = [0, 1, 2]
        xs = []
        for i in range(num_iter):
            shuffle(order)
            x_hat = x[..., order]
            xs.append(x_hat)
        return xs

    def gray(self, xs):

        xs = [imread(x["name"]) for x in xs]
        xs_hat = []

        for x in xs:
            x_hat = x / 255.
            x_hat = x_hat @ np.array([0.299, 0.587, 0.114])
            x_hat = (x_hat * 255).astype('uint8')
            x_hat = np.tile(x_hat[..., None], (1, 1, 3))
            xs_hat.append(x_hat)

        return xs_hat

    def scaleshift(self, xs):

        xs = [imread(x["name"]) for x in xs]
        xs_hat = []

        for x in xs:
            x_hat = x / 255.
            shrink = np.random.uniform(0, 1, size=3)
            bias = np.random.uniform(0, 1, size=3)

            shrink = np.stack([shrink, np.ones_like(shrink) * 0.1]).max(axis=0)
            bias = np.stack([bias, 1.0 - shrink]).min(axis=0)

            x_hat = x_hat * shrink + bias
            x_hat = (x_hat * 255).astype('uint8')
            xs_hat.append(x_hat)

        return xs_hat


if __name__ == "__main__":
    gui = GraysGUI()
    gui.launch()
