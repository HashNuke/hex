defmodule Mix.Tasks.Hex.ConfigTest do
  use HexTest.Case

  test "config" do
    in_tmp fn ->
      Hex.home(System.cwd!)

      assert_raise Mix.Error, "Config does not contain a key foo", fn ->
        Mix.Tasks.Hex.Config.run(["foo"])
      end

      Mix.Tasks.Hex.Config.run(["foo", "bar"])
      Mix.Tasks.Hex.Config.run(["foo"])
      assert_received {:mix_shell, :info, ["\"bar\""]}
    end
  end

  test "direct api" do
    in_tmp fn ->
      Hex.home(System.cwd!)
      assert Hex.Config.read == []

      Hex.Config.update([key: "value"])
      assert Hex.Config.read == [key: "value", source: :elixir]

      Hex.Config.update([key: "other", foo: :bar])
      assert Hex.Config.read == [key: "other", foo: :bar, source: :elixir]
    end
  end
end
