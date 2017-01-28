fizz_buzz = fn
  {0, 0, _} -> IO.puts "FizzBuzz"
  {0, _, _} -> IO.puts "Fizz"
  {_, 0, _} -> IO.puts "Buzz"
  {_, _, n} -> IO.puts n
end

function_buzzer = fn n ->
  fizz_buzz.({rem(n, 3), rem(n, 5), n})
end

function_buzzer.(10)
function_buzzer.(11)
function_buzzer.(12)
function_buzzer.(13)
function_buzzer.(14)
function_buzzer.(15)
function_buzzer.(16)
