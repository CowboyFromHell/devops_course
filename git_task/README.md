# Overview pull requests in git repositories

**Run this script** ```python3 git_play.py``` **and answer questions or with key '-u/--url'** ```python3 git_play.py --url github.com/user/repo```  

### Example of the running script:  
```
python3 git_play.py -u https://github.com/kubernetes/kubernetes/pulls

1) Show open pull requests
2) Show most productive contributors
3) Show pull requests with contributor and labels
4) Show commits since a specific date
Enter the number from 1 to 4: 2
The number of pages to search: 5
The number of items on page: 50

The number of all authors: 136
Most popular authors (PR > 1):

Author: gy95
The number of PR: 10

Author: BenTheElder
The number of PR: 9

Author: gnufied
The number of PR: 9

Author: mengjiao-liu
The number of PR: 8

Author: pacoxu
The number of PR: 6

Author: tkashem
The number of PR: 6
...
```
