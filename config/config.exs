# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :state_machine_endpoint, StateMachineEndpoint.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MlRMFhFnPPOwOZajZ8XaCf2hVuaDtLX3yvVUtdxvVAtsm/jjPdg/G/ZO5mhwkl73",
  render_errors: [view: StateMachineEndpoint.ErrorView, accepts: ~w(json)],
  pubsub: [name: StateMachineEndpoint.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
