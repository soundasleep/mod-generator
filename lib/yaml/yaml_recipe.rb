class YamlRecipe < ModRecipe
  include YamlHelpers

  def overrides
    yaml["overrides"] ? raw_item(yaml["overrides"]) : super
  end

  def ingredients
    yaml["ingredients"].map do |ingredient|
      count, key = ingredient.split(" ", 2)
      [count.to_i, runtime_item(key)]
    end
  end

  def results
    yaml["results"].map do |result|
      count, key = result.split(" ", 2)
      [count.to_i, runtime_item(key)]
    end
  end

  def label
    yaml["label"] || if results.length == 1
      results.first[1].label
    else
      super
    end
  end

  def energy_required
    yaml["energy_required"] || super
  end

  def craftable_by
    yaml["craftable_by"].try!(:to_sym) || super
  end
end
