defmodule TaxParser do
  def parse(file) do
    File.stream!(file, [:read])
    |> map_rows
    |> calculate([ NC: 0.075, TX: 0.08 ])
  end

  defp prepare_headers(stream) do
    stream
    |> Enum.take(1)
    |> List.first
    |> String.split(",")
    |> Enum.map(&String.strip / 1)
    |> Enum.map(&String.to_atom / 1)
  end

  defp map_rows(stream) do
    stream
    |> Enum.drop(1)
    |> Enum.map(&String.trim_trailing / 1)
    |> Enum.map(&(String.split(&1, ",")))
    |> Enum.map(&convert_input_data / 1)
    |> Enum.map(&(to_keyword_list(&1, prepare_headers(stream))))
  end

  defp to_keyword_list(line, columns) do
    Enum.zip(columns, line)
  end

  defp convert_input_data([id, state, net_amount]) do
    [String.to_integer(id),
     String.to_atom(String.replace(state, ":", "")),
     String.to_float(net_amount)]
  end

  defp calculate(orders, tax_rates) do
    Enum.map(orders, &(add_tax(&1, tax_rates)))
  end

  defp add_tax(order = [id: _, ship_to: state_code, net_amount: net_price], tax_rates) do
    tax_rate = Keyword.get(tax_rates, state_code, 0)
    total_price = Float.floor((net_price + net_price * tax_rate), 2)
    Keyword.put_new(order, :total_amount, total_price)
  end
end

ExUnit.start

defmodule TaxParserTest do
  use ExUnit.Case

  test "returns total tax_rates" do
    tax_added = [[total_amount: 107.5, id: 123, ship_to: :NC, net_amount: 100.0],
                 [total_amount: 35.5,  id: 124, ship_to: :OK, net_amount: 35.5],
                 [total_amount: 25.92, id: 125, ship_to: :TX, net_amount: 24.0],
                 [total_amount: 48.38, id: 126, ship_to: :TX, net_amount: 44.8],
                 [total_amount: 26.87, id: 127, ship_to: :NC, net_amount: 25.0],
                 [total_amount: 10.0,  id: 128, ship_to: :MA, net_amount: 10.0],
                 [total_amount: 102.0, id: 129, ship_to: :CA, net_amount: 102.0],
                 [total_amount: 53.75, id: 120, ship_to: :NC, net_amount: 50.0]]
    expected = TaxParser.parse("payments.txt")
    assert expected == tax_added
  end
end
