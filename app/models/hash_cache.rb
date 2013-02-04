class HashCache
  def initialize
    @cache = {}
  end

  def add(hash)
    #instance_variable_set("@_#{hash}",nil)
    @cache[hash] = nil
  end

  def include?(hash)
    #instance_variable_defined?("@_#{hash}")
    @cache.has_key?(hash)
  end
end
