defmodule Mix.Tasks.Deps.Licenses do
  use Mix.Task
  alias Hex.Registry.Server, as: Registry

  @shortdoc "Lists license information for your dependencies"

  @moduledoc """
  Shows all Licenses for Hex dependencies of your application.
  """

  def run(_) do
    Hex.check_deps()
    Hex.start()
    Registry.open()

    lock = Mix.Dep.Lock.read()

    lock
    |> Hex.Mix.packages_from_lock()
    |> Hex.Registry.Server.prefetch()

    dep_names = Map.keys(lock)

    packages_info =
      dep_names
      |> Enum.sort()
      |> Enum.map(fn name ->
        case :file.consult('./deps/' ++ Atom.to_charlist(name) ++ '/hex_metadata.config') do
          {:ok, config} ->
            {_, licenses} = Enum.find(config, fn {k, _v} -> k == "licenses" end)
            [Atom.to_string(name), Enum.join(licenses, ", ")]

          {:error, _} ->
            Hex.Shell.error("Could not find license info for #{Atom.to_string(name)}. Perhaps you are getting it a different source than Hex?")
            nil
        end
      end)
      |> Enum.reject(&is_nil/1)

    Mix.Tasks.Hex.print_table(["Dependency", "License"], packages_info)
  end
end
