ExUnit.start

defmodule StringsAndBinariesTest do
  use ExUnit.Case

  test "not flat list" do
    expected = ['dog' | 'cat']
    assert expected == ['dog', 99, 97, 116]
  end

  test "flat list" do
    expected = List.flatten(['dog' | 'cat'])
    assert expected == 'dogcat'
  end
end
