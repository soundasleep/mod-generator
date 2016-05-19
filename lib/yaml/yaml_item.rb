class YamlItem < ModItem
  include YamlHelpers

  def description
    yaml["description"] || super
  end
end
