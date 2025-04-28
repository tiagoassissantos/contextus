# Contextus

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `contextus` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:contextus, "~> 0.1.0"}
  ]
end
```

## Usage

### Initialize a New Project

To initialize a new Contextus project in a directory, use:

```bash
contextus init <directory>
```

This command will:
- Create a `.contextus` directory in the specified location
- Set up the initial configuration structure:
  - `.contextus/config.json` - Main configuration file
  - `.contextus/data` - Directory for project data
  - `.contextus/logs` - Directory for project logs

The command will validate that:
- The specified directory exists
- You have read and write permissions for the directory
- No existing Contextus configuration is present

If any of these checks fail, the command will display an appropriate error message.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/contextus>.

