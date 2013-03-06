**Notice!** This is all *hackathon code* (written while sleep deprived)
and shouldn't be moved into production until it doesn't suck, and
has some automated testing thrown in.

[![Code Climate](https://codeclimate.com/github/crew/metrics2-aggregator.png)](https://codeclimate.com/github/crew/metrics2-aggregator)

Aggregator
==========

The aggregator will take data from the source `who` and the given windows log
files

The aggregator will generate a PUT request with the following format
```
{
  "os": "ubuntu",
  "machine": "agentx",
  "users": 3,
  "timestamp": 1360218630
}
```

