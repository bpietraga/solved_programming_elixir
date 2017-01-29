defmodule MyList do
  def caesar([], _), do: []
  def caesar([ head | tail ], number) do
    [ 97 + rem(head + number - 97, 26), caesar(tail, number)]
  end
end

IO.puts MyList.caesar('ryvkve', 13) # Should be: 'elixir'
IO.puts MyList.caesar('ammj', 2) # Should be: 'cool'
