defmodule CracowWeather.TableFormmater do
  @doc """
  Prints data to terminal from passed map
  """
  def print_to_terminal(weather_map) do
    weather_data = """
    ------------------------------------------------------
    \s\sLatest weather report
    \s\s\s\scity:        #{weather_map[:city]}
    \s\s\s\ssky:         #{weather_map[:sky]}
    \s\s\s\stemperature: #{weather_map[:temperature]}
    \s\s\s\sunit:        Celsius
    ------------------------------------------------------
    """
    IO.puts weather_data
  end
end
