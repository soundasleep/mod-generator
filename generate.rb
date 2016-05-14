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
      CreateBiggerStarItem.new
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

  def hand_craftable?
    true
  end

  def category
    if hand_craftable?
      "crafting"
    else
      "advanced-crafting"
    end
  end
end

class RawWood < ModItem
  def type
    "item"
  end
end

class CreateStarItem < ModRecipe
  def ingredients
    [
      [1, RawWood.new],
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
end

class CreateBiggerStarItem < ModRecipe
  def ingredients
    [
      [2, RawWood.new],
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
end

data = ModData.new

target = "#{Dir.pwd}/../mods/#{data.name}_0.1.0"
puts "Generating #{target}..."

generator = ModGenerator.new(target, data)
generator.generate!
