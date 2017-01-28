prefix = fn first_string ->
           fn second_string ->
             first_string  <> " " <> second_string
           end
         end

IO.puts prefix.("Elixir").("Rocks")

prefix_second_option = fn first_string ->
                         fn second_string ->
                           "#{first_string} #{second_string}"
                         end
                       end

IO.puts prefix_second_option.("That's").("right")
