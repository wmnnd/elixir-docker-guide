defmodule Clock do
  @moduledoc """
  This module prints out the current time at a given interval.
  """

  use GenServer, restart: :temporary
  @version Mix.Project.config[:version]


  @doc """
  Starts the GenServer.
  """
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok)
  end


  @doc """
  Initializes the GenServer state with the configured interval.
  """
  def init(:ok) do
    interval = case System.get_env("CLOCK_INTERVAL") do
      nil -> Application.get_env(:clock, :interval)
      val -> String.to_integer(val)
    end
    {:ok, interval, 1000}
  end


  @doc """
  Updates the GenServer state when a new version of the module was loaded.
  """
  def code_change(_old_vsn, _state, _extra) do
    with {:ok, interval, _} <- init(:ok) do
      {:ok, interval}
    else
      other -> {:error, other}
    end
  end


  @doc """
  Prints out the time after the timeout has expired.
  """
  def handle_info(:timeout, interval) do
    time = Time.utc_now() |> Time.to_iso8601()
    IO.puts("Clock #{@version}. The time is: #{time}.")
    {:noreply, interval, interval}
  end
end
