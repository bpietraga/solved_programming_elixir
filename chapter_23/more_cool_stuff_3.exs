defmodule ParseSygil do
  def sigil_z(string, _options) do
    [header | rows] = String.split(string, "\n", trim: true)
    |> Enum.map &String.split(&1, ",", trim: true)

    csv_header = Enum.map(header, &String.to_atom/1)

    for row <- rows, do:
      List.zip([csv_header, Enum.map(row, &convert_to_float/1)])
  end

  defp convert_to_float(item) do
    case Float.parse(item) do
      {x, _} -> x
      _      ->
        case Integer.parse(item) do
          {x, _} -> x
          _      -> item
        end
    end
  end
end

ExUnit.start

defmodule ParseSygilTest do
  import ParseSygil
  use ExUnit.Case

  test "parse CSV like string" do
    expected = ~z"""
    Item,Qty,Price
    Teddy bear,4,34.95
    Milk,1,2.99
    Battery,6,8.00
    """

    assert expected == [
      [Item: "Teddy bear", Qty: 4, Price: 34.95],
      [Item: "Milk", Qty: 1, Price: 2.99],
      [Item: "Battery", Qty: 6, Price: 8.00]
    ]
  end
end
