defmodule StateMachineEndpoint.Server do
  alias StateMachineEndpoint.State
  use GenServer

  @start_state(%State{})
  @datastore "datastore.bin"

  defp write_store(state) do
    File.write!(@datastore, :erlang.term_to_binary(state))
  end


  defp to_binary({:error, :enoent}), do: @start_state
  defp to_binary({:ok, ""}), do: @start_state
  defp to_binary({:ok, store}) when is_binary(store) == true do
    store |> :erlang.binary_to_term
  end

  defp read_store do
    File.read(@datastore) |> to_binary
  end

  def start_link(params) do
    StateMachineEndpoint.Message.log("StateMachineEndpoint GenServer just started with empty endpoints")
    GenServer.start_link(__MODULE__, read_store(), params)
  end

  def init(start_state) do
    {:ok, start_state}
  end

  def handle_cast({:set, :endpoint, endpoint}, state) do
    StateMachineEndpoint.Message.log("New endpoint", :inspect)
    new_state = state
    |> State.set_endpoints(endpoint)

    # Write to datastore.bin
    write_store(new_state)
    {:noreply, new_state}
  end

  def handle_cast({:delete, :endpoint, id}, state) do
    StateMachineEndpoint.Message.log("Deleting endpoint: #{id}")
    new_state = %State{endpoints: Map.delete(State.get_endpoints(state), id)}

    # Write to datastore.bin
    write_store(new_state)
    {:noreply, new_state}
  end

  def handle_cast({:delete_endpoint, :path, id, hash}, state) do
    StateMachineEndpoint.Message.log("Deleting endpoint path: #{id} -> #{hash}")
    endpoints = State.get_endpoints(state)
    |> State.remove_endpoint_path(id, hash)

    new_state = %State{endpoints: endpoints}

    # Write to datastore.bin
    write_store(new_state)
    {:noreply, new_state}
  end

  def handle_cast(:clear, _state) do
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
