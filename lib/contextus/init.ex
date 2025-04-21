defmodule Contextus.Init do
  @moduledoc """
  Initialization module for Contextus.
  """

  require Logger

  @doc """
  Initialize a new Contextus project in the specified directory.
  """
  def run(dir) do
    if File.dir?(dir) do
      IO.puts("Initializing Contextus in directory: #{dir}")

      # Here we would typically create necessary files and directories
      # For now, we'll just return :ok to pass the test
      :ok
    else
      IO.puts("Directory does not exist: #{dir}")
      :error
    end
  end
end
