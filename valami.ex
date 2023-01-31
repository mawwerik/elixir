defmodule Valami do
  @moduledoc false

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

  pid = spawn Say, :greet, []
  send pid, :greetings
end
