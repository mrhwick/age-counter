defmodule AgeCounter.AgeAggregator do
	use GenServer

	def start_link(name) do
		GenServer.start_link(__MODULE__, name, name: name)
	end

	def init(state) do
		{:ok, []}
	end

	def increment_count_for_ageline(age_aggregator, ageline) do
		GenServer.call(age_aggregator, {:increment_count_for_ageline, ageline})
	end

	def output_age_counts(age_aggregator) do
		GenServer.call(age_aggregator, {:output_age_counts})
	end

	def handle_call({:output_age_counts}, _from, state) do
		for ageGroup <- state do
			IO.puts "Age: #{elem(ageGroup, 0)}, Count: #{elem(ageGroup, 1)}"
		end
		{:reply, :ok, state}
	end

	def handle_call({:increment_count_for_ageline, ageline}, _from, state) do
		[_, age] = ageline |> String.replace("\n", "") |> String.split(",", trim: true)
		{age, _ } = Integer.parse(age)

		state =
		case Enum.find_value(state, fn({groupAge, _}) -> groupAge == age end) do
			nil -> state ++ [{age, 1}] |> Enum.sort(&(elem(&1, 1) <= elem(&2, 1)))
			true -> increment(state, age)
		end
		{:reply, :ok, state}
	end

	defp increment(ageGroups, age) do
		Enum.map(ageGroups, fn({groupAge, count}) ->
			if groupAge == age do
				{groupAge, count + 1}
			else
				{groupAge, count}
			end
		end) |> Enum.sort(&(elem(&1, 0) <= elem(&2, 0)))
	end
end
