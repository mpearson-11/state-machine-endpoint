defmodule StateMachineEndpoint.EndpointController do
  use StateMachineEndpoint.Web, :controller
  alias StateMachineEndpoint.{Apps, State.AppEndpoint}

  defp set_message(_, message), do: %{message: message}

  defp convert_structure(%{ "app" => id, "json" => json_data, "method" => method, "path" => path }) do
    %AppEndpoint{id: id, json: json_data, method: method, path: path}
    |> Apps.create_endpoint
    |> set_message("Application now running on url: /api/#{id}#{path}, method: #{method}")
  end

  defp convert_structure(_other) do
    set_message(nil, "Structure is not formed correctly !!")
  end

  def create(conn, params) do
    json conn, convert_structure(params)
  end

  def delete(conn, %{ "app" => id }) do
    json conn, Apps.delete_endpoint(id)
  end

  def reset(conn, _params) do
    json conn, Apps.reset_endpoints()
  end

  def error(conn, _params) do
    json conn, %{message: "No such route!! "}
  end
end
