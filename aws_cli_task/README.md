# Bash script to find snapshots by time in AWS EBS Snapshots
### What can it do?
Answer the questions about the time frame and provide the owner id (default all).  
**Example:**  
```
How many days older(default 0): 
How many hours older(default 0): 7
How many minutes older(default 0): 
OwnerID(default all): 099720109477
Wait a minute...
[
  {
    "Description": "",
    "OwnerId": "099720109477",
    "StartTime": "2021-07-02T12:31:33.963000+00:00",
    "SnapshotId": "snap-09fd819e75bfdaef3",
    "VolumeSize": 8
  }
]
Will copy snapshots?(yes/no): yes
SnapshotID: snap-09fd819e75bfdaef3
Add more?(yes/no): no
Destination region: us-east-2
{
    "SnapshotId": "snap-05147ad7f74eab086"
}
```
