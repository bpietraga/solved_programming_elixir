defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_) -> "I don't know you"
    end
  end
end

mr_sandwich = Greeter.for("Sandwich", "Mr" )

IO.puts mr_sandwich.("Sandwich")
IO.puts mr_sandwich.("Potato")
