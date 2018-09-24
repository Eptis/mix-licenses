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

    packages_info =
      lock
      |> Map.keys()
      |> Enum.sort()
      |> Enum.map(fn name ->
        case :file.consult('./deps/' ++ Atom.to_charlist(name) ++ '/hex_metadata.config') do
          {:ok, config} ->
            config_to_license_info(config, name)

          {:error, _} ->
            [Atom.to_string(name), "Could not find license information"]
        end
      end)

    Mix.Tasks.Hex.print_table(["Dependency", "License"], packages_info)
  end

  @spec config_to_license_info([tuple], String.t()) :: [String.t()]
  defp config_to_license_info(config, name) do
    case Enum.find(config, fn {k, _v} -> k == "licenses" end) do
      {_, licenses} ->
        [Atom.to_string(name), Enum.join(licenses, ", ")]

      _other ->
        [Atom.to_string(name), "Could not find license information"]
    end
  end
end
