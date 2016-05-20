def raw_corpses
  [
    # demo-remnants.lua
    "big-remnants", "medium-remnants", "small-remnants",
    "straight-rail-remnants", "curved-rail-remnants",
    "big-ship-wreck-1", "big-ship-wreck-2", "big-ship-wreak-3",
    "medium-ship-wreck", "small-ship-wreck",
    "big-ship-wreck-grass", "small-ship-wreck-grass",
    "small-scorchmark",
  ]
end

class RawCorpse < ModCorpse
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def icon
    "__base__/graphics/icons/#{name}.png"
  end

  def base?
    true
  end
end

def raw_corpse(key)
  fail "Unknown raw corpse '#{key}'" unless raw_corpses.include?(key)

  RawCorpse.new(key)
end

