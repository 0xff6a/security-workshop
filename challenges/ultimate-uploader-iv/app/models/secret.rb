module Secret
  def self.get
    File.read(Rails.root.join('secret')).strip
  end
end
