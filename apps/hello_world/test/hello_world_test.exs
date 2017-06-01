defmodule HelloWorldTest do
  use ExUnit.Case
  doctest HelloWorld

  test "I should test a side effect, but how?!?" do
    refute "It's impossible!'"
  end
end
