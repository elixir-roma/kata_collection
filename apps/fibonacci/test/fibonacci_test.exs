defmodule FibonacciTest do
  use ExUnit.Case

  import Fibonacci

  test "fibonacci" do
    assert fib(0) == []
    assert fib(1) == [1]
    assert fib(2) == [1, 1]
    assert fib(10) == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
  end


  test "benchmark" do
    {microsecs, _} = :timer.tc fn -> fib(1000) end

    assert microsecs < 200
  end
end