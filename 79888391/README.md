Buid:

```
docker build -t cmpsr .
```

Run:

```
docker run -it --name cmpsr -p 8000:8000 \
  -v "$(pwd)":/var/www/html \
  -v /var/www/html/vendor \
  -v /var/www/html/storage \
  -v /var/www/html/bootstrap/cache \
  --env-file .env \
  cmpsr
```

Run tests:
```
docker exec -it cmpsr php artisan dusk
```