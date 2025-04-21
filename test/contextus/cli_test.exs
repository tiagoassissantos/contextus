defmodule Contextus.CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias Contextus.CLI

  describe "parse_args/1" do
    test "TC1: Parse valid init command" do
      assert CLI.parse_args(["init", "."]) == {:ok, {:init, "."}}
    end

    test "TC4: No directory argument" do
      assert CLI.parse_args(["init"]) == {:error, :missing_dir}
    end

    test "TC5: Unknown command" do
      assert CLI.parse_args(["foo", "bar"]) == {:error, :unknown_command, "foo"}
    end
  end

  describe "run/1" do
    test "TC2: Dispatch to init handler" do
      io = capture_io(fn ->
        assert CLI.run({:ok, {:init, "."}}) == :ok
      end)

      assert io =~ "Initializing Contextus in directory: ."
    end
  end

  describe "main/1" do
    test "TC3: End-to-end happy path" do
      io = capture_io(fn ->
        assert CLI.main(["init", "."]) == :ok
      end)

      assert io =~ "Initializing Contextus in directory: ."
    end

    test "handles missing directory argument" do
      io = capture_io(fn ->
        CLI.main(["init"])
      end)

      assert io =~ "Usage: contextus init <directory>"
    end

    test "handles unknown command" do
      io = capture_io(fn ->
        CLI.main(["foo", "bar"])
      end)

      assert io =~ "Unknown command: foo"
    end

    test "handles directory not existing" do
      io = capture_io(fn ->
        CLI.main(["init", "dir_not_exist"])
      end)

      assert io =~ "Directory does not exist: dir_not_exist"
    end
  end
end
