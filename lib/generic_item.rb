class GenericItem
  def name
    self.class.name.gsub(/[A-Z]/, ' \0').strip.gsub(" ", "-").downcase
  end

  # default: at end
  def order
    "z-z"
  end

  def label
    name.split("-").map(&:capitalize).join(" ")
  end

  def description
    nil
  end
end
