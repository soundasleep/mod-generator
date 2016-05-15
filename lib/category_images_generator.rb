class CategoryImagesGenerator
  include BaseGenerator

  attr_reader :target, :data

  def initialize(target, data)
    @target = target
    @data = data
  end

  def generate!
    create_dir!

    write_file! "default.png", default_png
  end

  private

  def root_path
    "/graphics/category/"
  end

  def default_png
    File.binread("category.png")
  end
end
