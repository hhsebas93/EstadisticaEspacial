library(rgdal)
library(sp)
library(sf)
library(leaflet)
library(RColorBrewer)
library(maptools)

datos <- readOGR(getwd(),layer="DAIUPZ")
datos <- spTransform(datos,CRS("+proj=longlat +datum=WGS84"))
# plot(datos)
# View(datos@data)
names(datos@data)

# unique(datos@data$CMMES)
# unique(datos@data$CMIUSCAT)

datosf <- st_as_sf(datos)

pal <- colorNumeric("RdYlBu", domain=datos$CMDS22CONT, na.color = "transparent",reverse=T)

m <- leaflet(datos) %>% 
  addTiles("https://serviciosgis.catastrobogota.gov.co/arcgis/rest/services/Mapa_Referencia/mapa_base_3857/MapServer") %>% #"https://serviciosgis.catastrobogota.gov.co/arcgis/rest/services/Mapa_Referencia/mapa_hibrido/MapServer"
  addPolygons(fillColor = ~pal(CMDS22CONT),weight = 0.5,opacity = 0.1,color = "black"
                ,dashArray = "3",fillOpacity = 0.7) %>% 
  addLegend(pal = pal, values = ~CMDS22CONT, opacity = 0.7, title = NULL,
            position = "bottomright")
m

