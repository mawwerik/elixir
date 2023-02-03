colors = %{primary: "red", secondary: "blue"}

# access via dot notation
IO.puts colors.primary

# access via pattern matching
%{secondary: secondary_color} = colors
IO.puts secondary_color

# Invalid data manipulation
# colors.primary = "blue"

# Valid data manipulation 1
# modify an existing key
colors_1 = Map.put colors, :primary, "yellow"
IO.puts colors_1.primary

# Valid data manipulation 2
# this is only for updating and existing key "secondary"
colors_2 = %{colors | secondary: "green"}
IO.puts colors_2.secondary

# Valid data manipulation 3
# add a new key
colors_3 = Map.put_new colors, :third, "grey"
IO.puts colors_3.third
