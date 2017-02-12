defmodule CracowWeather.WeatherFetcher do
  require Logger

  @weather_api_url Application.get_env(:cracow_weather, :weather_api_url)

  @doc """
  Issues get request to XML Weather API and
  returns tuple with status and message
  """
  def fetch do
    Logger.info "Fetching Cracow weather"
    @weather_api_url
    |> HTTPoison.get
    |> handle_response
  end

  @doc """
  Handle response from XML API and log action
  """
  def handle_response({:ok, %{status_code: 200, body: body}}) do
    Logger.info "Successful response"
    {:ok, body}
  end
  def handle_response({_, %{status_code: status, body: body}}) do
    Logger.error "Error #{status} returned"
    {:error, body}
  end
end
