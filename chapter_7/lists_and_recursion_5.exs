defmodule MyEnum do
  def all?(list), do: all?(list, fn x -> !!x end)
  def all?([], _fun), do: true
  def all?([head | tail], fun) do
    fun.(head) && all?(tail, fun)
  end

  def each([], _fun), do: :ok
  def each(array, fun) do
    for x <- array, do: fun.(x)
  end

  def filter([], _fun), do: []
  def filter([head | tail], fun) do
    if fun.(head) do
      [head | filter(tail, fun)]
    else
      filter(tail, fun)
    end
  end

  def split(list, 0), do: { [], list }
  def split([], _count), do: []
  def split([head | tail], count) do
    {left, right} = split(tail, count - 1)
    {[head | left], right}
  end

  def take(_, 0), do: []
  def take([head | tail], count), do: [head | take(tail, count - 1)]
end

ExUnit.start

defmodule MyEnumTest do
  use ExUnit.Case

  test "all? with numbers array returns true" do
    expected = MyEnum.all?([1, 2, 3, 4, 5], &(&1))
    assert expected
  end

  test "all? with booleans array returns true" do
    expected = MyEnum.all?([true, true, true, true], &(&1))
    assert expected
  end

  test "all? returns false" do
    expected = MyEnum.all?([1, 2, 3, 4, 5], &(&1 == 1))
    assert expected == false
  end

  test "all? with booleans array returns false" do
    expected = MyEnum.all?([true, true, false, true], &(&1 == 1))
    assert expected == false
  end

  test "each function is invoked and returns transformed array" do
    expected = MyEnum.each([1, 2, 3], &(&1 == 1))
    assert expected == [true, false, false]
  end

  test "each function is invoked on empty array" do
    expected = MyEnum.each([], &(&1 == 1))
    assert expected == :ok
  end

  test "filter returns matching elements" do
    expected = MyEnum.filter([1, 2, 3, 4, 5], &(&1 > 3))
    assert expected == [4, 5]
  end

  test "split cuts the collection in two on third position" do
    expected = MyEnum.split([1, 2, 3, 4, 5, 6], 3)
    assert expected == {[1, 2, 3], [4, 5, 6]}
  end

  test "split cuts the collection in two on 0 position" do
    expected = MyEnum.split([1, 2, 3, 4, 5, 6], 0)
    assert expected == {[], [1, 2, 3 ,4, 5, 6]}
  end

  test "split cuts ten fibonacci numbers list in two" do
    old_fibonacci = Stream.unfold({1, 1},
                                  fn {f1, f2} ->
                                    {f1, {f2, f1 + f2}}
                                  end)
    expected = MyEnum.split(Enum.take(old_fibonacci, 10), 5)
    assert expected == {[1, 1, 2, 3, 5], [8, 13, 21, 34, 55]}
  end

  test "take first item" do
    expected = MyEnum.take([1, 2, 3, 4, 5], 1)
    assert expected == [1]
  end

  test "take 3 items" do
    expected = MyEnum.take([1, 2, 3, 4, 5], 3)
    assert expected == [1, 2, 3]
  end
end
