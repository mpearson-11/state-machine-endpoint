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

  def delete_app(conn, _params) do
    render conn, "delete_app.html"
  end

  def delete_path(conn, _params) do
    render conn, "delete_path.html"
  end

  def delete_form(conn, %{"app_id" => id, "hash" => hash }) do
    render conn, "_delete_form.html",
      app_value: id,
      hash_value: hash,
      hash_included: true,
      from_server: true
  end

  def error(conn, _params) do
    json conn, %{message: "No such route!! "}
  end
end
