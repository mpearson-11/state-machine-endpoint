defmodule StateMachineEndpoint.State.Config do
  defstruct [id: nil, path: "", method: "GET", json: %{}, hash: ""]

  alias StateMachineEndpoint.State.Config
  alias StateMachineEndpoint.Util

  def get(%Config{hash: hsh}, :hash), do: hsh
  def get(%Config{id: o_id}, :id), do: o_id
  def get(%Config{path: p}, :path), do: p
  def get(%Config{method: m}, :method), do: m
  def get(%Config{json: j}, :json), do: j

  def equal(path, method, endpoint) do
    if get(endpoint, :method) == method && Util.path_eq?(path, get(endpoint, :path)) do
      true
    else
      false
    end
  end
end
