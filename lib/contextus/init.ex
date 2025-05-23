defmodule Contextus.Init do
  @moduledoc """
  Initialization module for Contextus.
  """

  require Logger
  alias Contextus.Init.Config

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
        case Config.create_standard_config(dir) do
          :ok -> :ok
          {:error, :config_exists} ->
            IO.puts("Configuration already exists in #{dir}")
            :error
          {:error, :permission_denied} ->
            IO.puts("Permission denied while creating configuration in #{dir}")
            :error
          {:error, reason} ->
            IO.puts("Error creating configuration: #{inspect(reason)}")
            :error
        end
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
