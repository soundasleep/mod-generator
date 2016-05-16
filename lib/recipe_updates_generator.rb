class RecipeUpdatesGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "recipes-updates.lua", generate_updates
  end

  private

  def root_path
    "/prototypes/"
  end

  def generate_updates
    data.recipes.select { |recipe| recipe.overrides }.map do |recipe|
      "remove_recipe('#{recipe.overrides.name}')"
    end.join("\n")
  end

  def extended_data
    data.recipes.map { |c| item_json(c) }
  end
end
