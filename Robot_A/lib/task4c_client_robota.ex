defmodule Task4CClientRobotA do
  require Logger
  use Bitwise
  alias Circuits.GPIO

  @sensor_pins [cs: 5, clock: 25, address: 24, dataout: 23]
  @ir_pins [dr: 16, dl: 19]
  @motor_pins [lf: 12, lb: 13, rf: 20, rb: 21]
  @pwmr  [enr: 26]
  @pwml [enl: 6]
  @servo_a_pin 27
  @servo_c_pin 4
  @servo_b_pin 22
@pwm_pins [enl: 6, enr: 26]
  @ref_atoms [:cs, :clock, :address, :dataout]
  @lf_sensor_data %{sensor0: 0, sensor1: 0, sensor2: 0, sensor3: 0, sensor4: 0, sensor5: 0}
  @lf_sensor_map %{0 => :sensor0, 1 => :sensor1, 2 => :sensor2, 3 => :sensor3, 4 => :sensor4, 5 => :sensor5}

  @back [0, 1, 1, 0]
  @l [0, 1, 0, 1]
  @r [1, 0, 1, 0]
  @fwd [1, 0, 0, 1]
  @stop [0, 0, 0, 0]
@right [1, 0, 0, 0]
@left [0, 0, 0, 1]
  @duty_cycles [150, 70, 0]
  @pwm_frequency 50
  # max x-coordinate of table top
  @table_top_x 6
  # max y-coordinate of table top
  @table_top_y :f
  # mapping of y-coordinates
  @robotA_map_y_atom_to_num %{:a => 1, :b => 2, :c => 3, :d => 4, :e => 5, :f => 6}

  def lap(%Task4CClientRobotA.Position{x: x, y: y, facing: facing} = robotA, channel, goal_x, goal_y) do

    b=cond do
      robotA.y==:c ->
        b=3
        robotA.y==:b ->
          b=2
          robotA.y==:a ->
            b=1
            robotA.y==:d ->
              b=4
              robotA.y==:e ->
                b=5
                robotA.y==:f ->
                  b=6
              end
              robotA=if goal_x != robotA.x or b != goal_y do
               robotA=left(robotA)
    pd=self()
    pid=spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
    send(pd, {:obstacle_presence, fg}) end)
    Process.register(pid, :client_toyrobotA)
           fl = receive do
              {:obstacle_presence, ns} -> ns
                end

                robotA=cond do
                fl==:true ->
                  robotA=lap(robotA, channel, goal_x, goal_y)

                  fl==:false ->
                    robotA=move(robotA)


                pid=spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
    send(pd, {:obstacle_presence, fg}) end)
    Process.register(pid, :client_toyrobotA)
           q = receive do
              {:obstacle_presence, ns} -> ns
                end

                robotA=right(robotA)

                pid=spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
    send(pd, {:obstacle_presence, fg}) end)
    Process.register(pid, :client_toyrobotA)
           lf = receive do
              {:obstacle_presence, ns} -> ns
                end

              robotA=cond do
                lf==:true  ->
                  robotA=lap(robotA, channel, goal_x, goal_y)
                  lf==:false ->
                    robotA=move(robotA)
                    pid=spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
                    send(pd, {:obstacle_presence, fg}) end)
                    Process.register(pid, :client_toyrobotA)
                           q = receive do
                              {:obstacle_presence, ns} -> ns
                                end

                                robotA=robotA
                end
              end
            else robotA=robotA
          end
    end
    def taska(%Task4CClientRobotA.Position{x: x, y: y, facing: facing} = robotA, goal_x, goal_y, channel, goal_locs) do
      b=cond do
        robotA.y==:c ->
          b=3
          robotA.y==:b ->
            b=2
            robotA.y==:a ->
              b=1
              robotA.y==:d ->
                b=4
                robotA.y==:e ->
                  b=5
                  robotA.y==:f ->
                    b=6
       end
       pat=self()
      robotA = cond do
        (robotA.x < goal_x and robotA.facing != :east) ->
  robotA=if robotA.facing==:south do
  robotA=left(robotA)
  else

            robotA=right(robotA)
  end
         (robotA.x < goal_x and robotA.facing == :east) ->

              robotA=move(robotA)




         (robotA.x > goal_x and robotA.facing != :west) ->
          robotA=if robotA.facing==:south do
            robotA=right(robotA)
            else

                      robotA=left(robotA)
            end

            (robotA.x > goal_x and robotA.facing == :west) ->


                  robotA=move(robotA)
                (b < goal_y and robotA.x == goal_x and robotA.facing != :north) ->

                  robotA=if robotA.facing==:east do
                    robotA=left(robotA)
                    else

                              robotA=right(robotA)
                    end

         (b < goal_y and robotA.facing == :north and robotA.x == goal_x) ->

                  robotA=move(robotA)
                (b > goal_y and robotA.x == goal_x and robotA.facing != :south) ->

                  robotA=if robotA.facing==:west do
                    robotA=left(robotA)
                    else

                              robotA=right(robotA)
                    end
              (b > goal_y and robotA.facing == :south and robotA.x == goal_x) ->

                     robotA=move(robotA)


        true ->
         robotA=robotA
        end
        q=goal_x
        a=goal_y
         {:ok, robotA} = if(robotA.x != goal_x or b != a) do
          stopA(robotA, goal_x, goal_y, channel, goal_locs)
           else
            pid = spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
            send(pat, {:obstacle_presence, fg}) end)
            Process.register(pid, :client_toyrobotA)
           l = receive do
              {:obstacle_presence, ns} -> ns
                end
                {:ok, robotA}
                  end
                end

                def taskb(%Task4CClientRobotA.Position{x: x, y: y, facing: facing} = robotA, goal_x, goal_y, channel, goal_locs) do
                  b=cond do
                    robotA.y==:c ->
                      b=3
                      robotA.y==:b ->
                        b=2
                        robotA.y==:a ->
                          b=1
                          robotA.y==:d ->
                            b=4
                            robotA.y==:e ->
                              b=5
                            end
                    pt=self()
                  robotA = cond do
                    (b < goal_y and robotA.facing != :north) ->
