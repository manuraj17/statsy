defmodule Statsy.Bot do
  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    IO.puts message.text
    IO.puts slack
    send_message("I got a message!", message.channel, slack)
    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}


  # Custome handle method to update status
  def handle_info({:update_status_afk, user_id, text}, slack, state) do
    status_channel = Application.get_env(:statsy, :status_channel)

    send_message("<@#{user_id}> is now AFK. #{String.capitalize text}", status_channel, slack)

    {:ok, state}
  end

  def handle_info({:update_status_back, user_id, text}, slack, state) do
    status_channel = Application.get_env(:statsy, :status_channel)

    send_message("<@#{user_id}> is now back. #{text}", status_channel, slack)

    {:ok, state}
  end

  def handle_info(_, _, state), do: {:ok, state}
end
