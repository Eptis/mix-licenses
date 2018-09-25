# Mix Licenses

This package adds the task `mix deps.licenses` to your mix tasks. This can be used to print out a table of your mix.lock dependencies and the license they use. *This currently only works for dependencies* from Hex since it reads the license information from the `hex_metadata.config` files of your dependencies.

## Installation

The package can be installed by adding `mix_licenses` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mix_licenses, "~> 0.1.0", only: :dev}
  ]
end
```