defmodule StateMachineEndpoint.ApiController do
  use StateMachineEndpoint.Web, :controller

  alias StateMachineEndpoint.{Apps, Util}
  alias StateMachineEndpoint.State.{Config, ConfigList}

  def find_request_headers([]) do
    nil
  end
  def find_request_headers([head | tail]) do
    {name, value} = head
    if name == "access-control-request-method" do
      value
    else
      find_request_headers(tail)
    end
  end

  def get_data([], _path), do: %{message: "No match found for path!!" }
  def get_data([config], path) do
    %Config{json: json_data, path: config_path} = config
    json_data
  end

  def find_config_list(list, path, method) do
    list
    |> Enum.filter(&(Config.equal(path, method, &1)))
    |> get_data(path)
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

  def options(conn, %{"path" => path, "app_id" => id}) do
    %Plug.Conn{req_headers: h} = conn
    method = find_request_headers(h)
    
    data = id
    |> Apps.get_endpoint
    |> get_endpoint_data(path, method)

    json conn, data
  end
end
