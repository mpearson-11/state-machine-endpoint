defmodule StateMachineEndpoint.EndpointController do
  use StateMachineEndpoint.Web, :controller
  alias StateMachineEndpoint.Endpoints
  alias StateMachineEndpoint.State.Endpoint

  def convert_structure(%{
    "app" => id,
    "json" => json_data,
    "method" => method,
    "path" => path
  }) do
    Endpoints.create_endpoint(%Endpoint{id: id, json: json_data, method: method, path: path})
    %{message: "Application now running on url: /api/#{id}#{path}, method: #{method}"}
  end
  def convert_structure(_other) do
    %{message: "Structure is not formed correctly !!"}
  end

  def create(conn, params) do
    json conn, convert_structure(params)
  end

  def delete(conn, %{ "app" => id }) do
    json conn, Endpoints.delete_endpoint(id)
  end
end
