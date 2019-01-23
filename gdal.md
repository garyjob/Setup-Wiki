# Converting Shapefile to geojson

## Installation
Installing library on mac os
```
brew install gdal
```

## Usage
```
ogr2ogr -f GeoJSON OUTPUT.geojson INPUT.shx
```

Example
```
ogr2ogr -f GeoJSON monroe_county.geojson 05500cys98cu.shx
```