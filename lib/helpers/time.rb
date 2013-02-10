# Need a way to go from an ascii representation of time to a Time
# instance
class Time
  # Creates a Time instance from an asctime
  # ex: "Wed Apr  9 08:56:03 2003"
  def self.from_asctime(asctime)
    # ["Apr", "9", "08:56:03", "2003"]
    timestamp = asctime.split.drop(1)
    # [8, 56, 3]
    time = timestamp[2].split(':').map { |x| x.to_i }
    Time.local(timestamp[3].to_i, timestamp[0], timestamp[1].to_i,
               time[0], time[1], time[2])
  end
end
