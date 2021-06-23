# Docker task
### Build docker image
```docker build -t 'name_for_image' .```

### Run docker container
```docker run -d -p 8080:8080 --name 'name_for_container' 'name of image```

### What is in 'source' folder?
```test_site_app_4``` - is web python app on flask  
```libgcc_s.so.1``` - required library for app  
```cert.pem and key.pem``` - these the self signed certificate and the key for SSL  

### What is can this app?
```
curl -XPOST -d'{"animal":"cow", "sound":"moooo", "count": 3}' https://yourhost/
🐄 says moooo
🐄 says moooo
🐄 says moooo
Made with ❤️ by Antosha

curl -XPOST -d'{"animal":"elephant", "sound":"whoooaaa", "count": 5}' https://yourhost/
🐘 says whoooaaa
🐘 says whoooaaa
🐘 says whoooaaa
🐘 says whoooaaa
🐘 says whoooaaa
Made with ❤️ by Antosha
```