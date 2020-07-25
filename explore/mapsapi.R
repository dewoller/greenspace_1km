source('_drake.R')





read_csv( 'data/hospital_locations.csv')  %>%
  select( id, sector, hospital_name, state, postcode, bed_cat, beds, description) %>%
  left_join( hospital_segments) %>%
  select( -directions, -lon, -lat, -x, -y, -target_lon, -target_lat, -value ) %>% 
  { . } -> df_5km


df_5km %>%
  filter( is.na(duration_transit)) %>%
  count(beds)

  count(hospital_name, sort=TRUE) %>%
  



  ggplot()

hospital_segments

hospital_segments %>%
  select( id, dist, ends_with('transit'), ends_with('walking') ) %>%


hospital_segments %>%
  count(id, sort=TRUE) %>%
  arrange(n)

read_csv( 'data/hospital_locations.csv')  %>%
  filter(id==203)





read_csv( 'data/hospital_locations.csv')  %>%
  anti_join( df_neighbours, by='id')

# min and  max within distance bands
#
# look at the gradient in distance bands
#
# remote vs regional
#
# travel times based on distance bands
#
# Range of travel times within distance bands
#
#
# Q: what about people within distance bands
#
# 0-2, 2-3, 4-6
#
# variability amoung hospitals
#
#
# 150,000 queries
#



df1=google_directions(origin = "Melbourne, Australia",
                     destination = "Sydney, Australia",
                     key = google_maps_geocode_api_key,
                     mode = "driving",
                     simplify = FALSE)


df %>% dput() %>% clipr::write_clip()

terse::terse(df) %>% clipr::write_clip()

library(ggmap)
install.packages('ggmap')


from <- "houston, texas"
to <- "waco, texas"

route_df <- route(from, to, structure = "route")

qmap("college station, texas", zoom = 8) +
  geom_path(
    aes(x = lon, y = lat),  colour = "red", size = 1.5,
    data = route_df, lineend = "round"
  )

qmap("college station, texas", zoom = 6) +
  geom_path(
    aes(x = lon, y = lat), colour = "red", size = 1.5,
    data = route_df, lineend = "round"
  )


read_csv('data/COVID19-Victorian-Testing-Clinics-Public-Spreadsheet - vic-covid-testing.csv') %>%
  janitor::clean_names() %>%
  filter(state=='VIC') %>%
  filter(!is.na(address)) %>%

  remotes::install_github("atfutures/gtfs-router")


