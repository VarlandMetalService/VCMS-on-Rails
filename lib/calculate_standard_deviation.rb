def average(values)
  return 0 if values.size == 0
  return values.inject(0, :+) / values.size
end

def standard_deviation(values)
  return 0 if values.size == 1
  mean = average(values)
  diff_from_mean = values.map {|v| v - mean }
  squared_differences = diff_from_mean.map {|d| d** 2 }
  sum_squared_differences = squared_differences.inject(0, :+)
  Math.sqrt(sum_squared_differences / (values.size - 1))
end