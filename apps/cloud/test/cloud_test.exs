defmodule CloudTest do
  use ExUnit.Case
  doctest Cloud

  test "greets the world" do
    assert Cloud.hello() == :world
  end
end
