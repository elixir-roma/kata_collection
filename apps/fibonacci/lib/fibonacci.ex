defmodule Fibonacci do
  @moduledoc """
  Demonstrate your recursion skills by implementing the Fibonacci series!
  """
  @seed [1, 1]

  @spec fib(integer) :: list
  def fib(n)

  def fib(n) when n < 2 do
    Enum.take @seed, n
  end

  def fib(n) when n >= 2 do
    fib(@seed, n - 2)
  end

  defp fib(acc, 0), do: acc

  defp fib(acc, n) do
    fib(acc ++ [Enum.at(acc, -2) + Enum.at(acc, -1)], n - 1)
  end
end
