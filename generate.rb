require_relative "preload"

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

# add a hacking category

class ModData
  def name
    "generated"
  end

  def items
    [
      StarItem.new,
      BiggerStarItem.new
    ]
  end

  def recipes
    [
      CreateStarItem.new,
      CreateBiggerStarItem.new,
      CheatingRecipe.new,
    ]
  end

  def technologies
    [
      SimpleTechnology.new,
      UnlockAllTheThings.new,
      BlockedTechnology.new,
    ]
  end

  def resources
    [
      GoldOreResource.new,
    ]
  end

  def categories
    subgroups.map(&:category).uniq { |x| x.name }
  end

  def recipe_categories
    recipe_subgroups.map(&:category).uniq { |x| x.name }
  end

  def recipe_subgroups
    recipes.map(&:subgroup).uniq { |x| x.name }
  end

  def subgroups
    items.map(&:subgroup).uniq { |x| x.name }
  end
end

class FirstHackGroup < ModSubgroup
  def category
    HackCategory.new
  end
end

class SecondHackGroup < ModSubgroup
  def category
    HackCategory.new
  end
end

class StarItem < ModItem
  def subgroup
    FirstHackGroup.new
  end

  def description
    "This is amazing!"
  end
end

class BiggerStarItem < ModItem
  def subgroup
    SecondHackGroup.new
  end
end

class ModCategory < GenericItem
  # default: at end
  def inventory_order
    "z-z"
  end

  def icon
    "graphics/category/default.png"
  end
end

class HackCategory < ModCategory
end

class CreateStarItem < ModRecipe
  def ingredients
    [
      [1, raw_item("raw-wood")],
    ]
  end

  def results
    [
      [1, StarItem.new],
    ]
  end

  def subgroup
    FirstHackGroup.new
  end

  def craftable_by
    :smelting
  end
end

class CreateBiggerStarItem < ModRecipe
  def ingredients
    [
      [2, raw_item("raw-wood")],
    ]
  end

  def results
    [
      [1, StarItem.new],
      [1, BiggerStarItem.new],
    ]
  end

  def subgroup
    FirstHackGroup.new
  end

  def craftable_by
    :chemistry
  end

  def enabled
    false
  end
end

class CheatingRecipe < ModRecipe
  def ingredients
    [
      [1, raw_item("raw-wood")],
    ]
  end

  def results
    [
      [100, raw_item("iron-plate")],
      [100, raw_item("copper-plate")],
      [100, raw_item("stone-brick")],
      [100, raw_item("steel-plate")],
      [100, raw_item("battery")],
      [100, raw_item("electronic-circuit")],
      [100, raw_item("advanced-circuit")],
      [100, raw_item("plastic-bar")],
      [10, raw_item("lab")],
      [50, raw_item("solar-panel")],
      [50, raw_item("big-electric-pole")],
      [50, raw_item("science-pack-1")],
      [50, raw_item("science-pack-2")],
    ]
  end

  def subgroup
    FirstHackGroup.new
  end

  def craftable_by
    :hand
  end
end

class SimpleTechnology < ModTechnology
  def ingredients
    [
      [1, raw_item("science-pack-1")],
    ]
  end

  def ingredient_count
    1
  end

  def research_time
    1
  end

  def description
    "Basically a noop."
  end
end

class BlockedTechnology < ModTechnology
  def prerequisites
    [
      raw_technology("steel-processing"),
      SimpleTechnology.new,
    ]
  end

  def ingredients
    [
      [1, raw_item("science-pack-1")],
    ]
  end

  def ingredient_count
    10
  end

  def research_time
    2
  end
end

class UnlockAllTheThings < ModTechnology
  def prerequisites
    [
      SimpleTechnology.new,
    ]
  end

  def ingredients
    [
      [1, raw_item("science-pack-1")],
    ]
  end

  def ingredient_count
    1
  end

  def research_time
    1
  end

  def unlocked_recipes
    [
      CreateBiggerStarItem.new,
      raw_recipe("steel-plate"),
      raw_recipe("steel-axe"),
      raw_recipe("assembling-machine-1"),
      raw_recipe("assembling-machine-2"),
      raw_recipe("assembling-machine-3"),
      raw_recipe("electronic-circuit"),
      raw_recipe("advanced-circuit"),
      raw_recipe("processing-unit"),
      raw_recipe("science-pack-3"),
      raw_recipe("fast-inserter"),
      raw_recipe("stone-wall"),
      raw_recipe("solar-panel"),
      raw_recipe("basic-accumulator"),
      # oil-processing
      raw_recipe("pumpjack"),
      raw_recipe("oil-refinery"),
      raw_recipe("chemical-plant"),
      raw_recipe("basic-oil-processing"),
      raw_recipe("solid-fuel-from-light-oil"),
      raw_recipe("solid-fuel-from-petroleum-gas"),
      raw_recipe("solid-fuel-from-heavy-oil"),
      raw_recipe("lubricant"),
    ]
  end

  def description
    "Unlocks all of the things so we can research all of the things."
  end
end

class GoldOreResource < ModOre
  def result
    raw_item("raw-wood")
  end
end

data = ModData.new

target = "#{Dir.pwd}/../mods/#{data.name}_0.1.0"
puts "Generating #{target}..."

generator = ModGenerator.new(target, data)
generator.generate!
