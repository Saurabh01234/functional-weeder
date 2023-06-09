# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :toy_robot, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:toy_robot, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

 config :task_4c_client_robota, :phoenix_server, url: "ws://88b0-2401-4900-5aa6-28c3-589c-de49-4d2a-2a2e.ngrok.io:80/socket/websocket"
#config :task_4c_client_robota, phoenix_server_url: "ws://localhost:4000/socket/websocket"
#"http://24ea-2401-4900-5ab8-c50-4709-56dd-54e4-2a29"

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
