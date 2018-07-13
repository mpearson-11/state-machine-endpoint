defmodule StateMachineEndpoint.Util do
  @param_key ":"

  defp is_param?(app_key) do
    String.starts_with?(app_key, @param_key)
  end
  defp param_key(app_key) do
    String.replace(app_key, ":", "")
  end

  defp equal_keys(nil, _url_key), do: false
  defp equal_keys(app_key, url_key) do
    is_param?(app_key) || app_key == url_key
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

  def path_eq?(path, config_path) do
    url_abs_path = ["/"] ++ path # router url path prepend /
    app_abs_path = Path.split(config_path)

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

  defp reduce_params({ item, index }, acc, url_abs_path) do
    case is_param?(item) do
      true -> Map.put(acc, param_key(item), Enum.at(url_abs_path, index))
      _ -> acc
    end
  end

  def get_param_matches(path, config_path) do
    url_abs_path = ["/"] ++ path # router url path prepend /
    app_abs_path = Path.split(config_path)

    if path_eq?(path, config_path) do
      app_abs_path
      |> Enum.with_index
      |> Enum.reduce(%{}, &(reduce_params(&1, &2, url_abs_path)))
    else
      %{}
    end
  end
end