# Cards
## How to start
```cmd
$ iex -S mix
iex> Cards.hello
```
## Recompile an already loaded application in iex
```cmd
iex> recompile
iex> Cards.create_deck
```
## Add dependencies to Mix
1. Edit **mix.exs**, add `{:ex_doc, "~> 0.29"}` to **deps**
2. Run Mix
   ```cmd
   $ mix deps.get
   ```
## Making documentation
```cmd
$ mix docs
```
## Run test
```cmd
$ mix test
```
# Identicon
## Create a new Mix project
```cmd
$ mix new identicon
```
## How to start
```cmd
$ cd identicon
$ iex -S mix
iex> Identicon.main "asdf"
```
Check the `asdf.png` file
## Recompile an already loaded application in iex
```cmd
iex> recompile
iex> Identicon.main "asdf"
```