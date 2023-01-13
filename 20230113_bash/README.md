## Shell

Ready to seminar

```sh
git clone git@github.com:KIMGEONUNG/comars-core.git 
cd comars-core
```

Reset the example codes
```sh
git reset --hard # at git root
```

### Motivation

Working in the shell environment is inevitable, especially using cluster server.


### Focus

ChatGPT is good script generator, so we don't need to be expert of shell scripting.
Let's focus on fundamental principles.


### Stdin and Stdout

The most basic communication method in shell.

```sh
# Stdout example
echo hello cglab
```

```sh
# Stdin example
wc -l # Enter
hello
cglab
# Ctrl + d (EOF signal)
```

### Pipe 

```sh
# Example of pipe
ls | wc -l
find . | grep lua  # grep command extracts lines including a word as argument
find . | grep -v lua  # v option means excluding a word 
find . | grep -v lua | wc -l
```

#### practice

<span style="color:red">
Print all file paths including "lua" and excluding "user"
</span>

### Stdin vs Argument


Don't be confused Stdout and argument

```sh
rm a b # the arguments are a and b
ls # The printed results on the shell screen are the stdout 
```

The the command as follow doesn't work

```sh
ls | rm
```

### How do we use stdout as argument

The command "xargs" transfer the stdout to argument

```sh
ls *.sh | xargs rm
```

An advanced example is
```sh
find . | grep sh$ | xargs rm
find . -name *.lua | xarges egrep require
```

### Useful commands
- find
- grep
- wc 
- xargs

### How does wild card work

This just converts it-self into the other texts

```sh
echo *
echo */*
echo */*/*
```

or, for better readability

```sh
echo * | xargs -n1
echo */* | xargs -n1
echo */*/* | xargs -n1
```


So we can do like this

```sh
echo */*/* | xargs rm
```


### Other trick rather than wild card

```sh
echo {hello,hi} {world,postech}
```
