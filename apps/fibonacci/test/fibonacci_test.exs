defmodule FibonacciTest do
  use ExUnit.Case

  import Fibonacci

  test "fibonacci" do
    assert fib(0) == []
    assert fib(1) == [0]
    assert fib(2) == [0, 1]
    assert fib(10) == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  end


  test "benchmark" do
    {microsecs, _} = :timer.tc fn -> fib(1000) end

    assert microsecs < 200
  end
end