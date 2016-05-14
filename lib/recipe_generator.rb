class RecipeGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "recipes.lua", generate_category
  end

  private

  def root_path
    "/prototypes/"
  end

  def generate_category
    "
    data:extend({
      #{extended_data.map { |c| to_lua(c) }.join(",\n\n")}
    })
    "
  end

  def extended_data
    data.recipes.map { |c| item_json(c) }
  end

  def item_json(recipe)
    {
      type: "recipe",
      name: recipe.name,
      energy_required: recipe.energy_required,
      enabled: recipe.enabled,
      subgroup: recipe.subgroup.name,
      category: recipe.category,
      ingredients: to_ingredients(recipe.ingredients),
      results: to_ingredients(recipe.results),
      order: recipe.order,
      icon: mod_path(recipe.icon),

      # order: recipe.order,
      # icon: mod_path(recipe.icon),
    }
  end

  def to_ingredients(ingredients)
    ingredients.map do |input|
      {
        type: input[1].type,
        name: input[1].name,
        amount: input[0],
      }
    end
  end
end