robotA=if robotA.facing==:west do
  robotA=right(robotA)
else
                        robotA=left(robotA)
end
                     (b < goal_y and robotA.facing == :north) ->

                          robotA=move(robotA)




                     (b > goal_y and robotA.facing != :south) ->
                      robotA=if robotA.facing==:east do
                        robotA=right(robotA)
                      else
                                              robotA=left(robotA)
                      end



                        (b > goal_y and robotA.facing == :south) ->


                              robotA=move(robotA)
                            (robotA.x < goal_x and b == goal_y and robotA.facing != :east) ->
                              robotA=if robotA.facing==:north do
                                robotA=right(robotA)
                              else
                                                      robotA=left(robotA)
                              end



                     (robotA.x < goal_x and robotA.facing == :east and b == goal_y) ->

                              robotA=move(robotA)
                            (robotA.x > goal_x and b == goal_y and robotA.facing != :west) ->
                              robotA=if robotA.facing==:north do
                                robotA=left(robotA)
                              else
                                                      robotA=right(robotA)
                              end

                          (robotA.x > goal_x and robotA.facing == :west and b == goal_y) ->

                                 robotA=move(robotA)
                    true ->
                      robotA=robotA
                  end
                  q=goal_x
                  a=goal_y
                  {:ok, robotA} = if(robotA.x != q or b != a) do
                  stopA(robotA, goal_x, goal_y, channel, goal_locs)
                   else
                    pid = spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
                    send(pt, {:obstacle_presence, fg}) end)
                    Process.register(pid, :client_toyrobotA)
                   l = receive do
                      {:obstacle_presence, ns} -> ns
                        end
                        {:ok, robotA}
                          end
                        end

    def aap(%Task4CClientRobotA.Position{x: x, y: y, facing: facing} = robotA, channel, goal_x, goal_y) do
      b=cond do
        robotA.y==:c ->
          b=3
          robotA.y==:b ->
            b=2
            robotA.y==:a ->
              b=1
              robotA.y==:d ->
                b=4
                robotA.y==:e ->
                  b=5
                  robotA.y==:f ->
                    b=6
                end
                robotA=if goal_x != robotA.x or b != goal_y do

                endrobotA=right(robotA)
      pd=self()
      pid=spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
      send(pd, {:obstacle_presence, fg}) end)
      Process.register(pid, :client_toyrobotA)
             fl = receive do
                {:obstacle_presence, ns} -> ns
                  end
                  robotA=cond do
                  fl==true ->
                    robotA=aap(robotA, channel, goal_x, goal_y)

                    fl==false ->
                      robotA=move(robotA)


                  pid=spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
      send(pd, {:obstacle_presence, fg}) end)
      Process.register(pid, :client_toyrobotA)
             q = receive do
                {:obstacle_presence, ns} -> ns
                  end

                  robotA=left(robotA)

                  pid=spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
      send(pd, {:obstacle_presence, fg}) end)
      Process.register(pid, :client_toyrobotA)
             lf = receive do
                {:obstacle_presence, ns} -> ns
                  end

                robotA=cond do
                  lf==:true  ->
                    robotA=aap(robotA, channel, goal_x, goal_y)
                    lf==:false ->

                      robotA=move(robotA)

                      pid=spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
                      send(pd, {:obstacle_presence, fg}) end)
                      Process.register(pid, :client_toyrobotA)
                             q = receive do
                                {:obstacle_presence, ns} -> ns
                                  end
                                  robotA=robotA
                  end
                end
              else robotA
      end
    end


      def stop(%ijPosition{x: x, y: y, facing: facing} = robotA, goal_locs, channel) do


   goal=hd(goal_locs)
   goal_x=hd(goal)
   goal=tl(goal)
   goal_y=hd(goal)
   goal_locs=tl(goal_locs)

         {:ok, robotA}=stopA(robotA, goal_x, goal_y, channel, goal_locs)
         {:ok, robotA} = cond do
          goal_locs != [] ->
            stop(robotA, goal_locs, channel)
            true ->
              {:ok, en}=Task4CClientRobotA.PhoenixSocketClient.endit(channel)
              {:ok, robotA}
        end
        end

      def stopA(%Task4CClientRobotA.Position{x: x, y: y, facing: facing} = robotA, goal_x, goal_y, channel, goal_locs) do
       # s=goal_x

       #  Process.send_after(:com, {:key, s}, 50)
        b=cond do
          robotA.y==:c ->
            b=3
            robotA.y==:b ->
              b=2
              robotA.y==:a ->
                b=1
                robotA.y==:d ->
                  b=4
                  robotA.y==:e ->
                    b=5
                    robotA.y==:f ->
                      b=6
         end

         parent=self()

        pid = spawn_link(fn -> fg = Task4CClientRobotA.PhoenixSocketClient.send_robot_status(channel, robotA)
        send(parent, {:obstacle_presence, fg}) end)
        Process.register(pid, :client_toyrobotA)
        fl = receive do
          {:obstacle_presence, ms} -> ms
            end
