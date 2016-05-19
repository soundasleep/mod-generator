class YamlFluid < ModFluid
  include YamlHelpers

  def colour
    r, g, b = yaml["colour"].split(" ").map(&:to_f)
    Colour.new(r, g, b)
  end
end
