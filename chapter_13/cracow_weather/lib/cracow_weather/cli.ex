defmodule CracowWeather.CLI do
  import CracowWeather.WeatherFetcher, only: [fetch: 0]
  import CracowWeather.TableFormmater, only: [print_to_terminal: 1]

  @doc """
  Starts all flow and prints current weather status to terminal.
  """
  def main([]), do: main()
  def main do
    fetch()
    |> decode_response
    |> prepare_map
    |> print_to_terminal
  end

  @doc """
  Returns full body is response is ok, logs error if code is not 200
  """
  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching weather: #{message}"
    System.halt(2)
  end

  @doc """
  Prepares map with current weather data parsed from XML response
  """
  def prepare_map(xml) do
    Map.new([city: city_name(xml),
             temperature: forecast(xml),
             sky: sky(xml)])
  end

  @doc """
  Parses XML response and returns city name
  """
  defp city_name(xml) do
    [city_name] = Friendly.find(xml, "name")
    city_name[:text]
  end

  @doc """
  Parses XML response and returns current temperature
  """
  defp forecast(xml) do
    forecast = List.first Friendly.find(xml, "temperature")
    forecast[:attributes]["value"]
  end

  @doc """
  Parses XML response and returns current sky status
  """
  defp sky(xml) do
    sky_symbol = List.first Friendly.find(xml, "symbol")
    sky_symbol[:attributes]["name"]
  end
end
