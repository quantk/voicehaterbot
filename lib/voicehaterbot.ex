defmodule Voicehaterbot do
  use Application

  def start(_type, _args) do
    children = [
      {Scheduler, restart: :permanent}
    ]
    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
