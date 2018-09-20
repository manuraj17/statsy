defmodule Statsy.Server do
  use Plug.Router
  use Plug.Debugger

  require Logger
  require IEx

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug(Plug.Logger, log: :debug)

  plug(:match)
  plug(:dispatch)

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy2.http __MODULE__, []
  end

  post "/" do
    conn.body_params
    |> extract_info
    |> send_message

    send_resp(conn, 200, "Done")
  end

  defp extract_info(body_params) do
    %{"command" => command, "text" => text, "user_id" => user_id} = body_params
  end

  defp send_message(%{"user_id" => user_id, "command" => command, "text" => text}) do
    case command do
      "/afk" -> set_afk(user_id, text)
      "/back" -> set_back(user_id, text)
    end
  end

  defp set_afk(user_id, text) do
    send(Statsy.Bot, {:update_status_afk, user_id, text})
  end

  defp set_back(user_id, text) do
    send(Statsy.Bot, {:update_status_back, user_id, text})
  end
end
