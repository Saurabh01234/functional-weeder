defmodule Task4CPhoenixServerWeb.RobotChannel do
  use Phoenix.Channel
  use GenServer

  @doc """
  Handler function for any Client joining the channel with topic "robot:status".
  Subscribe to the topic named "robot:update" on the Phoenix Server using Endpoint.
  Reply or Acknowledge with socket PID received from the Client.
  """



  def join("robot:status", _params, socket) do
    Task4CPhoenixServerWeb.Endpoint.subscribe("robot:update")
     :ok = Phoenix.PubSub.subscribe(Task4CPhoenixServer.PubSub, "robot:bstart")

     {:ok, socket}
   end
  @doc """
  Callback function for messages that are pushed to the channel with "robot:status" topic with an event named "new_msg".
  Receive the message from the Client, parse it to create another Map strictly of this format:
  %{"client" => < "robot_A" or "robot_B" >,  "left" => < left_value >, "bottom" => < bottom_value >, "face" => < face_value > }

  These values should be pixel locations for the robot's image to be displayed on the Dashboard
  corresponding to the various actions of the robot as recevied from the Client.

  Broadcast the created Map of pixel locations, so that the ArenaLive module can update
  the robot's image and location on the Dashboard as soon as it receives the new data.

  Based on the message from the Client, determine the obstacle's presence in front of the robot
  and return the boolean value in this format {:ok, < true OR false >}.

  If an obstacle is present ahead of the robot, then broadcast the pixel location of the obstacle to be displayed on the Dashboard.
  """


  def handle_in("bstart", msg, socket) do

    stringsmap=bget()

    {:reply, {:ok, stringsmap}, socket}
      end
  def handle_in("end", msg, socket) do

    Task4CPhoenixServerWeb.Endpoint.broadcast("timer:stop", "stop_timer", %{})
    {:reply, {:ok, :end}, socket}
      end
      def trying() do
        receive do
          {:get, stringmap} ->
            stringmap
            trying()
            stringmap
        end
      end

  def bexecute(list) do
    receive do
      {:get, sender} ->
        send(sender, list)
        bexecute(list)
    end
  end


  def bget do
    Process.send_after(Btorage, {:get, self()}, 100)
   msg = receive do
      msg -> msg
    end
    msg
  end


  def handle_info(data, socket) do
   list=[data["stringa"], data["stringb"]]

   process = spawn_link(fn -> bexecute(list) end)
   #Process.register(process, Btorage)
    {:noreply, socket}
  end


  def handle_in("bnew_msg", message, socket) do


    [bx, bay, face_valueb]=if message["client"] == "robot_B" do
      bx= cond do
        message["x"]==1 ->
          ax=0
          message["x"]==2 ->
            ax=150
            message["x"]==3 ->
              ax=300
              message["x"]==4 ->
                ax=450
                message["x"]==5 ->
                  ax=600
                  message["x"]==6 ->
                    ax=750
      end
      bay= cond do
        message["y"]=="a" ->
          yay=0
          message["y"]=="b" ->
            yay=150
            message["y"]=="c" ->
              yay=300
              message["y"]=="d" ->
                yay=450
                message["y"]=="e" ->
                  yay=600
                  message["y"]=="f" ->
                    ax=750
      end
      face_valueb=message["face"]
      [bx, bay, face_valueb]
    end

    is_obs_ahead = Task4CPhoenixServerWeb.FindObstaclePresence.is_obstacle_ahead?(message["x"], message["y"], message["face"])

            ox=cond do
        message["face"]=="east" ->
          bx+75
          message["face"]=="west" ->
            bx-75
            true->
              bx
                end
              oy=cond do
                message["face"]=="north" ->
                  bay+75
                  message["face"]=="south" ->
                    bay-75
                    true->
                      bay
                    end

                            [sow, weed]=getgoal()

   # if message["client"] == "robot_A" do
   # Task4CPhoenixServerWeb.Endpoint.broadcast("robot:update","update", %{"client" => "robot_A", "left" => ax, "bottom" => yay, "face" => face_value})
   #Phoenix.PubSub.broadcast_from!(Task4CPhoenixServer.PubSub, self(), "robot:update", %{"obs" => is_obs_ahead, "ox" => ox, "oy" => oy, "leftb" => bx, "bottomb" => bay, "faceb" => face_valueb})
  # else
    Phoenix.PubSub.broadcast_from!(Task4CPhoenixServer.PubSub, self(), "robot:update", %{"client" => "robot_B", "leftb" => bx, "bottomb" => bay, "faceb" => face_valueb, "obsb" => is_obs_ahead, "oxb" => ox, "oyb" => oy, "gb" => weed, "ga" => sow})

     # Task4CPhoenixServerWeb.Endpoint.broadcast("robot:update","update", %{"client" => "robot_B", "left" => ax, "bottom" => yay, "face" => face_value})
   # end
    # determine the obstacle's presence in front of the robot and return the boolean value
  #  process = spawn_link(fn -> communicate(%{"obs" => is_obs_ahead, "ox" => ox, "oy" => oy, "leftb" => bx, "bottomb" => bay, "faceb" => face_valueb}) end)
   # Process.register(process, Come)
#
    # file object to write each action taken by each Robot (A as well as B)
    {:ok, out_file} = File.open("task_4c_output.txt", [:append])
    # write the robot actions to a text file
    IO.binwrite(out_file, "#{message["client"]} => #{message["x"]}, #{message["y"]}, #{message["face"]}\n")

    ###########################
    ## complete this funcion ##
    ###########################

    {:reply, {:ok, is_obs_ahead}, socket}
  end

  def handle_in("give", message, socket) do
    listoflist=getgoal()
{:reply, {:ok, listoflist}, socket}
  end
  def getgoal do

    goal_data = File.stream!("Plant_Positions.csv") |> CSV.decode! |> Enum.take(25)
  goal_data=tl(goal_data)
  sow=Enum.map(goal_data, fn [a, _b] ->  String.to_integer(a) end)
  weed=Enum.map(goal_data, fn [_a, b] ->  String.to_integer(b) end)
  [sow, weed]

    end
  #########################################
  ## define callback functions as needed ##
  #########################################

end
