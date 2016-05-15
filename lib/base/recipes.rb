class RawRecipe < ModRecipe
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

def raw_recipes
  raw_items
end

def raw_recipe(key)
  fail "Unknown raw recipe '#{key}'" unless raw_recipes.include?(key)

  RawRecipe.new(key)
end