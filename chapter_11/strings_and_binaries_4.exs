defmodule StringMath do
  def parse(string) do
    string
     |> Enum.reject(&(&1 == ?\s || &1 == ?\w))
     |> _parse([], 0)
     |> _calculate
  end

  defp _parse([], stack, value),
    do: stack ++ [value]
  defp _parse([char | tail], stack, value) when char in '0123456789',
    do: _parse(tail, stack, value * 10 + (char - ?0))
  defp _parse([operator | tail], stack, value) when operator in '+-*/' do
    operator_func = case operator do
      ?+ -> &+ / 2
      ?- -> &- / 2
      ?* -> &* / 2
      ?/ -> &/ / 2
    end

    _parse(tail, stack ++ [value, operator_func], 0)
  end

  defp _calculate([]),
    do: 0
  defp _calculate([result]),
    do: result
  defp _calculate([number_1, operator_func, number_2 | tail]),
    do: _calculate([operator_func.(number_1, number_2) | tail])
end

ExUnit.start

defmodule StringMathTest do
  use ExUnit.Case

  test "parse string and return equation number" do
    expected = StringMath.parse('123 + 27 * 4 / 2 - 1')
    assert expected == 299
  end

  test "parse string without white space and return equation number" do
    expected = StringMath.parse('123+27-50')
    assert expected == 100
  end
end

