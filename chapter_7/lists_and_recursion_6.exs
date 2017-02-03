defmodule MyList do
  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head),
    do: flatten(head) ++ flatten(tail)
  def flatten([head | tail]),
    do: [head] ++ flatten(tail)
end

ExUnit.start

defmodule MyListTest do
  use ExUnit.Case

  test "flatten returns uniq array with numbers" do
    expected = MyList.flatten([ 1, [ 2, 3, [4] ], 5, [[[6]]]])
    assert expected == [1, 2, 3, 4, 5, 6]
  end

  test "test" do
    expected = MyList.flatten([ "cat", [[], ["donkey"], [["java"]]], "dog"])
    assert expected == ["cat", "donkey", "java", "dog"]
  end
end
