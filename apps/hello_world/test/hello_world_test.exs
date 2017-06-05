defmodule HelloWorldTest do
  use ExUnit.Case
  doctest HelloWorld

  test "It should print \"Hello world\"" do
    mock = fn input -> assert input == "Hello world" end
    HelloWorld.hello(mock)
  end
end
