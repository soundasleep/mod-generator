class YamlTechnology < ModTechnology
  include YamlHelpers

  def prerequisites
    (yaml["prerequisites"] || []).map do |key|
      runtime_technology(key)
    end
  end

  def ingredients
    yaml["ingredients"].map do |ingredient|
      count, key = ingredient.split(" ", 2)
      [count.to_i, runtime_item(key)]
    end
  end

  def ingredient_count
    yaml["ingredient_count"] || super
  end

  def research_time
    yaml["research_time"] || super
  end

  def unlocked_recipes
    (yaml["unlocked_recipes"] || []).map do |key|
      runtime_recipe(key)
    end
  end

  def enabled
    yaml["enabled"] || super
  end
end