#Process.send_after(:B, {:alt, 1}, 5)

#hh=spawn_link(fn -> alt(robotA) end)
#Process.register(hh, :A)


            {:ok, robotA}=cond do

              (fl==true and ((robotA.x==6 and robotA.facing==:south) or (robotA.x==1 and robotA.facing==:north) or (b==5 and robotA.facing==:east==1 and robotA.facing==:west))) ->
                robotA=aap(robotA, channel, goal_x, goal_y)
                {:ok, robotA}=if abs(robotA.x-goal_x) < abs(b-goal_y) do
                  taskb(robotA, goal_x, goal_y, channel, goal_locs)
                  else
                   taska(robotA, goal_x, goal_y, channel, goal_locs)
                  end
                fl==false ->
                  robotA=robotA
                  {:ok, robotA}=taska(robotA, goal_x, goal_y, channel, goal_locs)
                  true ->
                    robotA=lap(robotA, channel, goal_x, goal_y)
                    {:ok, robotA}=if abs(robotA.x-goal_x) < abs(b-goal_y) do
                      taskb(robotA, goal_x, goal_y, channel, goal_locs)
                      else
                       taska(robotA, goal_x, goal_y, channel, goal_locs)
                      end
                  end
      end
  def place do
    {:ok, %Task4CClientRobotA.Position{}}
  end

  def place(x, y, _facing) when x < 1 or y < :a or x > @table_top_x or y > @table_top_y do
    {:failure, "Invalid position"}
  end

  def place(_x, _y, facing) when facing not in [:north, :east, :south, :west] do
    {:failure, "Invalid facing direction"}
  end

  @doc """
  Places the robotA to the provided position of (x, y, facing),
  but prevents it to be placed outside of the table and facing invalid direction.

  Examples:

      iex> Task4CClientRobotA.place(1, :b, :south)
      {:ok, %Task4CClientRobotA.Position{facing: :south, x: 1, y: :b}}

      iex> Task4CClientRobotA.place(-1, :f, :north)
      {:failure, "Invalid position"}

      iex> Task4CClientRobotA.place(3, :c, :north_east)
      {:failure, "Invalid facing direction"}
  """
  def place(x, y, facing) do
    {:ok, %Task4CClientRobotA.Position{x: x, y: y, facing: facing}}

  end

  @doc """
  Provide START position to the robotA as given location of (x, y, facing) and place it.
  """
  def start(x, y, facing) do
    place(x, y, facing)
  end

  @doc """
  Main function to initiate the sequence of tasks to achieve by the Client robotA A,
  such as connect to the Phoenix server, get the robotA A's start and goal locations to be traversed.
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
    {:ok, _response, channel} = Task4CClientRobotA.PhoenixSocketClient.connect_server()
    sp=Task4CClientRobotA.PhoenixSocketClient.getstart(channel)

[x, y, facing]=clean(sp)
y=improve(y)
facing=fi(facing)
list=[x, y, facing]

{:ok, robotA}=start(x, y, facing)

goals=Task4CClientRobotA.PhoenixSocketClient.getgoa(channel)
goal_locs=Enum.map(goals, fn a -> transform(a) end)

{:ok, robotA}=stop(robotA, goal_locs, channel)
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
  Provide GOAL positions to the robotA as given location of [(x1, y1),(x2, y2),..] and plan the path from START to these locations.
  Make a call to ToyrobotA.PhoenixSocketClient.send_robot_status/2 to get the indication of obstacle presence ahead of the robotA.
  """
  #def stop(robotA, goal_locs, channel) do

    ###########################
    ## complete this funcion ##
    ###########################
