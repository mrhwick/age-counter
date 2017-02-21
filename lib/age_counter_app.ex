defmodule AgeCounter do
	use Application

	def start(_type, _args) do
		AgeCounter.Supervisor.start_link
	end
end