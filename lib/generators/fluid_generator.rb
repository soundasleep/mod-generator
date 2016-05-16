class FluidGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "fluids.lua", generate_fluids
  end

  private

  def root_path
    "/prototypes/"
  end

  def generate_fluids
    "
    data:extend({
      #{extended_data.map { |c| to_lua(c) }.join(",\n\n")}
    })
    "
  end

  def extended_data
    data.fluids.map { |c| fluid_json(c) }
  end

  def fluid_json(fluid)
    {
      type: "fluid",
      name: fluid.name,
      icon: mod_path(fluid.icon),
      order: fluid.order,
      base_color: to_colour(fluid.base_colour),
      flow_color: to_colour(fluid.flow_colour),

      # these all seem to never change
      default_temperature: 25,
      max_temperature: 100,
      pressure_to_speed_ratio: 0.4,
      flow_to_energy_ratio: 0.59,
      heat_capacity: "1KJ",
    }
  end
end
