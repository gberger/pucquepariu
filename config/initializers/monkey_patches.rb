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

class Time
  def semester
    month <= 6 ? 1 : 2
  end
end
