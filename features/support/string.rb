class String
  def to_field
    self.gsub(/ /, "_").downcase
  end
end
