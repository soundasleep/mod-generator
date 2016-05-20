require_relative "preload"

require "yaml"

types = {
  recipes: YamlRecipe,
  items: YamlItem,
  fluids: YamlFluid,
  subgroups: YamlSubgroup,
  categories: YamlCategory,
  technologies: YamlTechnology,
  resources: YamlResource,
  buildings: YamlBuilding,
}

runtime = types.map do |path, classname|
  classes = Dir[File.dirname(__FILE__) + '/game/' + path.to_s + '/*.yml'].map do |file|
    classname.new(file)
  end
  [path, Hash[classes.map { |c| [c.name, c] }]]
end
RUNTIME = Hash[runtime]

class ModData
  def name
    "generated"
  end

  def items
    RUNTIME[:items].values
  end

  def recipes
    RUNTIME[:recipes].values
  end

  def technologies
    RUNTIME[:technologies].values
  end

  def fluids
    RUNTIME[:fluids].values
  end

  def resources
    RUNTIME[:resources].values
  end

  def entities
    RUNTIME[:buildings].values
  end

  def categories
    subgroups.map(&:category).compact.reject(&:base?).uniq { |x| x.name }
  end

  def recipe_categories
    recipe_subgroups.map(&:category).compact.reject(&:base?).uniq { |x| x.name }
  end

  def recipe_subgroups
    recipes.map(&:subgroup).compact.reject(&:base?).uniq { |x| x.name }
  end

  def subgroups
    items.map(&:subgroup).compact.reject(&:base?).uniq { |x| x.name }
  end
end

data = ModData.new

target = "#{Dir.pwd}/../mods/#{data.name}_0.1.0"
puts "Generating #{target}..."

generator = ModGenerator.new(target, data)
generator.generate!
