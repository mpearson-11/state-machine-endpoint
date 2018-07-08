defmodule StateMachineEndpoint.ApiController do
  use StateMachineEndpoint.Web, :controller
  alias StateMachineEndpoint.State.Config
  alias StateMachineEndpoint.State.ConfigList
  alias StateMachineEndpoint.Apps

  def get_data([]), do: %{message: "No match found for path" }
  def get_data([ %Config{json: json_data} ]) do
    json_data
  end
  def expand_url(path), do: "/#{Enum.join(path, "/")}"
  def find_config_list(list, path, method) do
    Enum.filter(list, fn(config) ->
      Config.equal(expand_url(path), method, config)
    end) |> get_data
  end

  def get_endpoint_data(nil, _path, _method), do: %{ message: "App does not exist!!" }
  def get_endpoint_data(configs, path, method) do
    configs
    |> ConfigList.get
    |> find_config_list(path, method)
  end

  def get(conn, %{"path" => path, "app_id" => id}) do
    data = id
    |> Apps.get_endpoint
    |> get_endpoint_data(path, "GET")

    json conn, data
  end

  def post(conn, %{"path" => path, "app_id" => id}) do
    data = id
    |> Apps.get_endpoint
    |> get_endpoint_data(path, "POST")

    json conn, data
  end

  def put(conn, %{"path" => path, "app_id" => id}) do
    data = id
    |> Apps.get_endpoint
    |> get_endpoint_data(path, "PUT")

    json conn, data
  end
end
