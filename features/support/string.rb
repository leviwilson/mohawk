class String
  def to_field
    self.gsub(/ /, "_")
  end
end
