class LocaleGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "names.cfg",  locale_data
  end

  private

  def root_path
    "/locale/en/"
  end

  def locale_data
    "
[entity-name]
#{to_ini(entity_names)}

[entity-description]
#{to_ini(entity_descriptions)}

[item-name]
#{to_ini(item_names)}

[item-description]
#{to_ini(item_descriptions)}

[fluid-name]

[recipe-name]
#{to_ini(recipe_names)}

[technology-name]
#{to_ini(technology_names)}

[technology-description]
#{to_ini(technology_descriptions)}

[item-group-name]
#{to_ini(item_group_names)}

[autoplace-control-names]
#{to_ini(autoplace_control_names)}
    "
  end

  def entity_names
    labels_for(data.resources)   # + data.buildings?
  end

  def entity_descriptions
    descriptions_for(data.resources)   # + data.buildings?
  end

  def item_names
    labels_for(data.items)
  end

  def item_descriptions
    descriptions_for(data.items)
  end

  def autoplace_control_names
    labels_for(data.resources)
  end

  def recipe_names
    labels_for(data.recipes)
  end

  def technology_names
    labels_for(data.technologies)
  end

  def technology_descriptions
    descriptions_for(data.technologies)
  end

  def item_group_names
    labels_for(data.recipe_categories + data.categories)
  end

  def labels_for(data)
    locales_for(data, :label)
  end

  def descriptions_for(data)
    locales_for(data, :description)
  end

  def locales_for(data, method = :label)
    data.reject { |item| item.send(method).nil? }
        .map { |item| [item.name, item.send(method)] }
        .uniq
  end
end
