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