# end

  @doc """
  Provides the report of the robotA's current position

  Examples:

      iex> {:ok, robotA} = Task4CClientRobotA.place(2, :b, :west)
      iex> Task4CClientRobotA.report(robotA)
      {2, :b, :west}
  """

  def go do
    {:ok, robotA}=start(1, :a, :north)
    goal_x=1
    goal_y=:b
    list=test_wlf_sensors()
    ir3=Enum.at(list,3)
    ir2=Enum.at(list,2)
    ir1=Enum.at(list,1)
    ir5=Enum.at(list,5)
    ir4=Enum.at(list,4)
    flag=check(5)
    {:ok, robotA}=if flag  do
      stop(robotA, goal_x, goal_y)
    else {:ok, robotA}
  end
  end
def fwd do
  test_motion(:fwd)

end

def sa(angle) do
  Logger.debug("Testing Servo A")
  val = trunc(((2.5 + 10.0 * angle / 180) / 100 ) * 255)
  Pigpiox.Pwm.set_pwm_frequency(@servo_a_pin, @pwm_frequency)
  Pigpiox.Pwm.gpio_pwm(@servo_a_pin, val)
end


@doc """
Controls angle of serve motor B

Example:

    iex> FW_DEMO.test_servo_b(90)
    :ok

Note: On executing above function servo motor B will rotate by 90 degrees. You can provide
values from 0 to 180
"""
def sb(angle) do
  Logger.debug("Testing Servo B")
  val = trunc(((2.5 + 10.0 * angle / 180) / 100 ) * 255)
  Pigpiox.Pwm.set_pwm_frequency(@servo_b_pin, @pwm_frequency)
  Pigpiox.Pwm.gpio_pwm(@servo_b_pin, val)
