defmodule StateMachineEndpoint.PageView do
  use StateMachineEndpoint.Web, :view

  def uri_path(%{"id" => id, "path" => path}) do
    "/api/#{id}#{path}"
  end

  def delete_path(%{"id" => id, "hash" => hash }) do
    "/delete/#{id}/#{hash}"
  end
end
