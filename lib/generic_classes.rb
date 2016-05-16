# TODO split out into smaller files

class ModSubgroup < GenericItem
  def base?
    false
  end
end

# a built-in; TODO have a list of built-in subgroups and categories
class RawResourceSubgroup < ModSubgroup
  def name
    "raw-resource"
  end

  def base?
    true
  end

  def category
    nil
  end
end
