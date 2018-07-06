module Statistics
  def self.sum array
    array.inject(0){|accum, i| accum + i}
  end
  def self.mean array
    sum(array) / array.length.to_f
  end
  def self.variance array
    m = mean array
    sum = array.inject(0){|accum, i| accum + (i - m)**2}
    sum / (array.length - 1).to_f
  end
  def self.sd array
    Math.sqrt(variance array)
  end
  def self.z variable, array
    x = variable
    u = mean array
    o = sd array
    ((x - u) / o.to_f).abs
  end
end
