defmodule StateMachineEndpoint.PageController do
  use StateMachineEndpoint.Web, :controller

  alias StateMachineEndpoint.{Util, Apps}

  def index(conn, _params) do
    all_apps = Apps.get_endpoints()
    |> Util.convert_endpoints_to_list

    render conn, "index.html", apps: all_apps
  end

  def create(conn, _params) do
    render conn, "create.html"
  end

  def delete(conn, _params) do
    render conn, "delete.html"
  end

  def error(conn, _params) do
    json conn, %{message: "No such route!! "}
  end
end