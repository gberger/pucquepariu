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

  def ms
    (to_f * 1000).to_i
  end

  def to_date
    Date.parse(self.to_s)
  end
end
