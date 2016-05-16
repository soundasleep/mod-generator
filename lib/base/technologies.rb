class RawTechnology < ModTechnology
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

def raw_technologies
  [
    # technology/*.lua
    "advanced-electronics", "advanced-electronics-2", "advanced-material-processing",
    "advanced-material-processing-2", "advanced-oil-processing", "alien-technology",
    "armor-making", "armor-making-2", "armor-making-3", "automated-construction",
    "automated-rail-transportation", "automation", "automation-2", "automation-3",
    "automobilism", "basic-electric-discharge-defense-equipment", "basic-exoskeleton-equipment",
    "basic-laser-defense-equipment", "battery", "battery-equipment", "battery-mk2-equipment",
    "bullet-damage-1", "bullet-damage-2", "bullet-damage-3", "bullet-damage-4",
    "bullet-damage-5", "bullet-damage-6", "bullet-speed-1", "bullet-speed-2", "bullet-speed-3",
    "bullet-speed-4", "bullet-speed-5", "bullet-speed-6", "character-logistic-slots-1",
    "character-logistic-slots-2", "character-logistic-slots-3", "character-logistic-slots-4",
    "character-logistic-slots-5", "character-logistic-trash-slots-1",
    "character-logistic-trash-slots-2", "circuit-network", "combat-robot-damage-1",
    "combat-robot-damage-2", "combat-robot-damage-3", "combat-robot-damage-4",
    "combat-robot-damage-5", "combat-robotics", "combat-robotics-2", "combat-robotics-3",
    "concrete", "construction-robotics", "effect-transmission", "effectivity-module",
    "effectivity-module-2", "effectivity-module-3", "electric-energy-accumulators-1",
    "electric-energy-distribution-1", "electric-energy-distribution-2", "electric-engine",
    "electronics", "energy-shield-equipment", "energy-shield-mk2-equipment", "engine",
    "explosive-rocketry", "explosives", "flame-thrower", "flammables", "fluid-handling",
    "flying", "follower-robot-count-1", "fusion-reactor-equipment", "gates",
    "gun-turret-damage-1", "gun-turret-damage-2", "gun-turret-damage-3", "gun-turret-damage-4",
    "gun-turret-damage-5", "gun-turret-damage-6", "inserter-stack-size-bonus-1",
    "inserter-stack-size-bonus-2", "inserter-stack-size-bonus-3", "inserter-stack-size-bonus-4",
    "land-mine", "laser", "laser-turret-damage-1", "laser-turret-damage-2",
    "laser-turret-damage-3", "laser-turret-damage-4", "laser-turret-damage-5",
    "laser-turret-damage-6", "laser-turret-speed-1", "laser-turret-speed-2",
    "laser-turret-speed-3", "laser-turret-speed-4", "laser-turret-speed-5",
    "laser-turret-speed-6", "laser-turrets", "logistic-robot-speed-1",
    "logistic-robot-speed-2", "logistic-robot-speed-3", "logistic-robot-speed-4",
    "logistic-robot-speed-5", "logistic-robot-storage-1", "logistic-robot-storage-2",
    "logistic-robot-storage-3", "logistic-robotics", "logistic-system", "logistics",
    "logistics-2", "logistics-3", "military", "military-2", "military-3", "military-4",
    "modules", "night-vision-equipment", "oil-processing", "optics",
    "personal-roboport-equipment", "plastics", "power-armor", "power-armor-2",
    "productivity-module", "productivity-module-2", "productivity-module-3",
    "rail-signals", "railway", "research-effectivity-1", "research-effectivity-2",
    "research-effectivity-3", "research-effectivity-4", "robotics", "rocket-damage-1",
    "rocket-damage-2", "rocket-damage-3", "rocket-damage-4", "rocket-damage-5",
    "rocket-silo", "rocket-speed-1", "rocket-speed-2", "rocket-speed-3", "rocket-speed-4",
    "rocket-speed-5", "rocketry", "shotgun-shell-damage-1", "shotgun-shell-damage-2",
    "shotgun-shell-damage-3", "shotgun-shell-damage-4", "shotgun-shell-damage-5",
    "shotgun-shell-damage-6", "shotgun-shell-speed-1", "shotgun-shell-speed-2",
    "shotgun-shell-speed-3", "shotgun-shell-speed-4", "shotgun-shell-speed-5",
    "shotgun-shell-speed-6", "solar-energy", "solar-panel-equipment", "speed-module",
    "speed-module-2", "speed-module-3", "steel-processing", "stone-walls", "sulfur-processing",
    "tanks", "toolbelt", "turrets",
  ]
end

def raw_technology(key)
  fail "Unknown raw technology '#{key}'" unless raw_technologies.include?(key)

  RawTechnology.new(key)
end
