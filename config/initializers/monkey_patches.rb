class String
  def downcased?
    self.downcase == self
  end

  def upcased?
    self.upcase == self
  end
end

class Array
  def drop(n)
    n < 0 ? self[0...n] : super
  end
end
