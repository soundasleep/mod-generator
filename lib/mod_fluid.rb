class ModFluid < GenericItem
  def icon
    "graphics/default.png"
  end

  def colour
    Colour.new(0.95, 0.95, 0)
  end

  def base_colour
    colour
  end

  def flow_colour
    Colour.new(base_colour.r * 0.8, base_colour.g * 0.8, base_colour.b * 0.8)
  end

  def base?
    false
  end

  def type
    "fluid"
  end
end
