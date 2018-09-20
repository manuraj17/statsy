# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :statsy,
  token: System.get_env("SLACK_API_TOKEN"),
  status_channel: System.get_env("STATUS_CHANNEL") || "#status-updates",
  cowboy_port: System.get_env("PORT") || 3030
