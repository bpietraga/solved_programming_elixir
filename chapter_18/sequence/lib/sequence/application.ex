defmodule Sequence.Application do
  use Application

  def start(_type, _args) do
    {:ok, _pid} = Application.get_env(:sequence, :initial_number)
                  |> Sequence.Supervisor.start_link
  end
end
