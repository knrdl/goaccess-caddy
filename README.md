# goaccess-caddy
goaccess analytics for caddy server as standalone webservice


## basic setup
```yaml
version: '2.4'

services:
  goaccess:
    image: ghcr.io/knrdl/goaccess-caddy:edge
    restart: always
    environment:
      WS_URL: 'wss://logs.example.org:443/goaccess/'  # can be omitted on localhost
    volumes:
      - .//caddy/logs:/log:ro
      - ./cache:/cache:rw  # optional
    ports:
      - 8080:8080
    mem_limit: 100m
```

## setup with geoip resolution

```yaml
version: '2.4'

services:
  goaccess:
    image: ghcr.io/knrdl/goaccess-caddy:edge
    restart: always
    environment:
      WS_URL: 'wss://logs.example.org:443/goaccess/'  # can be omitted on localhost
    volumes:
      - ./caddy/logs:/log:ro
      - ./geoip:/geoip:ro
      - ./cache:/cache:rw  # optional
    ports:
      - 8080:8080
    mem_limit: 100m

  geoip:
    image: maxmindinc/geoipupdate
    restart: always
    environment:
      - GEOIPUPDATE_ACCOUNT_ID=123456
      - GEOIPUPDATE_LICENSE_KEY=XXXXXXXXXXXXXXXX
      - GEOIPUPDATE_EDITION_IDS=GeoLite2-ASN GeoLite2-City GeoLite2-Country
      - GEOIPUPDATE_FREQUENCY=168
    volumes:
      - ./geoip:/usr/share/GeoIP
    mem_limit: 100m
```
