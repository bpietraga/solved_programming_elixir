fizz_buzz = fn
  {0, 0, _} -> IO.puts "FizzBuzz"
  {0, _, _} -> IO.puts "Fizz"
  {_, 0, _} -> IO.puts "Buzz"
  {_, _, n} -> IO.puts n
end

IO.puts "All zeros:"
fizz_buzz.({0,0,0})

IO.puts "First zero:"
fizz_buzz.({0,1,1})

IO.puts "No zeros:"
fizz_buzz.({1,1,1})

IO.puts "Text"
fizz_buzz.({"test", "macht", "Spaß"})
