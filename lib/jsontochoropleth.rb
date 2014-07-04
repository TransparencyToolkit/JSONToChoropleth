require 'json'

class JSONToChoropleth
  def initialize(input, location, number)
    @input = JSON.parse(input)
    @location = location
    @number = number
  end

  def genfill
    countryhash = Hash.new

    rangehash = Hash.new
    fullcount = 0
    @input.each do |r|
      fullcount = fullcount + r[@number].to_f
    end

    average = fullcount.to_f/@input.length.to_f

    rangehash["#FFFF99"] = average/3
    rangehash["#FFFF00"] = average/2
    rangehash["#FFA800"] = average
    rangehash["#FF6800"] = average/0.5
    rangehash["#FF0000"] = average/0.25

    @input.each do |t|
      numusers = t[@number]
      prevv = 0
      count = 0
  
      rangehash.each do |k,v|
        if (numusers > prevv) && (numusers <= v)
          countryhash[t[@location]] = k
        elsif (count == 4) && (numusers >= v)
          countryhash[t[@location]] = k
        end
        prevv = v
        count = count + 1
      end
    end

    return JSON.pretty_generate(countryhash)
  end
end

