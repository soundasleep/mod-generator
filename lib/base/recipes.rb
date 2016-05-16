class RawRecipe < ModRecipe
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def base?
    true
  end
end

def raw_recipes
  [
    # recipe/*.lua
    "advanced-circuit", "advanced-oil-processing", "alien-science-pack", "arithmetic-combinator",
    "assembling-machine-1", "assembling-machine-2", "assembling-machine-3", "basic-accumulator",
    "basic-armor", "basic-beacon", "basic-bullet-magazine",
    "basic-electric-discharge-defense-equipment", "basic-electric-discharge-defense-remote",
    "basic-exoskeleton-equipment", "basic-grenade", "basic-inserter",
    "basic-laser-defense-equipment", "basic-mining-drill", "basic-modular-armor",
    "basic-oil-processing", "basic-splitter", "basic-transport-belt",
    "basic-transport-belt-to-ground", "battery", "battery-equipment", "battery-mk2-equipment",
    "big-electric-pole", "blueprint", "boiler", "burner-inserter", "burner-mining-drill",
    "cannon-shell", "car", "cargo-wagon", "chemical-plant", "combat-shotgun", "concrete",
    "constant-combinator", "construction-robot", "copper-cable", "copper-plate", "curved-rail",
    "decider-combinator", "deconstruction-planner", "defender-capsule", "destroyer-capsule",
    "diesel-locomotive", "distractor-capsule", "effectivity-module", "effectivity-module-2",
    "effectivity-module-3", "electric-engine-unit", "electric-furnace", "electronic-circuit",
    "empty-barrel", "empty-crude-oil-barrel", "energy-shield-equipment",
    "energy-shield-mk2-equipment", "engine-unit", "explosive-cannon-shell", "explosive-rocket",
    "explosives", "express-splitter", "express-transport-belt",
    "express-transport-belt-to-ground", "fast-inserter", "fast-splitter", "fast-transport-belt",
    "fast-transport-belt-to-ground", "fill-crude-oil-barrel", "flame-thrower",
    "flame-thrower-ammo", "flying-robot-frame", "fusion-reactor-equipment", "gate", "green-wire",
    "gun-turret", "heavy-armor", "heavy-oil-cracking", "iron-axe", "iron-chest", "iron-gear-wheel",
    "iron-plate", "iron-stick", "lab", "land-mine", "laser-turret", "light-oil-cracking",
    "logistic-chest-active-provider", "logistic-chest-passive-provider",
    "logistic-chest-requester", "logistic-chest-storage", "logistic-robot", "long-handed-inserter",
    "low-density-structure", "lubricant", "medium-electric-pole", "night-vision-equipment",
    "offshore-pump", "oil-refinery", "personal-roboport-equipment", "piercing-bullet-magazine",
    "piercing-shotgun-shell", "pipe", "pipe-to-ground", "pistol", "plastic-bar", "player-port",
    "poison-capsule", "power-armor", "power-armor-mk2", "processing-unit", "productivity-module",
    "productivity-module-2", "productivity-module-3", "pumpjack", "radar", "rail-chain-signal",
    "rail-signal", "railgun", "railgun-dart", "red-wire", "repair-pack", "roboport", "rocket",
    "rocket-control-unit", "rocket-fuel", "rocket-launcher", "rocket-part", "rocket-silo",
    "satellite", "science-pack-1", "science-pack-2", "science-pack-3", "shotgun", "shotgun-shell",
    "slowdown-capsule", "small-electric-pole", "small-lamp", "small-plane", "small-pump",
    "smart-chest", "smart-inserter", "solar-panel", "solar-panel-equipment",
    "solid-fuel-from-heavy-oil", "solid-fuel-from-light-oil", "solid-fuel-from-petroleum-gas",
    "speed-module", "speed-module-2", "speed-module-3", "steam-engine", "steel-axe",
    "steel-chest", "steel-furnace", "steel-plate", "stone-brick", "stone-furnace", "stone-wall",
    "storage-tank", "straight-rail", "submachine-gun", "substation", "sulfur", "sulfuric-acid",
    "tank", "train-stop", "wood", "wooden-chest",
  ]
end

def raw_recipe(key)
  fail "Unknown raw recipe '#{key}'" unless raw_recipes.include?(key)

  RawRecipe.new(key)
end
