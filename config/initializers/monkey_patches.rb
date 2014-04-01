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

module Enumerable
  def group_by_recursive(*props)
    groups = group_by(&props.first)
    if props.count == 1
      groups
    else
      groups.merge(groups) do |group, elements|
        elements.group_by_recursive(*props.drop(1))
      end
    end
  end
end
