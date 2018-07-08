defmodule StateMachineEndpoint.ApiController do
  use StateMachineEndpoint.Web, :controller
  alias StateMachineEndpoint.State.AppEndpoint
  alias StateMachineEndpoint.Apps

  def expand_url(path), do: "/#{Enum.join(path, "/")}"
  def get_endpoint_data(nil, _id, _path, _method), do: %{ message: "App does not exist!!" }
  def get_endpoint_data(endpoint, id, path, method) do
    AppEndpoint.equal(id, expand_url(path), method, endpoint)
  end

  def get(conn, %{"path" => path, "app_id" => id}) do
    data = id
    |> Apps.get_endpoint
    |> get_endpoint_data(id, path, "GET")

    json conn, data
  end

  def post(conn, %{"path" => path, "app_id" => id}) do
    data = id
    |> Apps.get_endpoint
    |> get_endpoint_data(id, path, "POST")

    json conn, data
  end

  def put(conn, %{"path" => path, "app_id" => id}) do
    data = id
    |> Apps.get_endpoint
    |> get_endpoint_data(id, path, "PUT")

    json conn, data
  end
end
