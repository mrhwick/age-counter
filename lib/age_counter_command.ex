defmodule AgeCounter.Command do
	def main(args) do
		args |> parse_args |> handle
	end

	def handle([]) do
		IO.puts "No arguments given."
	end

	def handle(options) do
		IO.puts "Processing #{options[:file]}..."
		File.stream!(options[:file]) |> Stream.map(&(AgeCounter.AgeAggregator.increment_count_for_ageline(AgeCounter.AgeAggregator, &1))) |> Stream.run
		AgeCounter.AgeAggregator.output_age_counts(AgeCounter.AgeAggregator)
	end

	defp parse_args(args) do
		{options, _, _} = OptionParser.parse(args, switches: [file: :string, timeout: :integer])
		options
	end
end
