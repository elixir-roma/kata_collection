# Elixir Katas

1. hello_world: test the code
2. fibonacci: fix the test implementing fibonacci series
3. dining_philosophers: fix the test managing resources

## Solutions

The solutions are contained in different branches, below the list with a minimum of explanations:

1. hello_world

    1.1. Branch: `hw-solution` you can test side effects with inversion of control
2. fibonacci

    2.1. Branch: `fib-solution` here the simple solution, this solve the first test, but isn't tail recursive, and is slow

    2.2. Branch: `fib-solution2` elegant, fast, tail recursive solution
3. dining_philosophers

    3.1. Branch: `dp-solution` When the philosopher begins to eat informs the resource manager, if the manager has two free
    chopsticks he makes him eat, if not it puts the philosopher in a queue.
    When a philosopher has eaten, he frees the chopsticks, and the resource manager function takes a step of recursion,
    if there are philosophers in the queue, they will also eat with the following iterations

If you want to read the `hello_world` solution you can simply checkout the right branch:

```bash
$ git checkout hw-solution
```

Happy hacking!
