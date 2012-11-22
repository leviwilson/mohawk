class String
  def to_field
    self.gsub(/ /, "_").downcase
  end

  def to_class
    Object.const_get self
  end
end
