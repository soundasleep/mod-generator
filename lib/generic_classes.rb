# TODO split out into smaller files

class GenericItem
  def name
    self.class.name.gsub(/[A-Z]/, ' \0').strip.gsub(" ", "-").downcase
  end

  # default: at end
  def order
    "z-z"
  end

  def label
    self.class.name
  end

  def description
    nil
  end
end

class ModSubgroup < GenericItem
  def base?
    false
  end
end

# a built-in; TODO have a list of built-in subgroups and categories
class RawResourceSubgroup < ModSubgroup
  def name
    "raw-resource"
  end

  def base?
    true
  end

  def category
    nil
  end
end

class ModItem < GenericItem
  def subgroup
    RawResourceSubgroup.new
  end

  def icon
    "graphics/default.png"
  end

  def flags
    ["goes-to-main-inventory"]
  end

  # default
  def stack_size
    100
  end

  def type
    "item"
  end

  def base?
    false
  end
end

class ModRecipe < GenericItem
  def energy_required
    1
  end

  def enabled
    true
  end

  def icon
    if results.size == 1
      results.first[1].icon
    else
      "graphics/default.png"
    end
  end

  def craftable_by
    :hand
  end

  def subgroup
    nil
  end

  def base?
    false
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

  def description
    fail "Recipes don't have descriptions"
  end

  def overrides
    nil
  end
end

class ModTechnology < GenericItem
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

  def description
    "Lets you do things with #{name}"
  end

  def base?
    false
  end
end

class Colour
  attr_reader :r, :g, :b

  def initialize(r, g, b)
    @r = r
    @g = g
    @b = b
  end
end

class ModOre < GenericItem
  def map_colour
    Colour.new(0.95, 0.95, 0.95)
  end

  def icon
    result.icon
  end

  def sheet
    "graphics/resource/default.png"
  end

  def sheet_frames
    4
  end

  def stage_counts
    [1000, 600, 400, 200, 100, 50, 20, 1]
  end

  def richness_multiplier
    1
  end

  def size_multiplier
    1
  end

  def hardness
    0.9
  end

  def mining_time
    2
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

  def base?
    false
  end
end
