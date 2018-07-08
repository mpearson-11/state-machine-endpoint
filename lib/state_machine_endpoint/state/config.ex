defmodule StateMachineEndpoint.State.Config do
  defstruct [id: nil, path: "", method: "GET", json: %{}]
  alias StateMachineEndpoint.State.Config

  def get(%Config{id: o_id}, :id), do: o_id
  def get(%Config{path: p}, :path), do: p
  def get(%Config{method: m}, :method), do: m
  def get(%Config{json: j}, :json), do: j

  def equal(path, method, endpoint) do
    if get(endpoint, :method) == method && get(endpoint, :path) == path do
      get(endpoint, :json)
    else
      nil
    end
  end
end
