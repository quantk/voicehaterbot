defmodule VoicehaterbotTest do
  use ExUnit.Case
  doctest Voicehaterbot

  test "greets the world" do
    assert Voicehaterbot.hello() == :world
  end
end
