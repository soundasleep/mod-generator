class ModGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "info.json", JSON.pretty_generate(generate_info)
    write_file! "data.lua", generate_data
    write_file! "data-updates.lua", generate_data_updates

    CategoryGenerator.new(target, data).generate!
    ItemGenerator.new(target, data).generate!
    RecipeGenerator.new(target, data).generate!
    TechnologyGenerator.new(target, data).generate!

    ImagesGenerator.new(target, data).generate!
    CategoryImagesGenerator.new(target, data).generate!
    TechnologyImagesGenerator.new(target, data).generate!
  end

  private

  def root_path
    "/"
  end

  def generate_info
    {
      "name": "#{data.name}",
      "version": "0.1.0",
      "title": "Generated mod",
      "author": "",
      "contact": "",
      "homepage": "",
      "description": "",
      "dependencies": [
        "base >= 0.12.0"
      ]
    }
  end

  def generate_data
    '
    require("prototypes.category")
    require("prototypes.items")
    require("prototypes.recipes")
    require("prototypes.technology")

    data.raw.item["raw-wood"].stack_size = 100
    '
  end

  def generate_data_updates
    '
    -- currently empty
    '
  end
end
