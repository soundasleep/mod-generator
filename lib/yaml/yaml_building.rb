class YamlBuilding < ModEntity
  include YamlHelpers

  def mining_hardness
    yaml["mining_hardness"] || super
  end

  def mining_time
    yaml["mining_time"] || super
  end

  def health
    yaml["health"] || super
  end

  def electricity_priority
    yaml["electricity_priority"] || super
  end

  def item
    runtime_item(yaml["item"]) || super
  end

  def blocking?
    yaml["blocking"] || super
  end

  def frames_shift
    if yaml["frames_shift"]
      yaml["frames_shift"].split(" ", 2).map(&:to_i)
    else
      super
    end
  end

  def working_sound
    yaml["working_sound"] || super
  end

  def working_volume
    yaml["working_volume"] || super
  end
end
