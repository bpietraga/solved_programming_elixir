defmodule MyList do
  def sum([]),              do: 0
  def sum([ head | tail ]), do: head + sum(tail)
end

IO.puts MyList.sum([1, 2, 3, 4, 5])
IO.puts MyList.sum([5431.243231, 1452431.421, 3412343.143, 344, 423.14125])
