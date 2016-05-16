require_relative "preload"

# All existing recipes that used to use iron-axe must now use this item instead.
class NewIronAxeRecipe < ModRecipe
  def overrides
    raw_recipe("iron-axe")
  end

  def ingredients
    [
      [2, raw_item("iron-stick")],
      [4, raw_item("iron-plate")],
    ]
  end

  def results
    [
      [2, raw_item("iron-axe")],
    ]
  end
end

class IronedStickRecipe < ModRecipe
  def ingredients
    [
      [2, raw_item("iron-plate")],
      [1, raw_item("raw-wood")],
    ]
  end

  def results
    [
      [3, IronedStick.new],
    ]
  end
end

class NewIronStickRecipe < ModRecipe
  def overrides
    raw_recipe("iron-stick")
  end

  def ingredients
    [
      [1, IronedStick.new],
      [1, raw_item("coal")],
    ]
  end

  def results
    [
      [2, raw_item("iron-stick")],
    ]
  end
end

class IronedStick < ModItem
  def description
    "It's like ten thousand spoons"
  end
end

class DirtyWater < ModFluid
  def description
    "Ewww"
  end

  def colour
    Colour.new(0.5, 0.5, 0.2)
  end
end

class DirtyWaterRecipe < ModRecipe
  def ingredients
    [
      [1, raw_fluid("water")],
    ]
  end

  def results
    [
      [2, DirtyWater.new],
    ]
  end

  def energy_required
    10
  end

  def craftable_by
    :chemistry
  end
end

class ModData
  def name
    "generated"
  end

  def items
    [
      StarItem.new,
      BiggerStarItem.new,

      # new items
      IronedStick.new,
    ]
  end

  def recipes
    [
      CreateStarItem.new,
      CreateBiggerStarItem.new,
      CheatingRecipe.new,

      IronedStickRecipe.new,

      DirtyWaterRecipe.new,

      # override existing recipes
      NewIronAxeRecipe.new,
      NewIronStickRecipe.new,
    ]
  end

  def technologies
    [
      SimpleTechnology.new,
      UnlockAllTheThings.new,
      BlockedTechnology.new,
    ]
  end

  def fluids
    [
      DirtyWater.new,
    ]
  end

  def resources
    [
      GoldOreResource.new,
    ]
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
      [100, raw_item("coal")],
      [10, raw_item("storage-tank")],
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
