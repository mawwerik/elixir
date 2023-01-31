defmodule Play do
	def fib(0), do: 1
	def fib(1), do: 1
	def fib(n) when n >= 2, do: fib(n-2) + fib(n-1)

	def sum([]), do: 0
	def sum([ head | tail]), do: head + sum(tail)

	def map([], _func), do: []
	def map([ head | tail ], func) do
		[ func.(head) | map(tail, func) ]
	end
end

# output: 89
Play.fib 10

# output: 6
Play.sum [1,2,3]

# output: [1, 4, 9, 16]
Play.map [1,2,3,4], fn x -> x*x end

# output: [1, 4, 9, 16, 25]
Play.map [1,2,3,4,5], &(&1 * &1)

# output: [1, 4, 9, 16, 25]
[1,2,3,4,5] |> Play.map(&(&1 * &1))

# output: 55
[1,2,3,4,5] |> Play.map(&(&1 * &1)) |> Play.sum

defmodule Say do
	def greet do
		receive do
			:greetings ->
        IO.puts "Hello"
        # the existing greet function is called
        greet()
      _          ->
        IO.puts "What?"
        # Say is reloaded and the new greet function is called
        Say.greet()
		end
	end
end

# output: Hello
# 		  PID<0.128.0>
spawn Say, :greet, []

# Sends the 'greetings' message to a process/thread
pid = spawn Say, :greet, []
send pid, :greetings