end

def sc(angle) do
  Logger.debug("Testing Servo C")
  val = trunc(((2.5 + 10.0 * angle / 180) / 100 ) * 255)
  Pigpiox.Pwm.set_pwm_frequency(17, @pwm_frequency)
  Pigpiox.Pwm.gpio_pwm(17, val)
end

  def testpwm do
    Logger.debug("Testing PWM for Motion control")
    motor_ref = Enum.map(@motor_pins, fn {_atom, pin_no} -> GPIO.open(pin_no, :output) end)
    motor_action(motor_ref, @fwd, 500)
    Enum.map(@duty_cycles, fn value -> motionpwm(value) end)
  end
  defp motionpwm(value) do
    IO.puts("Forward with pwm value = #{value}")
    pm(value)
    Process.sleep(2000)
  end

  @doc """
  Supporting function for test_pwm

  Note: "duty" variable can take value from 0 to 255. Value 255 indicates 100% duty cycle
  """
  defp pm(duty) do
    Enum.each(@pwm_pins, fn {_atom, pin_no} -> Pigpiox.Pwm.gpio_pwm(pin_no, duty) end)
  end

  @doc """
  Tests motion of the robotA

  Example:

      iex> FW_DEMO.test_motion
      :ok

  Note: On executing above function robotA will move forward, backward, left, right
  for 500ms each and then stops
  """
  def test_motion(act) do
    Logger.debug("Testing Motion of the robotA ")
    motor_ref = Enum.map(@motor_pins, fn {_atom, pin_no} -> GPIO.open(pin_no, :output) end)
    pwm_refr = Enum.map(@pwmr, fn {_atom, pin_no} -> GPIO.open(pin_no, :output) end)
    pwm_refl = Enum.map(@pwml, fn {_atom, pin_no} -> GPIO.open(pin_no, :output) end)
    Enum.map(pwm_refr,fn {_, ref_no} -> GPIO.write(ref_no, 1) end)
    Enum.map(pwm_refl,fn {_, ref_no} -> GPIO.write(ref_no, 1) end)
    {motion_list, tame}=cond do
      act==:move ->
        {motion_list = [@fwd,@stop], 85}
        act==:right ->
          {motion_list = [@right,@stop], 300}
          act==:left ->
            {motion_list = [@left,@stop], 300}
            act==:back ->
              {motion_list = [@back, @stop], 1000}
              act==:fwd ->
                {motion_list = [@fwd, @stop], 1000}
                act==:rgt ->
                  {motion_list = [@right, @stop], 130}
                  act==:lft ->
                    {motion_list = [@left, @stop], 130}

    end
    Enum.each(motion_list, fn motion -> motor_action(motor_ref, motion, tame) end)
if act==:move do
    [powerr, powerl]=pid()
    Enum.map([powerr], fn value -> motion_pwmr(value) end)
    Enum.map([powerl], fn value -> motion_pwml(value) end)
