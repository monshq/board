class HashCache
  def add(hash)
    instance_variable_set("@_#{hash}",nil)
  end
  def include?(hash)
    instance_variable_defined?("@_#{hash}")
  end
end
