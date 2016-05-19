class YamlSubgroup < ModSubgroup
  include YamlHelpers

  def category
    runtime_category(yaml["category"])
  end
end
