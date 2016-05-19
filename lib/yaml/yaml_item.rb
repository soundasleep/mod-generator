class YamlItem < ModItem
  include YamlHelpers

  def enabled
    yaml["enabled"] || super
  end
end
