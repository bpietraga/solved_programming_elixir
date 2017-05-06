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
  def encrypt_char(32, _shift), do:
    32
  # Question mark for not matched char
  def encrypt_char(_, _shift) do
    63
  end
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

defmodule CaesarMacChecker do
  def run do
    mac_words = macintosh_dictionary()
    inspect_words(mac_words, sorted_words(mac_words))
  end

  defp inspect_words(mac_words, words_by_size) do
    Enum.each(mac_words, &match_word(&1, words_by_size))
  end

  defp match_word(word, words_by_size) do
    encrypted = CaesarSalad.rot13(word)
    case MapSet.member?(words_by_size[byte_size(word)], encrypted) do
      true ->
         IO.puts "#{word} is equal #{encrypted}"
      _ ->
        nil
    end
  end

  defp macintosh_dictionary do
    File.stream!("/usr/share/dict/words", [:read, :utf8], :line)
    |> Enum.map(&String.rstrip(&1) |> String.downcase)
  end

  defp sorted_words(words) do
    for {length, word_group} <- Enum.group_by(words, &byte_size/1), into: Map.new do
      {length, Enum.into(word_group, MapSet.new)}
    end
  end
end

CaesarMacChecker.run
