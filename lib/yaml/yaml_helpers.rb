module YamlHelpers
  attr_reader :yaml

  def initialize(file)
    @yaml = YAML.load(File.read(file))
    @name = File.basename(file, ".yml")
  end

  def method_missing(method)
    yaml[method.to_s] || fail("Did not find any yaml #{method}")
  end

  def name
    @name
  end

  def title
    yaml["title"] || super
  end

  def description
    yaml["description"] || super
  end

  def label
    yaml["label"] || super
  end

  def subgroup
    yaml["subgroup"] ? runtime_subgroup(yaml["subgroup"]) : super
  end

  def runtime_item(key)
    if RUNTIME[:items][key]
      RUNTIME[:items][key]
    elsif RUNTIME[:fluids][key]
      RUNTIME[:fluids][key]
    elsif raw_items.include?(key)
      raw_item(key)
    elsif raw_fluids.include?(key)
      raw_fluid(key)
    else
      fail "Unknown key #{key}: not a runtime item or a raw item/fluid"
    end
  end

  def runtime_technology(key)
    if RUNTIME[:technologies][key]
      RUNTIME[:technologies][key]
    elsif raw_technologies.include?(key)
      raw_technology(key)
    else
      fail "Unknown key #{key}: not a runtime technology or a raw technology"
    end
  end

  def has_runtime_entity?(key)
    RUNTIME[:buildings][key] || raw_entities.include?(key)
  end

  def runtime_entity(key)
    if RUNTIME[:buildings][key]
      RUNTIME[:buildings][key]
    elsif raw_entities.include?(key)
      raw_entity(key)
    else
      fail "Unknown key #{key}: not a runtime entity or a raw entity"
    end
  end

  def runtime_recipe(key)
    if RUNTIME[:recipes][key]
      RUNTIME[:recipes][key]
    elsif raw_recipes.include?(key)
      raw_recipe(key)
    else
      fail "Unknown key #{key}: not a runtime recipe or a raw recipe"
    end
  end

  def runtime_subgroup(key)
    if RUNTIME[:subgroups][key]
      RUNTIME[:subgroups][key]
    else
      fail "Unknown subgroup #{key}: not a runtime subgroup or a raw subgroup"
    end
  end

  def runtime_category(key)
    if RUNTIME[:categories][key]
      RUNTIME[:categories][key]
    else
      fail "Unknown category #{key}: not a runtime category or a raw category"
    end
  end
end