end
  end


  @doc """
  Supporting function for test_pwm
  """
  defp motion_pwmr(value) do
    IO.puts("Forward with pwm value = #{value}")
      pwmr(value)

    Process.sleep(5)
  end
  defp motion_pwml(value) do
    IO.puts("Forward with pwm value = #{value}")

      pwml(value)
    Process.sleep(5)
  end
  @doc """
  Supporting function for test_pwm

  Note: "duty" variable can take value from 0 to 255. Value 255 indicates 100% duty cycle
  """
  defp pwmr(duty) do
 Enum.each(@pwmr, fn {_atom, pin_no} -> Pigpiox.Pwm.gpio_pwm(pin_no, duty) end)
  end
  defp pwml(duty) do
      Enum.each(@pwml, fn {_atom, pin_no} -> Pigpiox.Pwm.gpio_pwm(pin_no, duty) end)
  end

  def pid do
    list=test_wlf_sensors()
    list=tl(list)
    array=Enum.map(list, fn val -> if val>=800 do 1 else 0 end end)
    IO.inspect(array)
    ir3=Enum.at(array,2)
    ir2=Enum.at(array,1)
    ir1=Enum.at(array,0)
    ir5=Enum.at(array,4)
    ir4=Enum.at(array,3)
error=cond do

    array==[0, 1, 0, 0, 0] ->
      error=7
      array==[1, 0, 0, 0, 0] ->
        error=10
        array==[0, 0, 0, 1, 0] ->
          error=-7
          array==[0, 0, 0, 0, 1] ->
            error=-10
            array==[0, 0, 1, 1, 0] ->
              error=-5
              array==[0, 1, 1, 0, 0] ->
                error=5
                array==[1, 1, 0, 0, 0] ->
                  error=6
                  array==[0, 0, 0, 1, 1] ->
                    error=-6

                true ->
                  error=0
end
k=7
p=k*error
p=cond do
  p > 54 ->
    54
    p < -54 ->
    -54
    true ->
      p
end
[powerr, powerl]=[200+p, 200-p]
IO.inspect([powerr, powerl])
[powerr, powerl]
  end
  @doc """
  Supporting function for test_motion
  """
  defp motor_action(motor_ref, motion, tame) do
    motor_ref |> Enum.zip(motion) |> Enum.each(fn {{_, ref_no}, value} -> GPIO.write(ref_no, value) end)
    Process.sleep(tame)
  end
  @directions_to_the_right %{north: :east, east: :south, south: :west, west: :north}
  @doc """
  Rotates the robotA to the right
  """
  def right(%Task4CClientRobotA.Position{facing: facing} = robotA) do
  #:ok = rotater()
  #test_motion(:right)
   robotA=%Task4CClientRobotA.Position{robotA | facing: @directions_to_the_right[facing]}
    IO.inspect(robotA)
    robotA
  end
def rotater do
  IO.puts("this is printed for right")
  test_motion(:rgt)
  flag=cheknew()
  IO.inspect(flag)

  cond do
    flag==true ->
      :ok
      flag==false ->
        rotater()
      end
end
def rotatel do
  IO.puts("this is printed for left")
  test_motion(:lft)
  flag=cheknew
  IO.inspect(flag)

  cond do
    flag==true ->
      :ok
      flag==false ->
        rotatel()
      end
end

  @directions_to_the_left Enum.map(@directions_to_the_right, fn {from, to} -> {to, from} end)
  @doc """
  Rotates the robotA to the left
  """
  def left(%Task4CClientRobotA.Position{facing: facing} = robotA) do
#  :ok = rotatel()
 # test_motion(:left)
  robotA=%Task4CClientRobotA.Position{robotA | facing: @directions_to_the_left[facing]}
    IO.inspect(robotA)
    robotA
  end
def check(v) do
  list=test_wlf_sensors()
    list=tl(list)
    array=Enum.map(list, fn val -> if val>=800 do 1 else 0 end end)
    IO.inspect(array)
    ir3=Enum.at(array,2)
    ir2=Enum.at(array,1)
    ir1=Enum.at(array,0)
    ir5=Enum.at(array,4)
    ir4=Enum.at(array,3)
    ir3=if ir3==1 do
      10 else 0
    end
    t=ir1+ir2+ir3+ir4+ir5
    IO.inspect(t)
  flag=if (t>=v) do
    true
  else
    false
