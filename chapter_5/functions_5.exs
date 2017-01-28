IO.inspect Enum.map [1,2,3,4,5], &(&1+ 2)
Enum.map [1,2,3,4,5], &(IO.inspect &1)
