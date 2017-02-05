defmodule DQS do
  def centrify(word_list) do
    max_length = (for x <- word_list, do: String.length(x)) |> Enum.max
    centered_words = for x <- word_list, do: center_word(x, max_length)
  end

  def puts_centrify(centered_words) do
    Enum.each(centered_words, &(IO.puts(&1)))
  end

  def center_word(word, max_length) do
    side_spaces_count = Kernel.div(max_length - String.length(word), 2)
    white_space = String.duplicate(" ", side_spaces_count)
    white_space <> word <> white_space
  end
end

ExUnit.start

defmodule DQSTest do
  use ExUnit.Case

  test "centrify returns list" do
    expected = DQS.centrify(["cat", "zebra", "elephant"])
    assert expected == ["  cat  ", " zebra ", "elephant"]
  end

  test "puts_centrify returns :ok" do
    expected = DQS.puts_centrify(["  cat  ", " zebra ", "elephant"])
    assert expected == :ok
  end
end
