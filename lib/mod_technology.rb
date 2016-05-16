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
