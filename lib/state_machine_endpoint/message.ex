defmodule StateMachineEndpoint.Message do
  @moduledoc false

  def log(message) do
    IO.puts("----------------------------------------------------------------------------")
    IO.puts("| #{message}")
    IO.puts("----------------------------------------------------------------------------")
  end
end
