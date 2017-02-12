defmodule TableFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias CracowWeather.TableFormmater, as: TF

  def simple_test_data, do:
    Map.new([city: "Cracow", temperature: "-10", sky: "Clear sky"])

  test "output is correct" do
    result = capture_io fn ->
      TF.print_to_terminal(simple_test_data())
    end

    assert result == """
    ------------------------------------------------------
    \s\sLatest weather report
    \s\s\s\scity:        Cracow
    \s\s\s\ssky:         Clear sky
    \s\s\s\stemperature: -10
    \s\s\s\sunit:        Celsius
    ------------------------------------------------------\n
    """
  end
end
