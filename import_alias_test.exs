defmodule Math do
  def add(a, b) do
    a + b
  end
end

defmodule Hello do
  import Math

  def say(text) do
    "Hello #{text}: #{Math.add(1,2)}"
  end
end

defmodule Szia do
  alias Math, as: M

  def say(text) do
    "Szia #{text}: #{M.add(3,5)}"
  end
end

IO.puts Hello.say "World!"
IO.puts Szia.say "Zoli"
IO.puts Hello.add 1, 2