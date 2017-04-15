defmodule Times do
  defmacro times_n(name_number) do
    quote do:
      def unquote(:"times_#{name_number}")(argument_integer), do:
        unquote(name_number) * argument_integer
  end
end

defmodule Test do
  require Times

  Times.times_n(3)
  Times.times_n(4)
end

ExUnit.start

defmodule TimesTest do
  import Times
  use ExUnit.Case

  test "times_3 called with 4 returns 12" do
    expected = Test.times_3(4)
    assert expected == 12
  end

  test "times_4 called with 5 returns 20" do
    expected = Test.times_4(5)
    assert expected == 20
  end
end
