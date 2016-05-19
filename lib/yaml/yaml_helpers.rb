module YamlHelpers
  attr_reader :yaml

  def initialize(file)
    @yaml = YAML.load(File.read(file))
    @name = File.basename(file, ".yml")
  end

  def name
    @name
  end

  def title
    yaml["title"] || super
  end

  def description
    yaml["description"] || super
  end

  def label
    yaml["label"] || super
  end

  def runtime_item(key)
    RUNTIME[:items][key] || raw_item(key)
  end
end
