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