end
flag
end
def cheknew do
  list=test_wlf_sensors()
    list=tl(list)
    array=Enum.map(list, fn val -> if val>=800 do 1 else 0 end end)
    IO.inspect(array)
    ir1=Enum.at(array,0)
    ir2=Enum.at(array,1)
    ir3=Enum.at(array,2)
    ir4=Enum.at(array,3)
    ir5=Enum.at(array,4)
    ir3=if ir3==1 do
      10 else 0
    end
    t=ir2+ir3+ir4
    #IO.inspect(t)
  flag=cond do
    (ir1<800 and ir5<800 and t>1) ->
      true
    true ->
      false
  end
flag
end
def moveit do
  IO.puts("this prints for forward")
  test_motion(:move)
    flag=check(12)
    IO.inspect(flag)
   cond do
    flag==true ->
      :ok
      flag==false ->
        moveit
      end
end

  @doc """
  Tests white line sensor modules reading

  Example:

      iex> FW_DEMO.test_wlf_sensors
      [0, 958, 851, 969, 975, 943]  // on white surface
      [0, 449, 356, 312, 321, 267]  // on black surface
  """
  def test_wlf_sensors do
    Logger.debug("Testing white line sensors connected ")
    sensor_ref = Enum.map(@sensor_pins, fn {atom, pin_no} -> configure_sensor({atom, pin_no}) end)
    sensor_ref = Enum.map(sensor_ref, fn{_atom, ref_id} -> ref_id end)
    sensor_ref = Enum.zip(@ref_atoms, sensor_ref)
    get_lfa_readings([0,1,2,3,4], sensor_ref)
  end


  @doc """
  Tests IR Proximity sensor's readings

  Example:

      iex> FW_DEMO.test_ir
      [1, 1]     // No obstacle
      [1, 0]     // Obstacle in front of Right IR Sensor
      [0, 1]     // Obstacle in front of Left IR Sensor
      [0, 0]     // Obstacle in front of both Sensors

  Note: You can adjust the potentiometer provided on the IR sensor to get proper results
  """
  def test_ir do
    Logger.debug("Testing IR Proximity Sensors")
    ir_ref = Enum.map(@ir_pins, fn {_atom, pin_no} -> GPIO.open(pin_no, :input, pull_mode: :pullup) end)
    ir_values = Enum.map(ir_ref,fn {_, ref_no} -> GPIO.read(ref_no) end)
  end



  @doc """
  Supporting function for test_wlf_sensors
  Configures sensor pins as input or output

  [cs: output, clock: output, address: output, dataout: input]
  """
  defp configure_sensor({atom, pin_no}) do
    if (atom == :dataout) do
      GPIO.open(pin_no, :input, pull_mode: :pullup)
    else
      GPIO.open(pin_no, :output)
    end
  end

  @doc """
  Supporting function for test_wlf_sensors
  Reads the sensor values into an array. "sensor_list" is used to provide list
  of the sesnors for which readings are needed

  The values returned are a measure of the reflectance in abstract units,
  with higher values corresponding to lower reflectance (e.g. a black
  surface or void)
  """
  defp get_lfa_readings(sensor_list, sensor_ref) do
    append_sensor_list = sensor_list ++ [5]
    temp_sensor_list = [5 | append_sensor_list]
    list=append_sensor_list
        |> Enum.with_index
        |> Enum.map(fn {sens_num, sens_idx} ->
              analog_read(sens_num, sensor_ref, Enum.fetch(temp_sensor_list, sens_idx))
              end)
    Enum.each(0..5, fn n -> provide_clock(sensor_ref) end)
    GPIO.write(sensor_ref[:cs], 1)
    Process.sleep(5)
