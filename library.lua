-- TODO maybe put these into modules

function remove_recipe(recipe_name)
  if data.raw.recipe[recipe_name] then
    data.raw.recipe[recipe_name].hidden = true
  end
end
