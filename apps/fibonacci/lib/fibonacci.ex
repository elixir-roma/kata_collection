defmodule Fibonacci do
  @moduledoc """
  Demonstrate your recursion skills by implementing the Fibonacci series!
  """
  @seed [1, 1]

  @spec fib(integer) :: list
  def fib(n)

  def fib(n) when n < 2 do
    Enum.reverse(@seed) |> Enum.take(n)
  end

  def fib(n) when n >= 2 do
    fib(@seed, n - 2)
  end

  defp fib(acc, 0), do: Enum.reverse(acc)

  defp fib([first, second | _] = lst, n) do
    fib([first + second | lst], n - 1)
  end
end
