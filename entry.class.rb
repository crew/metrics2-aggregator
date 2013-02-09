# Represents an entry in the raw log database
class Entry
  # Initialize this instance
  def initialize(line)
    @raw = line
  end

  # Just print out the raw line
  def print
    puts @raw
  end

  # Convert the raw line to json
  def to_json
    a = {'raw' => @raw}
    JSON.generate a
  end
end


