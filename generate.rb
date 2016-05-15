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

class GenericItem
  def name
    self.class.name.gsub(/[A-Z]/, ' \0').strip.gsub(" ", "-").downcase
  end
end

class ModSubgroup < GenericItem
  # default: at end
  def order
    "z-z"
  end
end

class MiscSubgroup < ModSubgroup
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

class ModItem < GenericItem
  def subgroup
    MiscSubgroup.new
  end

  def icon
    "graphics/default.png"
  end

  def flags
    ["goes-to-main-inventory"]
  end

  # default: at end
  def order
    "z-z"
  end

  # default
  def stack_size
    100
  end

  def type
    "item"
  end
end

class StarItem < ModItem
  def subgroup
    FirstHackGroup.new
  end
end

class BiggerStarItem < ModItem
  def subgroup
    SecondHackGroup.new
  end
end

class ModCategory < GenericItem
  # default: at end
  def order
    "z-z"
  end

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

class ModRecipe < GenericItem
  # default: at end
  def order
    "z-z"
  end

  def energy_required
    1
  end

  def enabled
    true
  end

  def icon
    results.first[1].icon
  end

  def craftable_by
    :hand
  end

  def category
    case craftable_by
      when :hand
        "crafting"
      when :factory
        "advanced-crafting"
      when :smelting
        "smelting"
      when :chemistry
        "chemistry"
      when :fluid
        "crafting-with-fluid"
      when :refinery
        "oil-processing"
      when :rocket
        "rocket-building"
      else
        fail "Unknown craftable_by #{craftable_by}"
    end
  end
end

def raw_items
  [
    # demo-item.lua
    "alien-artifact", "assembling-machine-1", "basic-inserter", "basic-mining-drill",
    "basic-transport-belt", "boiler", "burner-inserter", "burner-mining-drill", "coal", "computer",
    "copper-cable", "copper-ore", "copper-plate", "electronic-circuit", "green-wire", "iron-gear-wheel",
    "iron-ore", "iron-plate", "iron-stick", "offshore-pump", "pipe", "pipe-to-ground", "radar",
    "raw-fish", "raw-wood", "red-wire", "repair-pack", "small-electric-pole", "small-lamp", "small-plane",
    "steam-engine", "stone", "stone-brick", "stone-furnace", "stone-wall", "wood", "wooden-chest",

    # item.lua
    "advanced-circuit", "alien-science-pack", "arithmetic-combinator", "assembling-machine-2",
    "assembling-machine-3", "basic-accumulator", "basic-beacon", "basic-splitter",
    "basic-transport-belt-to-ground", "battery", "big-electric-pole", "blueprint", "car", "cargo-wagon",
    "chemical-plant", "coin", "concrete", "constant-combinator", "construction-robot", "crude-oil-barrel",
    "curved-rail", "decider-combinator", "deconstruction-planner", "diesel-locomotive",
    "electric-engine-unit", "electric-furnace", "empty-barrel", "engine-unit", "explosives",
    "express-splitter", "express-transport-belt", "express-transport-belt-to-ground", "fast-inserter",
    "fast-splitter", "fast-transport-belt", "fast-transport-belt-to-ground", "flying-robot-frame", "gate",
    "iron-chest", "lab", "logistic-chest-active-provider", "logistic-chest-passive-provider",
    "logistic-chest-requester", "logistic-chest-storage", "logistic-robot", "long-handed-inserter",
    "low-density-structure", "medium-electric-pole", "oil-refinery", "plastic-bar", "player-port",
    "processing-unit", "pumpjack", "rail-chain-signal", "rail-signal", "roboport", "rocket-control-unit",
    "rocket-fuel", "rocket-part", "rocket-silo", "satellite", "science-pack-1", "science-pack-2",
    "science-pack-3", "small-pump", "smart-chest", "smart-inserter", "solar-panel", "solid-fuel",
    "steel-chest", "steel-furnace", "steel-plate", "storage-tank", "straight-rail", "substation", "sulfur",
    "tank", "train-stop",

    # mining-tools.lua
    "steel-axe",
  ]
end

def raw_recipes
  raw_items
end

class RawItem < ModItem
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def type
    "item"
  end
end

def raw_item(key)
  fail "Unknown raw item '#{key}'" unless raw_items.include?(key)

  RawItem.new(key)
end

class RawRecipe < ModRecipe
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

def raw_recipe(key)
  fail "Unknown raw recipe '#{key}'" unless raw_recipes.include?(key)

  RawRecipe.new(key)
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

class ModTechnology < GenericItem
  # default: at end
  def order
    "z-z"
  end

  # default: at end
  def inventory_order
    "z-z"
  end

  def icon
    "graphics/technology/default.png"
  end

  def prerequisites
    []
  end

  def unlocked_recipes
    []
  end

  def ingredient_count
    75
  end

  def research_time
    30
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
    ]
  end
end

data = ModData.new

target = "#{Dir.pwd}/../mods/#{data.name}_0.1.0"
puts "Generating #{target}..."

generator = ModGenerator.new(target, data)
generator.generate!
