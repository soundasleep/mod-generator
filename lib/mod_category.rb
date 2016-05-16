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
