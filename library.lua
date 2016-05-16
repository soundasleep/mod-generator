-- TODO maybe put these into modules

function remove_recipe(recipe_name)
  data.raw.recipe[recipe_name] = nil
end

function remove_item(item_name)
  data.raw.item[item_name] = nil
end
