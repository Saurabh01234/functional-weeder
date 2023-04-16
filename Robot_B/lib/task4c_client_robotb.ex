defmodule Task4CClientRobotB do
  # max x-coordinate of table top
  @table_top_x 6
  # max y-coordinate of table top
  @table_top_y :f
  # mapping of y-coordinates
  @robotB_map_y_atom_to_num %{:a => 1, :b => 2, :c => 3, :d => 4, :e => 5, :f => 6}

    def lap(%Task4CClientRobotB.Position{x: x, y: y, facing: facing} = robotB, channel, goal_x, goal_y) do

      b=cond do
        robotB.y==:c ->
          b=3
          robotB.y==:b ->
            b=2
            robotB.y==:a ->
              b=1
              robotB.y==:d ->
                b=4
                robotB.y==:e ->
                  b=5
                  robotB.y==:f ->
                    b=6
       end
        robotB=if goal_x != robotB.x or b != goal_y do
       robotB=left(robotB)
      pd=self()
      pid=spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
      send(pd, {:obstacle_presence, fg}) end)
      Process.register(pid, :client_toyrobotB)
             fl = receive do
                {:obstacle_presence, ns} -> ns
                  end

                  robotB=cond do
                  fl==:true ->
                    robotB=lap(robotB, channel, goal_x, goal_y)

                    fl==:false ->
                      robotB=move(robotB)


                  pid=spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
      send(pd, {:obstacle_presence, fg}) end)
      Process.register(pid, :client_toyrobotB)
             q = receive do
                {:obstacle_presence, ns} -> ns
                  end

                  robotB=right(robotB)

                  pid=spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
      send(pd, {:obstacle_presence, fg}) end)
      Process.register(pid, :client_toyrobotB)
             lf = receive do
                {:obstacle_presence, ns} -> ns
                  end

                robotB=cond do
                  lf==:true  ->
                    robotB=lap(robotB, channel, goal_x, goal_y)
                    lf==:false ->
                      robotB=move(robotB)
                      pid=spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
                      send(pd, {:obstacle_presence, fg}) end)
                      Process.register(pid, :client_toyrobotB)
                             q = receive do
                                {:obstacle_presence, ns} -> ns
                                  end
                                  robotB=robotB
                  end
                end
              else robotB=robotB
            end
      end
      def taska(%Task4CClientRobotB.Position{x: x, y: y, facing: facing} = robotB, goal_x, goal_y, channel, goal_locs) do
        b=cond do
          robotB.y==:c ->
            b=3
            robotB.y==:b ->
              b=2
              robotB.y==:a ->
                b=1
                robotB.y==:d ->
                  b=4
                  robotB.y==:e ->
                    b=5
                    robotB.y==:f ->
                      b=6
         end
         pat=self()
        robotB = cond do
          (robotB.x < goal_x and robotB.facing != :east) ->
    robotB=if robotB.facing==:south do
    robotB=left(robotB)
    else

              robotB=right(robotB)
    end
           (robotB.x < goal_x and robotB.facing == :east) ->

                robotB=move(robotB)




           (robotB.x > goal_x and robotB.facing != :west) ->
            robotB=if robotB.facing==:south do
              robotB=right(robotB)
              else

                        robotB=left(robotB)
              end

              (robotB.x > goal_x and robotB.facing == :west) ->


                    robotB=move(robotB)
                  (b < goal_y and robotB.x == goal_x and robotB.facing != :north) ->

                    robotB=if robotB.facing==:east do
                      robotB=left(robotB)
                      else

                                robotB=right(robotB)
                      end

           (b < goal_y and robotB.facing == :north and robotB.x == goal_x) ->

                    robotB=move(robotB)
                  (b > goal_y and robotB.x == goal_x and robotB.facing != :south) ->

                    robotB=if robotB.facing==:west do
                      robotB=left(robotB)
                      else

                                robotB=right(robotB)
                      end
                (b > goal_y and robotB.facing == :south and robotB.x == goal_x) ->

                       robotB=move(robotB)


          true ->
           robotB=robotB
          end

           {:ok, robotB} = if(robotB.x != goal_x or b != goal_y) do
            stopB(robotB, goal_x, goal_y, channel, goal_locs)
             else
              pid = spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
              send(pat, {:obstacle_presence, fg}) end)
              Process.register(pid, :client_toyrobotB)
             l = receive do
                {:obstacle_presence, ns} -> ns
                  end
                  {:ok, robotB}
                    end
                  end

                  def taskb(%Task4CClientRobotB.Position{x: x, y: y, facing: facing} = robotB, goal_x, goal_y, channel, goal_locs) do
                    b=cond do
                      robotB.y==:c ->
                        b=3
                        robotB.y==:b ->
                          b=2
                          robotB.y==:a ->
                            b=1
                            robotB.y==:d ->
                              b=4
                              robotB.y==:e ->
                                b=5
                                robotB.y==:f ->
                                  b=6
                     end
                      pt=self()
                    robotB = cond do
                      (b < goal_y and robotB.facing != :north) ->
                        robotB=if robotB.facing==:west do
                          robotB=right(robotB)
                        else
                                                robotB=left(robotB)
                        end
                       (b < goal_y and robotB.facing == :north) ->

                            robotB=move(robotB)




                       (b > goal_y and robotB.facing != :south) ->

                        robotB=if robotB.facing==:east do
                          robotB=right(robotB)
                        else
                                                robotB=left(robotB)
                        end
                          (b > goal_y and robotB.facing == :south) ->
                                robotB=move(robotB)
                              (robotB.x < goal_x and b == goal_y and robotB.facing != :east) ->
                                robotB=if robotB.facing==:north do
                                  robotB=right(robotB)
                                else
                                                        robotB=left(robotB)
                                end

                       (robotB.x < goal_x and robotB.facing == :east and b == goal_y) ->

                                robotB=move(robotB)
                              (robotB.x > goal_x and b == goal_y and robotB.facing != :west) ->
                               robotB=if robotB.facing==:north do
                                  robotB=left(robotB)
                                else
                                                        robotB=right(robotB)
                                end
                            (robotB.x > goal_x and robotB.facing == :west and b == goal_y) ->

                                   robotB=move(robotB)


                      true ->
                        robotB=robotB

                    end
                    q=goal_x
          a=goal_y

                    {:ok, robotB} = if(robotB.x != q or b != a) do
                    stopB(robotB, goal_x, goal_y, channel, goal_locs)
                     else
                      pid = spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
                      send(pt, {:obstacle_presence, fg}) end)
                      Process.register(pid, :client_toyrobotB)
                     l = receive do
                        {:obstacle_presence, ns} -> ns
                          end
                          {:ok, robotB}
                            end
                          end

      def aap(%Task4CClientRobotB.Position{x: x, y: y, facing: facing} = robotB, channel, goal_x, goal_y) do

        b=cond do
          robotB.y==:c ->
            b=3
            robotB.y==:b ->
              b=2
              robotB.y==:a ->
                b=1
                robotB.y==:d ->
                  b=4
                  robotB.y==:e ->
                    b=5
                    robotB.y==:f ->
                      b=6
         end
         robotB=if goal_x != robotB.x or b != goal_y do
          robotB=right(robotB)
        pd=self()
        pid=spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
        send(pd, {:obstacle_presence, fg}) end)
        Process.register(pid, :client_toyrobotB)
               fl = receive do
                  {:obstacle_presence, ns} -> ns
                    end
                    robotB=cond do
                    fl==true ->
                      robotB=aap(robotB, channel, goal_x, goal_y)

                      fl==false ->
                        robotB=move(robotB)


                    pid=spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
        send(pd, {:obstacle_presence, fg}) end)
        Process.register(pid, :client_toyrobotB)
               q = receive do
                  {:obstacle_presence, ns} -> ns
                    end

                    robotB=left(robotB)

                    pid=spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
        send(pd, {:obstacle_presence, fg}) end)
        Process.register(pid, :client_toyrobotB)
               lf = receive do
                  {:obstacle_presence, ns} -> ns
                    end

                  robotB=cond do
                    lf==:true  ->
                      robotB=aap(robotB, channel, goal_x, goal_y)
                      lf==:false ->

                        robotB=move(robotB)

                        pid=spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
                        send(pd, {:obstacle_presence, fg}) end)
                        Process.register(pid, :client_toyrobotB)
                               q = receive do
                                  {:obstacle_presence, ns} -> ns
                                    end
                                    robotB=robotB
                    end
                  end
                else robotB=robotB
              end
        end

        def stop(%Task4CClientRobotB.Position{x: x, y: y, facing: facing} = robotB, goal_locs, channel) do


      goal=hd(goal_locs)
      goal_x=hd(goal)
      goal=tl(goal)
      goal_y=hd(goal)
      goal_locs=tl(goal_locs)
      {:ok, robotB}=stopB(robotB, goal_x, goal_y, channel, goal_locs)
  {:ok, robotB} = cond do
    goal_locs != [] ->
      stop(robotB, goal_locs, channel)
      true ->
        {:ok, en}=Task4CClientRobotB.PhoenixSocketClient.endit(channel)
        {:ok, robotB}
  end
        end

        def stopB(%Task4CClientRobotB.Position{x: x, y: y, facing: facing} = robotB, goal_x, goal_y, channel, goal_locs) do
          b=cond do
            robotB.y==:c ->
              b=3
              robotB.y==:b ->
                b=2
                robotB.y==:a ->
                  b=1
                  robotB.y==:d ->
                    b=4
                    robotB.y==:e ->
                      b=5
                      robotB.y==:f ->
                        b=6
           end
            parent=self()

          pid = spawn_link(fn -> fg = Task4CClientRobotB.PhoenixSocketClient.send_robot_status(channel, robotB)
          send(parent, {:obstacle_presence, fg}) end)
          Process.register(pid, :client_toyrobotB)

            fl = receive do
            {:obstacle_presence, ms} -> ms
              end

              {:ok, robotB}=cond do

                (fl==true and ((robotB.x==5 and robotB.facing==:south) or (robotB.x==1 and robotB.facing==:north) or (b==5 and robotB.facing==:east) or (b==1 and robotB.facing==:west))) ->
                 robotB = aap(robotB, channel, goal_x, goal_y)

                 {:ok, robotB}=if abs(robotB.x-goal_x) < abs(b-goal_y) do
                  taskb(robotB, goal_x, goal_y, channel, goal_locs)
                  else
                   taska(robotB, goal_x, goal_y, channel, goal_locs)
                  end
                  fl==false ->
                    robotB=robotB
                    {:ok, robotB}=taska(robotB, goal_x, goal_y, channel, goal_locs)
                    true ->
                   robotB = lap(robotB, channel, goal_x, goal_y)
                    {:ok, robotB}=if abs(robotB.x-goal_x) < abs(b-goal_y) do
                      taskb(robotB, goal_x, goal_y, channel, goal_locs)
                      else
                       taska(robotB, goal_x, goal_y, channel, goal_locs)
                      end
                    end
        end

  def place do
    {:ok, %Task4CClientRobotB.Position{}}
  end

  def place(x, y, _facing) when x < 1 or y < :a or x > @table_top_x or y > @table_top_y do
    {:failure, "Invalid position"}
  end

  def place(_x, _y, facing) when facing not in [:north, :east, :south, :west] do
    {:failure, "Invalid facing direction"}
  end

  @doc """
  Places the robotB to the provided position of (x, y, facing),
  but prevents it to be placed outside of the table and facing invalid direction.

  Examples:

      iex> Task4CClientRobotB.place(1, :b, :south)
      {:ok, %Task4CClientRobotB.Position{facing: :south, x: 1, y: :b}}

      iex> Task4CClientRobotB.place(-1, :f, :north)
      {:failure, "Invalid position"}

      iex> Task4CClientRobotB.place(3, :c, :north_east)
      {:failure, "Invalid facing direction"}
  """
  def place(x, y, facing) do
    {:ok, %Task4CClientRobotB.Position{x: x, y: y, facing: facing}}
  end

  @doc """
  Provide START position to the robotB as given location of (x, y, facing) and place it.
  """
  def start(x, y, facing) do
    place(x, y, facing)
  end

  @doc """
  Main function to initiate the sequence of tasks to achieve by the Client robotB B,
  such as connect to the Phoenix server, get the robotB B's start and goal locations to be traversed.
  Call the respective functions from this module and others as needed.
  You may create extra helper functions as needed.
  """
  def clean(string) do
    [x, y, face] = string
    |> String.downcase
    |> String.split(",")
    #|> Enum.map(fn(x) -> String.split(x, ",") end)

    [String.to_integer(x), String.to_atom(y), String.to_atom(face)]
   #gl=process_end_params(list)
    #sl=process_place_params(list)

  end
  def improve(atom) do

  y=cond do
    atom==:" c" ->
      b=:c
      atom==:" b" ->
        b=:b
       atom==:" a" ->
          b=:a
          atom==:" d" ->
            b=:d
            atom==:" e" ->
              b=:e
              atom==:" f" ->
                b=:f
   end
   y
  end
  def fi(atom) do
    facing=cond do
      atom==:" north" ->
        :north
        atom==:" south" ->
          :south
         atom==:" east" ->
            :east
            atom==:" west" ->
             :west
     end
     facing
  end
  def main do

    {:ok, _response, channel} = Task4CClientRobotB.PhoenixSocketClient.connect_server()

    sp=Task4CClientRobotB.PhoenixSocketClient.getstart(channel)

