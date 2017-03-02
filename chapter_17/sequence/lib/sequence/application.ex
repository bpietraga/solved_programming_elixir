defmodule Sequence.Application do
  use Application

  def start(_type, _args), do:
    {:ok, _pid} = Sequence.Supervisor.start_link(123)
end
