defmodule TestchatWeb.Channels.RoomChannel do
  use Phoenix.Channel
  require Logger

  def join("rooms:lobby", message, socket) do
    Process.flag(:trap_exit, true)
    :timer.send_interval(5000, :ping)
    send(self, {:after_join, message})
    {:ok, socket}
  end

  def join("rooms:" <> _private_subtopic, _message, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info({:after_join, msg}, socket) do
    broadcast!(socket, "user:entered", %{user: msg["user"]})
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end

  def handle_info(:ping, socket) do
    push socket, "new:msg", %{user: "SYSTEM", body: "ping"}
    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug "> leave #{inspect reason}"
    :ok
  end

  def handle_in("ping", payload, socket) do
    # Logger.debug "ping test #{inspect payload}"
    # broadcast!(socket, "new:msg", %{user: "xxxx", body: "yyy"})
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("testmsg", payload, socket) do
    # Logger.debug "ping test #{inspect payload}"
    # broadcast!(socket, "new:msg", %{user: "xxxx", body: "yyy"})
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("new:msg", msg, socket) do
    Logger.debug "BC>> #{inspect msg}"
    broadcast!(socket, "new:msg", %{user: msg["user"], body: msg["body"]})
    #{:reply, {:ok, %{msg: msg["body"]}}, assign(socket, :user, msg["user"])}
    {:reply, {:ok, %{msg: msg["body"]}}, socket}
  end

end