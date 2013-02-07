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

