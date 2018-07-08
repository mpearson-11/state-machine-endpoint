defmodule StateMachineEndpoint.State.AppEndpoint do
  defstruct [id: nil, path: "", method: "GET", json: %{}]
  alias StateMachineEndpoint.State.AppEndpoint

  def get(%AppEndpoint{id: o_id}, :id), do: o_id
  def get(%AppEndpoint{path: p}, :path), do: p
  def get(%AppEndpoint{method: m}, :method), do: m
  def get(%AppEndpoint{json: j}, :json), do: j

  def equal(id, path, method, endpoint) do
    if get(endpoint, :id) == id && get(endpoint, :method) == method && get(endpoint, :path) == path do
      get(endpoint, :json)
    else
      nil
    end
  end
end
