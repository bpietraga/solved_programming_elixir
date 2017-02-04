defmodule Primes do
  def to_number(to),
    do: _to_number(Enum.into(2..to, []))
  defp _to_number([]),
    do: []
  defp _to_number([head | tail]),
    do: [head | _to_number(for p <- tail, rem(p, head) != 0, do: p)]
end

ExUnit.start

defmodule MyListTest do
  use ExUnit.Case

  test "to_number returns list with only primes" do
    expected = Primes.to_number(10)
    assert expected == [2, 3, 5, 7]
  end
end
