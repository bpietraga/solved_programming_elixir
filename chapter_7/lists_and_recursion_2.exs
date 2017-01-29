defmodule MyList do
  def max([]), do: 0
  def max([number]), do: number
  def max([ head | tail ]), do: Kernel.max(head, max(tail))
end

IO.puts MyList.max([142, 24213, 3231, 4, 524])
