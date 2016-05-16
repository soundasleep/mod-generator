class RawFluid < ModFluid
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def base?
    true
  end
end

def raw_fluids
  [
    "water",

    "crude-oil", "heavy-oil", "light-oil", "petroleum-gas", "lubricant", "sulfuric-acid",
  ]
end

def raw_fluid(key)
  fail "Unknown raw fluid '#{key}'" unless raw_fluids.include?(key)

  RawFluid.new(key)
end
