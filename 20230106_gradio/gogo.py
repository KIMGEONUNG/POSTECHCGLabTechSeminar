import gradio as gr
import skimage

def foo(x, num):
    return [x, x, x, x, x, x]

with gr.Blocks() as demo:
    with gr.Row():
        view = gr.Image()
        view_a = gr.Image()
    num = gr.Number()
    btn = gr.Button()
    gr.Examples(["srcs/ILSVRC2012_val_00000476.JPEG", "srcs/ILSVRC2012_val_00000747.JPEG"], inputs=[view])
    # view_out = gr.Image().style(height=300)
    view_out = gr.Gallery().style(grid=3)

    btn.click(foo, [view, num], [view_out])

demo.launch()
