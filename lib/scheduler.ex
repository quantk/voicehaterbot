defmodule Scheduler do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, 0)
  end

  def init(update_id) do
    schedule_work()
    {:ok, update_id}
  end

  def handle_info(:work, update_id) do
    update_id = poll(update_id)
    schedule_work()
    {:noreply, update_id}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1000)
  end

  def poll(update_id \\ 0) do
    {:ok, updates} = Nadia.get_updates(offset: update_id + 1)
    last_element = List.last(updates)
    last_update_id = case last_element do
      nil -> 0
      update -> update.update_id
    end

    Enum.each(updates, fn update -> Que.add(HaterWorker, update) end)

    last_update_id
  end
end
