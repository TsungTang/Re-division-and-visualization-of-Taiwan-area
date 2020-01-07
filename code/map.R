library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=120.5, lat=23.5, popup="The birthplace of R")
m  # Print the map


taiwan_shp <- readShapeSpatial("D:\\TWN_adm_shp\\TWN_adm2.shp")
map(regions='Taiwan')
