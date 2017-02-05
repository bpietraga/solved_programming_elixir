defmodule MyString do
  def sentence_capitalize(string) do
    string
    |> String.split(". ")
    |> Enum.map(&(String.capitalize(&1)))
    |> Enum.join(". ")
  end
end

ExUnit.start

defmodule MyStringTest do
  use ExUnit.Case

  test "sentence_capitalize returns sentence_capitalized sentences" do
    expected = MyString.sentence_capitalize("oh. a DOG. woof. ")
    assert expected == "Oh. A dog. Woof. "
  end
end
