defmodule Task4CPhoenixServerWeb.RobotChannela do
  use Phoenix.Channel
  use GenServer

  @doc """
  Handler function for any Client joining the channel with topic "robot:status".
  Subscribe to the topic named "robot:update" on the Phoenix Server using Endpoint.
  Reply or Acknowledge with socket PID received from the Client.
  """


  def join("robot:astatus", _params, socket) do
   Task4CPhoenixServerWeb.Endpoint.subscribe("robot:update")
    :ok = Phoenix.PubSub.subscribe(Task4CPhoenixServer.PubSub, "robot:astart")

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

  def handle_in("astart", msg, socket) do
    stringmap=get()
{:reply, {:ok, stringmap}, socket}
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
  def execute(list) do
    receive do
      {:get, sender} ->
        send(sender, list)
        execute(list)
    end
  end

  def get do
    Process.send_after(Storage, {:get, self()}, 100)
   msg = receive do
      msg -> msg
    end
    msg
  end



  def handle_info(data, socket) do
    list=[data["stringa"], data["stringb"]]

    process = spawn_link(fn -> execute(list) end)
   # Process.register(process, Storage)
     {:noreply, socket}
   end




  def handle_in("anew_msg", message, socket) do

    ax= cond do
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
    yay= cond do
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
    face_value=message["face"]
    is_obs_ahead = Task4CPhoenixServerWeb.FindObstaclePresence.is_obstacle_ahead?(message["x"], message["y"], message["face"])

            ox=cond do
        message["face"]=="east" ->
          ax+75
          message["face"]=="west" ->
            ax-75
            true->
              ax
                end
              oy=cond do
                message["face"]=="north" ->
                  yay+75
                  message["face"]=="south" ->
                    yay-75
                    true->
                      yay
                    end

                #Task4CPhoenixServerWeb.Endpoint.broadcast("robot:obs", "op", %{"obs" => "true", "left" => x, "bottom" => y, "face" => face_value})
                #  Phoenix.PubSub.broadcast_from!(Task4CPhoenixServer.PubSub, self(), "robot:obs", %{"obs" => "true", "left" => x, "bottom" => y, "face" => face_value})
                [sow, weed]=getgoal()
          #      %{"obs" => is_obs_aheadb, "ox" => oxb, "oy" => oyb, "leftb" => bx, "bottomb" => bay, "faceb" => face_valueb}=comget()
 #   if message["client"] == "robot_A" do
   # Task4CPhoenixServerWeb.Endpoint.broadcast("robot:update","update", %{"client" => "robot_A", "left" => ax, "bottom" => yay, "face" => face_value})
   Phoenix.PubSub.broadcast_from!(Task4CPhoenixServer.PubSub, self(), "robot:update", %{"client" => "robot_A", "left" => ax, "bottom" => yay, "face" => face_value, "obs" => is_obs_ahead, "ox" => ox, "oy" => oy, "ga" => sow, "gb" => weed})
  # else
 #   Phoenix.PubSub.broadcast_from!(Task4CPhoenixServer.PubSub, self(), "robot:update", %{"client" => "robot_B", "leftb" => ax, "bottomb" => yay, "faceb" => face_valueb, "obs" => is_obs_ahead, "ox" => ox, "oy" => oy, "gb" => weed})

     # Task4CPhoenixServerWeb.Endpoint.broadcast("robot:update","update", %{"client" => "robot_B", "left" => ax, "bottom" => yay, "face" => face_value})
 #   end
    # determine the obstacle's presence in front of the robot and return the boolean value


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
