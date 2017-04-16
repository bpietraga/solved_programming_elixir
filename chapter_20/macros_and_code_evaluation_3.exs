defmodule MathParser do
  defmacro create(operator, name, from, by) do
    quote do
      def reason({unquote(operator), _, [left, right]})
        when is_number(left) and is_number(right), do:
          unquote(name) <> "#{right} " <> unquote(from) <> "#{left}"

      def reason({unquote(operator), _, [left, right]})
        when is_number(left), do:
          "#{reason right}, then " <> unquote(name) <> unquote(from) <> "#{left}"

      def reason({unquote(operator), _, [left, right]})
        when is_number(right), do:
          "#{reason left}, then " <> unquote(name) <> unquote(by) <> "#{right}"

      def reason({unquote(operator), _, [left, right]}) do
        "#{reason left}, then #{reason right}, than "
        <> String.rstrip(unquote(name))
      end
    end
  end
end

defmodule MathTranslator do
  require MathParser

  MathParser.create(:+, "add ",  "to ", "")
  MathParser.create(:-, "subtract ", "from ", "")
  MathParser.create(:*, "multiply ", "by ", "by ")
  MathParser.create(:/, "divide ", "into ", "by ")

  defmacro explain(n) when is_number(n), do:
    "#{n}"

  defmacro explain({:/, _, [0, 0]}), do:
    "Do not divide by 0"

  defmacro explain({operator, _, [left, right]}), do:
    reason({operator, nil, [left, right]})

  defmacro explain({operator, _, [n]}), do:
    "#{operator}#{n}"

  defmacro explain(_), do:
    "Please provide valid expression"
end

ExUnit.start

defmodule MathTranslatorTest do
  use ExUnit.Case
  import MathTranslator

  test "explain wrong expression" do
    expected = explain "invalid argument"
    assert expected == "Please provide valid expression"
  end

  test "explain 0 / 0" do
    expected = explain 0 / 0
    assert expected == "Do not divide by 0"
  end

  test "explain 0" do
    expected = explain 0
    assert expected == "0"
  end

  test "explain -1" do
    expected = explain -1
    assert expected == "-1"
  end

  test "explain 2 + 1" do
    expected = explain 2 + 1
    assert expected == "add 1 to 2"
  end

  test "explain 3 * 10 / 15 - 7" do
    expected = explain 3 * 10 / 15 - 7
    assert expected == "multiply 10 by 3, then divide by 15, then subtract 7"
  end
end
