# CONTRIBUTING

## Building docker image:

```
docker build -t flask-smorest-api .
```

### Running docker file with on the fly debugging:
```
docker run -dp 5000:5000 -w //app -v "$(Get-Location)://app" flask-smorest-api sh -c "flask run --host 0.0.0.0"
```