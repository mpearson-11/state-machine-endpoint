defmodule StateMachineEndpoint.State.ConfigList do
  defstruct [list: []]

  alias StateMachineEndpoint.State.{Config, ConfigList}

  def get(%ConfigList{list: old_list}) do
    old_list
  end

  def set(old_list, config) do
    %ConfigList{list: old_list ++ [config]}
  end

  def config_path(%Config{path: p}, equal_path) do
    p == equal_path
  end

  def exists_config_path?(%ConfigList{ list: old_list }, %Config{path: path}) do
    Enum.any?(old_list, &(config_path(&1, path)))
  end

  def add(config_list, config) do
    old_list = get(config_list)

    if exists_config_path?(config_list, config) do
      config_list
    else
      set(old_list, config)
    end
  end
end
