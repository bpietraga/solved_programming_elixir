defimpl Inspect, for: Map do
  def inspect(map, _opts), do:
    Enum.reduce(map, "%{", &sygil_string(&1, &2)) <> "}"

  def inspect(struct, name, _opts) do
    Enum.reduce(Map.to_list(struct),
                "defmodule #{name} do defstruct ",
                &struct_string(&1, &2, "defmodule #{name} do defstruct "))
    <> " end"
  end

  defp sygil_string({key, value}, acc) when acc == "%{", do:
    acc <> "#{key}: #{value}"
  defp sygil_string({key, value}, acc), do:
    acc <> ", " <> "#{key}: #{value}"

  defp struct_string({key, value}, acc, module) when acc == module, do:
    acc <> "#{key}: #{value}"
  defp struct_string({key, value}, acc, _), do:
    acc <> ", " <> "#{key}: #{value}"
end

defmodule Blob, do: defstruct content: nil

ExUnit.start

defmodule InspectTest do
  use ExUnit.Case
  test "test code creation" do
    expected = Macro.to_string %Blob{content: 123}
    assert expected == "defmodule Blob do defstruct content: 123 end"
  end
end
