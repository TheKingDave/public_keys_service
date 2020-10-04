# Public SSH keys API

I created this API because I wanted to update the access keys of my server with my Github keys. Once there was an API endpoint to get the keys of a user in text form but that disappeared. So I created this API to get those keys. While doing that I also export the keys in other formats.

https://public-keys-service.herokuapp.com

### Example usage
```bash
#!/bin/bash
cd /root/.ssh/
cp authorized_keys bak.authorized_keys
curl -f https://keys.service.thekingdave.com/api/keys/thekingdave -o authorized_keys
```
Perfekt to be performed in an crontab
