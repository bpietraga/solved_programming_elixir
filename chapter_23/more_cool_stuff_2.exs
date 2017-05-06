defmodule ParseSygil do
  def sigil_z(lines, _options) do
    String.rstrip(lines)
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn x -> convert_to_number(x) end)
  end

  defp convert_to_number(column) do
    Enum.map(column, fn x ->
                       case Float.parse(x) do
                         {float, _} -> float
                         _          -> x
                       end
                     end)
  end
end

ExUnit.start

defmodule ParseSygilTest do
  import ParseSygil
  use ExUnit.Case

  test "parse CSV like string" do
    expected = ~z"""
    1,2,3
    cat,dog
    """

    assert expected == [[1.0, 2.0, 3.0], ["cat", "dog"]]
  end

end
