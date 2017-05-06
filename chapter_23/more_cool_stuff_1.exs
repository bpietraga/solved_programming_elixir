defmodule ParseSygil do
  def sigil_z(lines, _options) do
    String.rstrip(lines)
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
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

    assert expected == [["1", "2", "3"], ["cat", "dog"]]
  end

end
