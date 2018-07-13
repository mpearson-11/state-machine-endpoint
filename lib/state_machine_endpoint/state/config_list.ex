defmodule StateMachineEndpoint.State.ConfigList do
  defstruct [list: []]

  alias StateMachineEndpoint.State.ConfigList
  alias StateMachineEndpoint.State.Config

  def get(%ConfigList{list: old_list}) do
    old_list
  end

  def set(old_list, config) do
    %ConfigList{list: old_list ++ [config]}
  end

  def config_path(%Config{path: p}, equal_path) do
    p == equal_path
  end

  def duplicate?(%ConfigList{ list: old_list }, %Config{path: path}) do
    Enum.any?(old_list, fn(item) ->
      config_path(item, path)
    end)
  end

  def add(config, config_list) do
    old_list = get(config_list)

    if duplicate?(config_list, config) do
      config_list
    else
      set(old_list, config)
    end
  end
end