IO.inspect(list)
list
  end

  @doc """
  Supporting function for test_wlf_sensors
  """
  defp analog_read(sens_num, sensor_ref, {_, sensor_atom_num}) do

    GPIO.write(sensor_ref[:cs], 0)
    %{^sensor_atom_num => sensor_atom} = @lf_sensor_map
    Enum.reduce(0..9, @lf_sensor_data, fn n, acc ->
                                          read_data(n, acc, sens_num, sensor_ref, sensor_atom_num)
                                          |> clock_signal(n, sensor_ref)
                                        end)[sensor_atom]
  end

  @doc """
  Supporting function for test_wlf_sensors
  """
  defp read_data(n, acc, sens_num, sensor_ref, sensor_atom_num) do
    if (n < 4) do

      if (((sens_num) >>> (3 - n)) &&& 0x01) == 1 do
        GPIO.write(sensor_ref[:address], 1)
      else
        GPIO.write(sensor_ref[:address], 0)
      end
      Process.sleep(1)
    end

    %{^sensor_atom_num => sensor_atom} = @lf_sensor_map
    if (n <= 9) do
      Map.update!(acc, sensor_atom, fn sensor_atom -> ( sensor_atom <<< 1 ||| GPIO.read(sensor_ref[:dataout]) ) end)
    end
  end

  @doc """
  Supporting function for test_wlf_sensors used for providing clock pulses
  """
  defp provide_clock(sensor_ref) do
    GPIO.write(sensor_ref[:clock], 1)
    GPIO.write(sensor_ref[:clock], 0)
  end

  @doc """
  Supporting function for test_wlf_sensors used for providing clock pulses
  """
  defp clock_signal(acc, n, sensor_ref) do
    GPIO.write(sensor_ref[:clock], 1)
    GPIO.write(sensor_ref[:clock], 0)
    acc
  end

  def report(%Task4CClientRobotA.Position{x: x, y: y, facing: facing} = _robotA) do
    {x, y, facing}
  end

  @directions_to_the_right %{north: :east, east: :south, south: :west, west: :north}
  @doc """
  Rotates the robotA to the right
  """
  def right(%Task4CClientRobotA.Position{facing: facing} = robotA) do
    %Task4CClientRobotA.Position{robotA | facing: @directions_to_the_right[facing]}
  end

  @directions_to_the_left Enum.map(@directions_to_the_right, fn {from, to} -> {to, from} end)
  @doc """
  Rotates the robotA to the left
  """
  def left(%Task4CClientRobotA.Position{facing: facing} = robotA) do
    %Task4CClientRobotA.Position{robotA | facing: @directions_to_the_left[facing]}
  end

  @doc """
  Moves the robotA to the north, but prevents it to fall
  """
  def move(%Task4CClientRobotA.Position{x: _, y: y, facing: :north} = robotA) when y < @table_top_y do
   # moveit()
    robotA=%Task4CClientRobotA.Position{robotA | y: Enum.find(@robotA_map_y_atom_to_num, fn {_, val} -> val == Map.get(@robotA_map_y_atom_to_num, y) + 1 end) |> elem(0)}
    IO.inspect(robotA)
    robotA
  end

  @doc """
  Moves the robotA to the east, but prevents it to fall
  """
  def move(%Task4CClientRobotA.Position{x: x, y: _, facing: :east} = robotA) when x < @table_top_x do
  #  moveit()
    robotA=%Task4CClientRobotA.Position{robotA | x: x + 1}
    IO.inspect(robotA)
    robotA
  end

  @doc """
  Moves the robotA to the south, but prevents it to fall
  """
  def move(%Task4CClientRobotA.Position{x: _, y: y, facing: :south} = robotA) when y > :a do
  #  moveit()
    robotA=%Task4CClientRobotA.Position{robotA | y: Enum.find(@robotA_map_y_atom_to_num, fn {_, val} -> val == Map.get(@robotA_map_y_atom_to_num, y) - 1 end) |> elem(0)}
    IO.inspect(robotA)
    robotA
  end

  @doc """
  Moves the robotA to the west, but prevents it to fall
  """
  def move(%Task4CClientRobotA.Position{x: x, y: _, facing: :west} = robotA) when x > 1 do
   # moveit()
    robotA=%Task4CClientRobotA.Position{robotA | x: x - 1}
    IO.inspect(robotA)
    robotA
  end

  @doc """
  Does not channelge the position of the robotA.
  This function used as fallback if the robotA cannot move outside the table
  """
  def move(robotA), do: robotA

  def failure do
    raise "Connection has been lost"
  end
end