[x, y, facing]=clean(sp)
y=improve(y)
facing=fi(facing)
list=[x, y, facing]

{:ok, robotB}=start(x, y, facing)

    goals=Task4CClientRobotB.PhoenixSocketClient.getgoa(channel)
    goal_locs=Enum.map(goals, fn a -> transform(a) end)

    {:ok, robotB}=stop(robotB, goal_locs, channel)
    ###########################
    ## complete this funcion ##
    ###########################

  end
  def transform(a) do
    [x, y]= cond do
      rem(a,5)==0 ->
        y= div(a,5)
        [5, y]
        true ->
          x=rem(a,5)
          y= div(a,5)+1
  [x,y]
    end
    [x,y]
  end
  @doc """
  Provide GOAL positions to the robotB as given location of [(x1, y1),(x2, y2),..] and plan the path from START to these locations.
  Make a call to ToyrobotB.PhoenixSocketClient.send_robot_status/2 to get the indication of obstacle presence ahead of the robotB.
  """


  @doc """
  Provides the report of the robotB's current position

  Examples:

      iex> {:ok, robotB} = Task4CClientRobotB.place(2, :b, :west)
      iex> Task4CClientRobotB.report(robotB)
      {2, :b, :west}
  """
  def report(%Task4CClientRobotB.Position{x: x, y: y, facing: facing} = _robotB) do
    {x, y, facing}
  end

  @directions_to_the_right %{north: :east, east: :south, south: :west, west: :north}
  @doc """
  Rotates the robotB to the right
  """
  def right(%Task4CClientRobotB.Position{facing: facing} = robotB) do
    %Task4CClientRobotB.Position{robotB | facing: @directions_to_the_right[facing]}
  end

  @directions_to_the_left Enum.map(@directions_to_the_right, fn {from, to} -> {to, from} end)
  @doc """
  Rotates the robotB to the left
  """
  def left(%Task4CClientRobotB.Position{facing: facing} = robotB) do
    %Task4CClientRobotB.Position{robotB | facing: @directions_to_the_left[facing]}
  end

  @doc """
  Moves the robotB to the north, but prevents it to fall
  """
  def move(%Task4CClientRobotB.Position{x: _, y: y, facing: :north} = robotB) when y < @table_top_y do
    %Task4CClientRobotB.Position{ robotB | y: Enum.find(@robotB_map_y_atom_to_num, fn {_, val} -> val == Map.get(@robotB_map_y_atom_to_num, y) + 1 end) |> elem(0)
    }
  end

  @doc """
  Moves the robotB to the east, but prevents it to fall
  """
  def move(%Task4CClientRobotB.Position{x: x, y: _, facing: :east} = robotB) when x < @table_top_x do
    %Task4CClientRobotB.Position{robotB | x: x + 1}
  end

  @doc """
  Moves the robotB to the south, but prevents it to fall
  """
  def move(%Task4CClientRobotB.Position{x: _, y: y, facing: :south} = robotB) when y > :a do
    %Task4CClientRobotB.Position{ robotB | y: Enum.find(@robotB_map_y_atom_to_num, fn {_, val} -> val == Map.get(@robotB_map_y_atom_to_num, y) - 1 end) |> elem(0)}
  end

  @doc """
  Moves the robotB to the west, but prevents it to fall
  """
  def move(%Task4CClientRobotB.Position{x: x, y: _, facing: :west} = robotB) when x > 1 do
    %Task4CClientRobotB.Position{robotB | x: x - 1}
  end

  @doc """
  Does not channelge the position of the robotB.
  This function used as fallback if the robotB cannot move outside the table
  """
  def move(robotB), do: robotB

  def failure do
    raise "Connection has been lost"
  end
end
