defmodule DiningPhilosophersTest do
  use ExUnit.Case

  require Logger

  test "All philosophers should eat and think proportionally" do
    me = self()
    DiningPhilosophers.Table.simulate(me)

    receive do
      {:philosophers, philosophers} ->
        Logger.info("Philosopers received")
        assert Enum.count(philosophers) > 0
        :timer.sleep 50_000

        Enum.map(philosophers, fn philosopher ->
          send philosopher, {:observe, me}
          receive do
             {ate, thunk} ->

              Logger.info("ate: #{ate}, thunk: #{thunk}")

              refute (ate + 2) < thunk, "The philosopher isn't eating!'"
              refute (thunk + 2) < ate, "The philosopher isn't thinking!'"
              # assert ate == thunk # Happy path!!
          end
        end)
    end

  end
end
