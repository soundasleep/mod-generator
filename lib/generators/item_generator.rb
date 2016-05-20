class ItemGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "items.lua", generate_category
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
    data.items.map { |c| item_json(c) }
  end

  def item_json(item)
    {
      type: "item",
      name: item.name,
      icon: mod_path(item.icon),
      flags: item.flags,
      subgroup: item.subgroup.name,
      order: item.order,
      stack_size: item.stack_size
    }.merge(item_place_json(item))
  end

  def item_place_json(item)
    return {} unless item.place_result

    {
      place_result: item.place_result.name,
    }
  end
end
