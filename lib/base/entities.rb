def raw_entities
  [
    # TODO fill this out
  ]
end

class RawEntity < ModEntity
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def icon
    "__base__/graphics/entity/#{name}/#{name}.png"
  end

  def base?
    true
  end
end

def raw_entity(key)
  fail "Unknown raw entity '#{key}'" unless raw_entities.include?(key)

  RawEntity.new(key)
end

