defmodule StateMachineEndpoint.Util do
  defp equal_keys(nil, _url_key), do: false
  defp equal_keys(app_key, url_key) do
    String.starts_with?(app_key, ":") || app_key == url_key
  end

  defp accumulate({ item, index }, acc) do
    Map.put(acc, "param-#{index}", item)
  end

  defp create_map(path) do
    path
    |> Enum.with_index
    |> Enum.reduce(%{}, &(accumulate(&1, &2)))
  end

  defp param_equal?({item, index}, map) do
    map["param-#{index}"] |> equal_keys(item)
  end

  def path_eq?(url_path, app_path) do
    url_abs_path = ["/"] ++ url_path # router url path prepend /
    app_abs_path = Path.split(app_path)

    # if params have the same length
    if length(url_abs_path) == length(app_abs_path) do

      # create map with param[index]
      app_map = app_abs_path |> create_map

      matches_all = url_abs_path
      |> Enum.with_index
      |> Enum.all?(&(param_equal?(&1, app_map)))

      # if all params match
      matches_all
    else
      false
    end
  end
end