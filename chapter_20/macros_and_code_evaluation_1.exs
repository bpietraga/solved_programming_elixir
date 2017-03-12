defmodule My do
  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(do_clause)
        _                            -> unquote(else_clause)
      end
    end
  end
end

ExUnit.start

defmodule MyTest do
 use ExUnit.Case
 import ExUnit.CaptureIO
 import My

  test "unless works as expected" do
    expected = My.unless 1 != 1 do
      "works"
    else
      "error"
    end
    assert expected == "works"
  end
end
