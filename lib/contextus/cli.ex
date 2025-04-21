defmodule Contextus.CLI do
  @moduledoc """
  Command Line Interface for Contextus
  """

  require Logger

  @doc """
  Entry point for the command line interface.
  """
  def main(args) do
    args
    |> parse_args()
    |> run()
  end

  @doc """
  Parse command line arguments.

  ## Examples

      iex> Contextus.CLI.parse_args(["init", "."])
      {:ok, {:init, "."}}

      iex> Contextus.CLI.parse_args(["init"])
      {:error, :missing_dir}

      iex> Contextus.CLI.parse_args(["foo", "bar"])
      {:error, :unknown_command, "foo"}

  """
  def parse_args(["init", dir]) do
    {:ok, {:init, dir}}
  end

  def parse_args(["init"]) do
    {:error, :missing_dir}
  end

  def parse_args([unknown_command | _]) do
    {:error, :unknown_command, unknown_command}
  end

  def parse_args(_args) do
    {:error, :unknown_command, nil}
  end

  @doc """
  Run the command based on parsed arguments.
  """
  def run({:ok, {:init, dir}}) do
    Contextus.Init.run(dir)
  end

  def run({:error, :missing_dir}) do
    IO.puts("Usage: contextus init <directory>")
  end

  def run({:error, :unknown_command, command}) do
    IO.puts("Unknown command: #{command}")
  end

  def run(_) do
    IO.puts("Usage: contextus <command> [arguments]")
  end
end
