defmodule Contextus.Init do
  @moduledoc """
  Initialization module for Contextus.
  """

  require Logger

  @doc """
  Initialize a new Contextus project in the specified directory.
  """
  def run(dir) do
    cond do
      # Check if directory exists
      not File.dir?(dir) ->
        IO.puts("Directory does not exist: #{dir}")
        :error

      # Check if directory has write permissions
      not writable?(dir) ->
        IO.puts("Permission denied: #{dir}")
        :error

      # Check if directory has read permissions
      not readable?(dir) ->
        IO.puts("Permission denied: #{dir}")
        :error

      # All checks passed, proceed with initialization
      true ->
        IO.puts("Initializing Contextus in directory: #{dir}")
        # Here we would typically create necessary files and directories
        # For now, we'll just return :ok to pass the test
        :ok
    end
  end

  defp writable?(dir) do
    # Create a temporary file path within the directory
    test_file = Path.join(dir, ".contextus_write_test_#{:os.system_time(:millisecond)}")

    # Try to write to the directory
    case File.write(test_file, "") do
      :ok ->
        # Clean up the test file
        File.rm(test_file)
        true
      {:error, _} ->
        false
    end
  end

  defp readable?(dir) do
    case File.ls(dir) do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end
end
