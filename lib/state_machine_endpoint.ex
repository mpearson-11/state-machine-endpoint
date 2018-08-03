defmodule StateMachineEndpoint do
  @moduledoc false
  use Application

  def get_children(:test, children), do: children
  def get_children(_other, children) do
    children ++ [{StateMachineEndpoint.Server, name: Server}]
  end

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = get_children(Mix.env, [
      supervisor(StateMachineEndpoint.Endpoint, []),
    ])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StateMachineEndpoint.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    StateMachineEndpoint.Endpoint.config_change(changed, removed)
    :ok
  end
end
