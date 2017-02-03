defmodule MyList do
  def span(from, to), do: Enum.into(from..to, [])
end

ExUnit.start

defmodule MyListTest do
  use ExUnit.Case

  test "span is true" do
    expected = MyList.span(1, 10)
    assert expected == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  test "span from 0 to 0 is true" do
    expected = MyList.span(0, 0)
    assert expected == [0]
  end

  test "span from -1 to 2 is true" do
    expected = MyList.span(-1, 2)
    assert expected == [-1, 0, 1, 2]
  end
end
