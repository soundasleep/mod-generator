class YamlResource < ModOre
  include YamlHelpers

  def map_colour
    r, g, b = yaml["map_colour"].split(" ").map(&:to_f)
    Colour.new(r, g, b)
  end

  def result
    yaml["result"] ? runtime_item(yaml["result"]) : super
  end
end
