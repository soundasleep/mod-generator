class EntityGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "entities.lua", generate_entities
  end

  private

  def root_path
    "/prototypes/"
  end

  def generate_entities
    "
    data:extend({
      #{data.entities.map { |c| to_lua(entity_json(c)) }.join(",\n\n")}
    })
    "
  end

  def entity_json(entity)
    {
      type: entity.type,
      name: entity.name,
      icon: mod_path(entity.item.icon),
      flags: entity.flags,
      order: entity.order,

      minable: {
        hardness: entity.mining_hardness,
        mining_time: entity.mining_time,
        result: entity.item.name,
      },

      max_health: entity.health,
      corpse: entity.corpse.name,

      resistances: [
        { type: "fire", percent: 70 },
      ],

      collision_box: entity.collision_box,
      selection_box: entity.selection_box,

      # pictures
      pictures: entity.pictures,

      # sound
      vehicle_impact_sound: entity.vehicle_impact_sound,
    }.merge(entity_energy_json(entity))
      .merge(entity_sound_json(entity))
      .merge(additional_entity_json(entity))
  end

  def entity_energy_json(entity)
    return {} unless entity.electricity?

    {
      energy_source: {
        type: "electric",
        usage_priority: case entity.electricity_priority
          when 2
            "secondary-input"
          else
            raise "Unknown electricity_priority #{entity.electricity_priority}"
          end
      },
      energy_usage: entity.power,
    }
  end

  def entity_sound_json(entity)
    return {} unless entity.working_sound

    {
      working_sound: {
        sound: [{
          filename: entity.working_sound,
        }]
      },
      apparent_volume: entity.working_volume,
    }
  end

  def additional_entity_json(entity)
    case entity.type
      when "radar"
        {
          energy_per_sector: entity.energy_per_sector,
          max_distance_of_sector_revealed: entity.max_distance_of_sector_revealed,
          max_distance_of_nearby_sector_revealed: entity.max_distance_of_nearby_sector_revealed,
          energy_per_nearby_scan: entity.energy_per_nearby_scan,
        }
      else
        {}
    end
  end
end
