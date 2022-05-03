# ndex

```r
mkdir -p -m 750 youtrack/data youtrack/logs youtrack/conf youtrack/backups
chown -R 13001:13001 youtrack/data youtrack/logs youtrack/conf youtrack/backups
```
docker run --rm -it \
    -v ./youtrack/logs:/opt/youtrack/conf \
    -v ./youtrack/logs:/opt/youtrack/logs \  
        jetbrains/youtrack:2022.1.46592 \
        configure \
        -J-Ddisable.configuration.wizard.on.clean.install=true \
        --base-url=localhost:8333

docker run -it --name youtrack-inst  \
    -v /home/freddy/Projects/current/ndex/youtrack/data:/opt/youtrack/data \
    -v /home/freddy/Projects/current/ndex/youtrack/conf:/opt/youtrack/conf  \
    -v /home/freddy/Projects/current/ndex/youtrack/logs:/opt/youtrack/logs  \
    -v /home/freddy/Projects/current/ndex/youtrack/backups:/opt/youtrack/backups  \
    -p 8333:8080 \
    jetbrains/youtrack:2022.1.46592 \
    configure \
    -J-Ddisable.configuration.wizard.on.clean.install=true \
    --base-url=http://192.168.0.68:8333

docker run -it --name yt  \
    -v /home/freddy/Projects/current/ndex/youtrack/data:/opt/youtrack/data \
    -v /home/freddy/Projects/current/ndex/youtrack/conf:/opt/youtrack/conf  \
    -v /home/freddy/Projects/current/ndex/youtrack/logs:/opt/youtrack/logs  \
    -v /home/freddy/Projects/current/ndex/youtrack/backups:/opt/youtrack/backups  \
    -p 8333:8080 \
    jetbrains/youtrack:2022.1.46592