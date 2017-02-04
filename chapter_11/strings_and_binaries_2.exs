defmodule MyString do
  def is_anagram?(first, second) do
    (first -- second) == '' && (second -- first) == ''
  end
end

ExUnit.start

defmodule MyStringTest do
  use ExUnit.Case

  test "is_anagram? returns true" do
    expected = MyString.is_anagram?('THE EYES', 'THEY SEE')
    assert expected == true
  end

  test "is_anagram? returns false" do
    expected = MyString.is_anagram?('butterfly', 'motylanoga')
    assert expected == false
  end
end
