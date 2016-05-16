class ResourceGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "resources.lua", generate_category
    write_file! "autoplace-controls.lua", generate_autoplace_controls
    write_file! "noise-layers.lua", generate_noise_layers
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

  def generate_autoplace_controls
    "
    data:extend({
      #{autoplace_controls.map { |c| to_lua(c) }.join(",\n\n")}
    })
    "
  end

  def generate_noise_layers
    "
    data:extend({
      #{noise_layers.map { |c| to_lua(c) }.join(",\n\n")}
    })
    "
  end

  def extended_data
    data.resources.map { |c| resource_json(c) }
  end

  def autoplace_controls
    data.resources.map { |c| autoplace_control_json(c) }
  end

  def noise_layers
    data.resources.map { |c| noise_layer_json(c) }
  end

  def resource_json(resource)
    {
      type: "resource",
      name: resource.name,
      icon: mod_path(resource.icon),
      flags: ["placeable-neutral"],
      order: resource.order,
      minable: {
        hardness: resource.hardness,
        mining_particle: "iron-ore-particle",
        mining_time: resource.mining_time,
        result: resource.result.name,
      },
      collision_box: [[-0.1, -0.1], [0.1, 0.1]],
      selection_box: [[-0.5, -0.5], [0.5, 0.5]],
      autoplace: {
        control: resource.name,
        sharpness: 1,
        richness_multiplier: 15000 * resource.richness_multiplier,
        richness_base: 650 * resource.richness_multiplier,
        size_control_multiplier: 0.06 * resource.size_multiplier,
        peaks: generate_peaks(resource)
      },
      stage_counts: resource.stage_counts,
      stages: {
        sheet: {
          filename: mod_path(resource.sheet),
          priority: "extra-high",
          width: 38,
          height: 38,
          frame_count: resource.sheet_frames,
          variation_count: resource.stage_counts.length,
        },
      },
      map_color: to_colour(resource.map_colour),
    }
  end

  def to_colour(c)
    {
      r: c.r,
      g: c.g,
      b: c.b,
    }
  end

  def generate_peaks(resource)
    [
      {
        influence: 0.2,
        starting_area_weight_optimal: 0,
        starting_area_weight_range: 0,
        starting_area_weight_max_range: 2,
      },
      {
        influence: 0.3,
        starting_area_weight_optimal: 1,
        starting_area_weight_range: 0,
        starting_area_weight_max_range: 2,
      },
      {
        influence: 0.65,
        noise_layer: resource.name,
        noise_octaves_difference: -1.9,
        noise_persistence: 0.3,
        starting_area_weight_optimal: 0,
        starting_area_weight_range: 0,
        starting_area_weight_max_range: 2,
      },
      {
        influence: 0.57,
        noise_layer: resource.name,
        noise_octaves_difference: -2.3,
        noise_persistence: 0.4,
        starting_area_weight_optimal: 1,
        starting_area_weight_range: 0,
        starting_area_weight_max_range: 2,
      },
    ] +
      ["iron-ore", "copper-ore", "coal", "stone"].map do |force|
        {
          influence: -0.2,
          max_influence: 0,
          noise_layer: force,
          noise_octaves_difference: -2.3,
          noise_persistence: 0.45,
        }
      end
  end

  def autoplace_control_json(resource)
    {
      type: "autoplace-control",
      name: resource.name,
      richness: true,
      order: resource.order,
    }
  end

  def noise_layer_json(resource)
    {
      type: "noise-layer",
      name: resource.name,
    }
  end
end

