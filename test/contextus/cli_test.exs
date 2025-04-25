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
      # Create a temporary directory for testing
      test_dir = "test_run_dir"
      File.rm_rf!(test_dir)
      File.mkdir_p!(test_dir)

      try do
        io = capture_io(fn ->
          assert CLI.run({:ok, {:init, test_dir}}) == :ok
        end)

        assert io =~ "Initializing Contextus in directory: #{test_dir}"
      after
        # Clean up
        File.rm_rf!(test_dir)
      end
    end
  end

  describe "main/1" do
    test "TC3: End-to-end happy path" do
      # Create a temporary directory for testing
      test_dir = "test_init_dir"
      File.rm_rf!(test_dir)
      File.mkdir_p!(test_dir)

      try do
        io = capture_io(fn ->
          assert CLI.main(["init", test_dir]) == :ok
        end)

        assert io =~ "Initializing Contextus in directory: #{test_dir}"
      after
        # Clean up
        File.rm_rf!(test_dir)
      end
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

    test "handles directory without write permissions" do
      # Create a temporary directory with read-only permissions for testing
      test_dir = "test_read_only_dir"
      File.mkdir_p!(test_dir)
      # Make the directory read-only (no write permissions)
      File.chmod!(test_dir, 0o444)

      try do
        io = capture_io(fn ->
          result = CLI.main(["init", test_dir])
          assert result == :error
        end)

        assert io =~ "Permission denied: #{test_dir}"
      after
        # Clean up: restore permissions and remove the directory
        File.chmod!(test_dir, 0o755)
        File.rm_rf!(test_dir)
      end
    end

    test "handles directory without read permissions" do
      # Create a temporary directory with write-only permissions for testing
      test_dir = "test_write_only_dir"
      File.mkdir_p!(test_dir)
      # Make the directory write-only (no read permissions)
      File.chmod!(test_dir, 0o222)

      try do
        io = capture_io(fn ->
          result = CLI.main(["init", test_dir])
          assert result == :error
        end)

        assert io =~ "Permission denied: #{test_dir}"
      after
        # Clean up: restore permissions and remove the directory
        File.chmod!(test_dir, 0o755)
        File.rm_rf!(test_dir)
      end
    end

    test "creates standard configuration structure" do
      # Create a temporary directory for testing
      test_dir = "test_config_dir"
      File.rm_rf!(test_dir)
      File.mkdir_p!(test_dir)

      try do
        io = capture_io(fn ->
          assert CLI.main(["init", test_dir]) == :ok
        end)

        assert io =~ "Initializing Contextus in directory: #{test_dir}"

        # Verify configuration structure
        config_dir = Path.join(test_dir, ".contextus")
        config_file = Path.join(config_dir, "config.json")
        data_dir = Path.join(config_dir, "data")
        logs_dir = Path.join(config_dir, "logs")

        assert File.exists?(config_dir)
        assert File.exists?(config_file)
        assert File.exists?(data_dir)
        assert File.exists?(logs_dir)

        # Verify config file content
        {:ok, config_content} = File.read(config_file)
        {:ok, parsed_config} = Jason.decode(config_content)

        assert Map.has_key?(parsed_config, "version")
        assert Map.has_key?(parsed_config, "project")
        assert Map.has_key?(parsed_config, "analysis")
        assert Map.has_key?(parsed_config, "storage")
      after
        # Clean up
        File.rm_rf!(test_dir)
      end
    end

    test "handles existing configuration" do
      test_dir = "test_existing_config_dir"
      File.rm_rf!(test_dir)
      File.mkdir_p!(test_dir)

      try do
        assert CLI.main(["init", test_dir]) == :ok

        io = capture_io(fn ->
          assert CLI.main(["init", test_dir]) == :error
        end)

        assert io =~ "Configuration already exists in #{test_dir}"
      after
        # Clean up
        File.rm_rf!(test_dir)
      end
    end

  end
end
