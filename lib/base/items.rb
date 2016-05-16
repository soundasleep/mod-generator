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
    "steel-axe", "iron-axe",
  ]
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

  def icon
    "__base__/graphics/icons/#{name}.png"
  end

  def base?
    true
  end
end

def raw_item(key)
  fail "Unknown raw item '#{key}'" unless raw_items.include?(key)

  RawItem.new(key)
end
