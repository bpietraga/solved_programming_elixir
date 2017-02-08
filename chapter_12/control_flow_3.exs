defmodule DataExtractor do
  def ok!({:ok, data}), do: data
  def ok!({_, error}),  do: raise error
end

ExUnit.start

defmodule DataExtractorTest do
  use ExUnit.Case

  test "ok! with vaild file" do
    expected = DataExtractor.ok! File.read("file.txt")
    assert expected == "This is test\n"
  end

  test "ok! with invaild file" do
    assert_raise UndefinedFunctionError, fn ->
      DataExtractor.ok! File.read("non-existent")
    end
  end
end
