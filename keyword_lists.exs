colors = [{:primary, "red"}, {:secondary, "blue"}]
# access a keyword
IO.puts colors[:primary]

# abbreviated syntax
colors = [primary: "red", secondary: "blue"]
# access a keyword
IO.puts colors[:primary]

# same key can appear many times
colors = [primary: "red", primary: "blue"]
colors
# [primary: "red", primary: "blue"]

# good example for keyword_list use case
queries = User.find_where [where: user.age > 10, where: user.subscribed == true]
# square braces can be left if keyword_list is the last argument, there is only a single argument
queries = User.find_where where: user.age > 10, where: user.subscribed == true