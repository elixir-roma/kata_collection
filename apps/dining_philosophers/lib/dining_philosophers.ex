defmodule DiningPhilosophers do
@moduledoc """
## Problem

http://rosettacode.org/wiki/Dining_philosophers

Five philosophers, Aristotle, Kant, Spinoza, Marx, and Russell (the tasks) spend their time
thinking and eating spaghetti. They eat at a round table with five individual seats.
For eating each philosopher needs two chopsticks (the resources). There are five chopsticks on the table,
one left and one right of each seat. When a philosopher cannot grab both chopsticks it sits and waits.
Eating takes random time, then the philosopher puts the chopsticks down and leaves the dining room.
After spending some random time thinking about the nature of the universe, he again becomes
hungry, and the circle repeats itself.
"""

  defmodule Table do
    alias DiningPhilosophers.Activity
    require Logger

    defmodule Philosopher do
      defstruct name: nil, ate: 0, thunk: 0
    end

    def simulate(observer) do
      chopsticks = [:chopstick1, :chopstick2, :chopstick3, :chopstick4, :chopstick5]

      table = spawn_link(Table, :manage_resources, [chopsticks])

      philosophers = []

      philosophers = [spawn_link(Activity, :dine, [%Philosopher{name: "Aristotle"}, table])| philosophers]
      philosophers = [spawn_link(Activity, :dine, [%Philosopher{name: "Kant"     }, table])| philosophers]
      philosophers = [spawn_link(Activity, :dine, [%Philosopher{name: "Spinoza"  }, table])| philosophers]
      philosophers = [spawn_link(Activity, :dine, [%Philosopher{name: "Marx"     }, table])| philosophers]
      philosophers = [spawn_link(Activity, :dine, [%Philosopher{name: "Russell"  }, table])| philosophers]

      send(observer, {:philosophers, philosophers})
    end

    def manage_resources(chopsticks, waiting \\ []) do
      # If there are waiting fhilosophers...
      if length(waiting) > 0 do
        names = for {_, phil} <- waiting, do: phil.name
        Logger.debug "#{length waiting} philosopher#{if length(waiting) == 1, do: '', else: 's'} waiting: #{Enum.join names, ", "}"
        if length(chopsticks) >= 2 do
          [{pid, _} | waiting] = waiting
          [chopstick1, chopstick2 | chopsticks] = chopsticks
          send pid, {:eat, [chopstick1, chopstick2]}
        end
      end
      receive do
        {:sit_down, pid, phil} ->
          manage_resources(chopsticks, [{pid, phil} | waiting])
        {:give_up_seat, free_chopsticks, _} ->
          chopsticks = free_chopsticks ++ chopsticks
          Logger.debug "#{length chopsticks} chopstick#{if length(chopsticks) == 1, do: '', else: 's'} available"
          manage_resources(chopsticks, waiting)
      end
    end

  end

  defmodule Activity do
    alias Table.Philosopher
    require Logger

    def dine(phil = %Philosopher{ate: ate, thunk: thunk}, table) do
      send table, {:sit_down, self(), phil}
      receive do
        {:eat, chopsticks} ->
          phil = eat(phil, chopsticks, table)
          phil = think(phil, table)
        {:observe, observer} ->
          send observer, {ate, thunk}
      end
      dine(phil, table)
    end

    def eat(phil, chopsticks, table) do
      phil = %{phil | ate: phil.ate + 1}
      Logger.debug "#{phil.name} is eating (count: #{phil.ate})"
      :timer.sleep(:rand.uniform(1000))
      Logger.debug "#{phil.name} is done eating"
      send table, {:give_up_seat, chopsticks, phil}
      phil
    end

    def think(phil, _) do
      Logger.debug "#{phil.name} is thinking (count: #{phil.thunk})"
      :timer.sleep(:rand.uniform(1000))
      %{phil | thunk: phil.thunk + 1}
    end

  end
end
