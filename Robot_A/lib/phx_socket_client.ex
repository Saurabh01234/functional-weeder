defmodule Task4CClientRobotA.PhoenixSocketClient do

  alias PhoenixClient.{Socket, Channel, Message}

  @doc """
  Connect to the Phoenix Server URL (defined in config.exs) via socket.
  Once ensured that socket is connected, join the channel on the server with topic "robot:status".
  Get the channel's PID in return after joining it.

  NOTE:
  The socket will automatically attempt to connect when it starts.
  If the socket becomes disconnected, it will attempt to reconnect automatically.
  Please note that start_link is not synchronous,
  so you must wait for the socket to become connected before attempting to join a channel.
  Reference to above note: https://github.com/mobileoverlord/phoenix_client#usage

  You may refer: https://github.com/mobileoverlord/phoenix_client/issues/29#issuecomment-660518498
  """
  def connect_server do
    socket_opts = [
      url: "ws://88b0-2401-4900-5aa6-28c3-589c-de49-4d2a-2a2e.ngrok.io:/socket/websocket"
    #  url: "ws://localhost:4000/socket/websocket"
    ]
    {:ok, socket} = PhoenixClient.Socket.start_link(socket_opts)

    socket=wait_until_connected(socket)

    {:ok, _response, channel} = PhoenixClient.Channel.join(socket, "robot:astatus")

    ###########################
    ## complete this funcion ##
    ###########################

  end
  defp wait_until_connected(socket) do
   socket= if !PhoenixClient.Socket.connected?(socket) do
      Process.sleep(100)
      wait_until_connected(socket)

      socket=socket
    end
  end
  @doc """
  Send Toy Robot's current status i.e. location (x, y) and facing
  to the channel's PID with topic "robot:status" on Phoenix Server with the event named "new_msg".

  The message to be sent should be a Map strictly of this format:
  %{"client": < "robot_A" or "robot_B" >,  "x": < x_coordinate >, "y": < y_coordinate >, "face": < facing_direction > }

  In return from Phoenix server, receive the boolean value < true OR false > indicating the obstacle's presence
  in this format: {:ok, < true OR false >}.
  Create a tuple of this format: '{:obstacle_presence, < true or false >}' as a return of this function.
  """
  def send_robot_status(channel, %Task4CClientRobotA.Position{x: x, y: y, facing: facing} = robot) do
    {:ok, is_obs_ahead}= PhoenixClient.Channel.push(channel, "event_msg", %{"event_id" => 1, "sender" => "A", "value" => %{"x" => x, "y" => y, "face" => facing}})

    {:obstacle_presence, is_obs_ahead}
    ###########################
    ## complete this funcion ##
    ###########################
    is_obs_ahead
  end
  def getstart(channel) do

    {:ok, %{"stringa" => r1, "stringb" => r2}}=PhoenixClient.Channel.push(channel, "astart", %{"client" => "robot_A"})

    r1

   end
   def endit(channel) do
    {:ok, en}=PhoenixClient.Channel.push(channel, "end", %{"client" => "robot_A"})
   end
   def getgoa(channel) do
    {:ok, [sow, _weed]}=PhoenixClient.Channel.push(channel, "give", %{"client" => "robot_A"})
    sow
   end
  ######################################################
  ## You may create extra helper functions as needed. ##
  ######################################################

end
