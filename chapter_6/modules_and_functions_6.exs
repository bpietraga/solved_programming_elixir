defmodule Chop do
  def guess(number, _, number), do: IO.puts "Found it! Number is: #{number}"

  def guess(number, low.._, guess) when guess > number do
    IO.puts "Guess: #{guess} is too high"
    guess(number, low..guess - 1)
  end

  def guess(number, _..high, guess) when guess < number do
    IO.puts "Guess: #{guess} is too low"
    guess(number, guess + 1..high)
  end

  def guess(number, low..high) do
    guess = div(low + high, 2)
    guess(number, low..high, guess)
  end
end

Chop.guess(273, 1..1000)
