class TechnologyGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "technology.lua", generate_technologies
  end

  private

  def root_path
    "/prototypes/"
  end

  def generate_technologies
    "
    data:extend({
      #{extended_data.map { |c| to_lua(c) }.join(",\n\n")}
    })
    "
  end

  def extended_data
    data.technologies.map { |c| technology_json(c) }
  end

  def technology_json(recipe)
    {
      type: "technology",
      name: recipe.name,
      icon: mod_path(recipe.icon),
      effects: technology_effects(recipe),
      prerequisites: recipe.prerequisites.map(&:name),
      unit: {
        count: recipe.ingredient_count,
        ingredients: to_ingredients(recipe.ingredients),
        time: recipe.research_time,
      },
      order: recipe.order,
    }
  end

  def technology_effects(recipe)
    recipe.unlocked_recipes.map do |unlock|
      {
        type: "unlock-recipe",
        recipe: unlock.name,
      }
    end
  end

  def to_ingredients(ingredients)
    ingredients.map do |input|
      [
        input[1].name, input[0]
      ]
    end
  end
end
