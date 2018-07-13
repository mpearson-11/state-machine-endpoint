defmodule StateMachineEndpoint.Server do
  alias StateMachineEndpoint.State
  use GenServer
  @start_state(%State{})

  def start_link(params) do
    StateMachineEndpoint.Message.log("StateMachineEndpoint GenServer just started with empty endpoints")
    GenServer.start_link(__MODULE__, %{}, params)
  end

  def init(_params) do
    {:ok, @start_state}
  end

  def handle_cast({:set, :endpoint, endpoint}, state) do
    StateMachineEndpoint.Message.log("New endpoint", :inspect)
    {:noreply, State.set_endpoints(state, endpoint)}
  end

  def handle_cast({:delete, :endpoint, id}, state) do
    StateMachineEndpoint.Message.log("Deleting endpoint: #{id}")
    %State{endpoints: e} = state
    {:noreply, %State{endpoints: Map.delete(e, id)}}
  end

  def handle_cast(:clear, state) do
    StateMachineEndpoint.Message.log("HARD RESET")
    {:noreply, @start_state}
  end

  def handle_call({:get, :endpoints}, _from, state) do
    {:reply, State.get_endpoints(state), state}
  end

  def handle_call({:get, :endpoint, id}, _from, state) do
    endpoint = state |> State.get_by_id(id)
    {:reply, endpoint, state}
  end
end
