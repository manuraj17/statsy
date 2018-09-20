defmodule Statsy do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    token = Application.get_env(:statsy, :token)
    port = Application.get_env(:statsy, :cowboy_port)

    children = [
      {Plug.Adapters.Cowboy2, scheme: :http, plug: Statsy.Server, options: [port: port]},
      worker(Slack.Bot, [Statsy.Bot, [], token, %{ name: Statsy.Bot} ])
    ]

    Supervisor.start_link(children, [strategy: :one_for_one, name: Statsy.Supervisor])
  end
end
