defmodule MyString do
  def is_ascii?(string) do
    Enum.all?(Enum.map(string, &(&1 >= 32 && &1 <= 126)), &(&1 == true))
  end
end

ExUnit.start

defmodule MyStringTest do
  use ExUnit.Case

  test "is_ascii? returns true if string is printable ASCII only" do
    expected = MyString.is_ascii?('test')
    assert expected == true
  end

  test "is_ascii? returns false if string is with extended ASCII" do
    expected = MyString.is_ascii?('ƒŒ™¶Æ')
    assert expected == false
  end
end
