class ModEntity < GenericItem
  def flags
    ["placeable-player", "player-creation"]
  end

  def mining_hardness
    0.2
  end

  def mining_time
    0.5
  end

  def health
    150
  end

  def corpse
    if width == 3 && height == 3
      raw_corpse("big-remnants")
    elsif width == 2 && height == 2
      raw_corpse("medium-remnants")
    elsif width == 1 && height == 1
      raw_corpse("small-remnants")
    else
      fail "Can't find a corpse for something #{width}x#{height}"
    end
  end

  def blocking?
    false
  end

  def electricity?
    true
  end

  def electricity_priority
    2
  end

  def two_deep_mult(array_of_arrays, factor)
    array_of_arrays.map do |array|
      array.map { |v| v * factor }
    end
  end

  def collision_box
    # light (1x1)  seems to be [-0.15, 0.15] and [-0.5, 0.5]
    # turret (2x2) seems to be [-0.7, 0.7] and [1, 1]
    # radar (3x3)  seems to be [-1.4, 1.4] and [1.5, 1.5]
    if blocking?
      two_deep_mult(selection_box, 0.95)
    else
      two_deep_mult(selection_box, 0.75)
    end
  end

  def selection_box
    [
      [-width / 2.0, -height / 2.0],
      [ width / 2.0,  height / 2.0],
    ]
  end

  def pictures
    {
      filename: picture,
      priority: "low",
      width: picture_width,
      height: picture_height,
      apply_projection: false,
      direction_count: frames_width * frames_height,
      line_length: frames_width,
      shift: frames_shift,
    }
  end

  def vehicle_impact_sound
    {
      # TODO can maybe create raw_sound()
      filename: "__base__/sound/car-metal-impact.ogg",
      volume: 0.65,
    }
  end

  def working_sound
    false
  end

  def working_volume
    2
  end

  def base?
    false
  end
end
