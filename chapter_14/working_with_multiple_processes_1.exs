# Exercises 1 from chapter 14.
# Results from Macbook Pro Retina 15" 2012 running elixir 1.4

# elixir -r chain.ex  -e "Chain.run(10)"
{3383, "Result is 10"}

# elixir -r chain.ex  -e "Chain.run(100)"
{3595, "Result is 100"}

# elixir -r chain.ex  -e "Chain.run(1_000)"
{11614, "Result is 1000"}

# elixir -r chain.ex  -e "Chain.run(10_000)"
{89265, "Result is 10000"}

# elixir -r chain.ex -e "Chain.run(400_00)"
{337519, "Result is 40000"}

# elixir --erl "+P 1000000" -r chain.ex -e "Chain.run(1_000_000)"
{7283403, "Result is 1000000"}
