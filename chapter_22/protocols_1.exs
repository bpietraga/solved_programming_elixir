defprotocol CaesarSalad do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl CaesarSalad, for: List do
  def encrypt(list, shift), do:
    list |> Enum.map(&encrypt_char(&1, shift))

  def rot13(list), do:
    encrypt(list, 13)

  def encrypt_char(char, shift) when char in 97..122, do:
    97 + rem(char + shift - 97, 26)
  def encrypt_char(char, shift) when char in 65..90, do:
    65 + rem(char + shift - 65, 26)
  def encrypt_char(char = 32, _shift), do:
    char
end

defimpl CaesarSalad, for: BitString do
  def encrypt(string, shift) do
    String.to_char_list(string)
    |> CaesarSalad.List.encrypt(shift)
    |> List.to_string
  end

  def rot13(string), do:
    encrypt(string, 13)
end

ExUnit.start

defmodule CaesarSaladTest do
  use ExUnit.Case

  test "list implementation" do
    expected = CaesarSalad.rot13("Space rocket")
    assert expected == "Fcnpr ebpxrg"
  end

  test "string implementation" do
    expected = CaesarSalad.rot13("Elixir rocks")
    assert expected == "Ryvkve ebpxf"
  end
end
