class ImagesGenerator
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
    "/graphics/"
  end

  def default_png
    File.binread("default.png")
  end
end
