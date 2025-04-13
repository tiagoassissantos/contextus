defmodule ContextusTest do
  use ExUnit.Case
  doctest Contextus

  test "greets the world" do
    assert Contextus.hello() == :world
  end
end
