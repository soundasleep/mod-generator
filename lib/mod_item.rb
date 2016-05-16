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