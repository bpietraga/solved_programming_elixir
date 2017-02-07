defmodule FizzBuzz do
  def up_to(n), do:
    Enum.map(1..n, &fizz_buzz/1)

  defp fizz_buzz(n) do
    case {rem(n, 3), rem(n, 5), n} do
      {0, 0, _} -> "FizzBuzz"
      {0, _, _} -> "Fizz"
      {_, 0, _} -> "Buzz"
      {_, _, n} -> n
    end
  end
end

ExUnit.start

defmodule FizzBuzzTest do
  use ExUnit.Case

  test "up_to 1" do
    expected = FizzBuzz.up_to(1)
    assert expected == [1]
  end

  test "up_to 10" do
    expected = FizzBuzz.up_to(10)
    assert expected == [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz"]
  end
end
