defmodule StateMachineEndpoint.State.Endpoint do
  defstruct [id: nil, path: "", method: "GET", json: %{}]
  alias StateMachineEndpoint.State.Endpoint

  def get(%Endpoint{id: o_id}, :id), do: o_id
  def get(%Endpoint{path: p}, :path), do: p
  def get(%Endpoint{method: m}, :method), do: m
  def get(%Endpoint{json: j}, :json), do: j

  def equal(id, path, method, endpoint) do
    if get(endpoint, :id) == id && get(endpoint, :method) == method && get(endpoint, :path) == path do
      get(endpoint, :json)
    else
      nil
    end
  end
end
