class String
  def to_method
    self.gsub(/\W+/, "_").downcase.to_sym
  end
end
