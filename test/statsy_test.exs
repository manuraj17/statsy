defmodule StatsyTest do
  use ExUnit.Case
  doctest Statsy

  test "greets the world" do
    assert Statsy.hello() == :world
  end
end
