class CategoryGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "category.lua", generate_category
  end

  private

  def root_path
    "/prototypes/"
  end

  def generate_category
    "
    data:extend({
      #{extended_data.map { |c| to_lua(c) }.join(",\n\n")}
    })
    "
  end

  def extended_data
    data.categories.map { |c| category_json(c) } +
      data.recipe_categories.map { |c| recipe_category_json(c) } +
      data.subgroups.map { |c| subgroup_json(c) }
  end

  def category_json(category)
    {
      type: "item-group",
      name: category.name,
      order: category.order,
      inventory_order: category.inventory_order,
      icon: mod_path(category.icon),
    }
  end

  def recipe_category_json(category)
    {
      type: "recipe-category",
      name: category.name,
    }
  end

  def subgroup_json(subgroup)
    {
      type: "item-subgroup",
      group: subgroup.category.try!(:name),
      name: subgroup.name,
      order: subgroup.order,
    }
  end
end
