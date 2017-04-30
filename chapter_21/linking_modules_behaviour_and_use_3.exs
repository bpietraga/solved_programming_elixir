defmodule Tracer do
  def dump_args(args) do
    args
    |> Enum.map(&inspect/1)
    |> Enum.join(", ")
  end

  def dump_defn(name, args), do:
    "#{name}(#{dump_args(args)})"

  defmacro def(definition = {:when, [{name, _, args}, _guard]}, do: content), do:
    traced_def(definition, name, args, content)
  defmacro def(definition = {name, _, args}, do: content), do:
    traced_def(definition, name, args, content)

  defp traced_def(definition, name, args, content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts """
         #{IO.ANSI.blue}\
         ==> method call: \
         #{IO.ANSI.green}\
         #{IO.ANSI.bright}\
         #{Tracer.dump_defn(unquote(name), unquote(args))}\
        """
        result = unquote(content)
        IO.puts "#{IO.ANSI.yellow}\ <== result: #{result}"
        result
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end
end

defmodule MathTracer do
  use Tracer

  def puts_sum_three(a, b, c), do:
    IO.inspect a + b + c

  def add_list(list), do:
    Enum.reduce(list, 0, &(&1 + &2))

  def is_one(x) when is_number(x) and x == 1, do:
    "It is one!"
end

ExUnit.start

defmodule MathTracerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "puts_sum_three" do
    messages_string = " \e[34m ==> method call:  \e"
      <> "[32m \e[1m puts_sum_three(1, 2, 3)\n6\n\e[33m <== result: 6\n"

    expected = capture_io fn ->
      MathTracer.puts_sum_three(1, 2, 3)
    end

    assert expected == messages_string
  end

  test "add_list" do

    messages_string = " \e[34m ==> method call:  \e[32m \e"
      <> "[1m add_list([1, 2, 3])\n\e[33m <== result: 6\n"

    expected = capture_io fn ->
      MathTracer.add_list([1, 2, 3])
    end

    assert expected == messages_string
  end
end
