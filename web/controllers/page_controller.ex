defmodule StateMachineEndpoint.PageController do
  use StateMachineEndpoint.Web, :controller

  def index(conn, _params) do
    all_apps = StateMachineEndpoint.Apps.get_endpoints()
    |> StateMachineEndpoint.Util.convert_endpoints_to_list

    render conn, "index.html", apps: all_apps
  end
end