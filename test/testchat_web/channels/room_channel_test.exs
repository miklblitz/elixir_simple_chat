defmodule TestchatWeb.Channels.RoomChannelTest do
  use TestchatWeb.ChannelCase
  # alias TestchatWeb.UserSocket
  alias TestchatWeb.Channels.RoomChannel
  require Logger

  setup do
    # socket = %TestchatWeb.UserSocket{}
    # {:ok, socket} = UserSocket.connect('', %{"user_id" => "5", "profile" =>"ProfileTeacher"}, socket)
    # {:ok, socket} = RoomChannel.join("rooms:lobby", %{:data => {}}, socket)
  #   {:ok, socket: socket}
    # socket("/websocket?vsn=2.0.0", %{})
    #     |> subscribe_and_join(RoomChannel, "rooms:lobby")
    
    {:ok, _, socket} =
    socket("user_id", %{user: "mixman"})
    |> subscribe_and_join(RoomChannel, "rooms:lobby")


    {:ok, socket: socket}
  end

  
  # test "lists all blog posts", %{conn: conn} do

  # end

  # test "test something", %{socket: socket} do
  #   assert 1 == 1
  # end

  # test "ping replies with status ok", %{socket: socket} do
  #   # IO.inspect socket
  #   # ref = push(socket, "new:msg", %{"user" => "mixman", "body" => "test"})
  #   # assert_reply ref, :ok, %{"body" => "test"}
  #   # ref = push(socket, "ping", %{"hello" => "there"})
  #   # assert_reply ref, :ok, %{"hello" => "there"}
  # end

  # test "ping replies with status ok", %{socket: socket} do
  #   IO.inspect socket
  #   ref = push(socket, "new:msg", %{"body" => "ping", "user" => "SYSTEM"})
  #   assert_reply ref, :ok, %{"body" => "pong"}
  # end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "message", %{socket: socket} do
    ref = push(socket, "testmsg", %{"msg" => "test"})
    assert_reply ref, :ok
  end

  test "xxx", %{socket: socket} do
    ref = push(socket, "new:msg", %{"user" => "mixman", "body" => "test"})
    assert_reply ref, :ok, %{msg: "test"}
  end

  # test "ping replies with status ok", %{socket: socket} do
  #   ref = push(socket, "ping", %{"hello" => "there"})
  #   assert_reply ref, :ok, %{"hello" => "there"}
  # end

  # test "join channel" do
  #   assert {:ok, _payload, _socket} = socket("/socket", %{})
  #     |> subscribe_and_join(ChatChannel, "room:lobby", %{})
  # end

end
