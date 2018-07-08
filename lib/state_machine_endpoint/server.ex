defmodule StateMachineEndpoint.Server do
  alias StateMachineEndpoint.State
  use GenServer
  @start_state(%State{})

  def start_link(params) do
    IO.puts("-------------------------------------------------------------------")
    IO.puts("StateMachineEndpoint GenServer just started with empty endpoints   ")
    IO.puts("-------------------------------------------------------------------")
    GenServer.start_link(__MODULE__, %{}, params)
  end

  def init(_params) do
    {:ok, @start_state}
  end

  def handle_cast({:set, :endpoint, endpoint}, state) do
    IO.puts("-------------------------------------------------------------------")
    IO.puts("--- New endpoint")
    IO.inspect(endpoint)
    IO.puts("-------------------------------------------------------------------")
    {:noreply, State.set_endpoints(state, endpoint)}
  end

  def handle_cast({:delete, :endpoint, id}, state) do
    IO.puts("-------------------------------------------------------------------")
    IO.puts("--- Deleting endpoint: #{id}")
    IO.puts("-------------------------------------------------------------------")
    %State{endpoints: e} = state
    {:noreply, %State{endpoints:  Map.delete(e, id)}}
  end

  def handle_call({:get, :endpoints}, _from, state) do
    {:reply, State.get_endpoints(state), state}
  end

  def handle_call({:get, :endpoint, id}, _from, state) do
    endpoint = state |> State.get_by_id(id)
    {:reply, endpoint, state}
  end

  def handle_cast(:clear, state) do
    IO.puts("-------------------------------------------------------------------")
    IO.puts("--- HARD RESET !!")
    IO.puts("-------------------------------------------------------------------")
    {:noreply, @start_state}
  end
end
