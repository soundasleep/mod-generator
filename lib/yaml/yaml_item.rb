class YamlItem < ModItem
  include YamlHelpers

  def enabled
    yaml["enabled"] || super
  end

  def place_result
    if has_runtime_entity?(name)
      runtime_entity(name)
    else
      super
    end
  end
end
