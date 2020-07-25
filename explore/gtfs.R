
source('_drake.R')

extract_gtfs('data/tmp/5/google_transit.zip') %>%
  gtfs_timetable() %>%
  { . } -> rv


rv %>%
  pluck('stops') %>%
  terse::terse()

rv %>%
  pluck('stops') %>%
  as_tibble() %>%
  filter( str_detect(stop_name, 'Flinders Street Rai')) %>%
  head(1) %>%
  pluck('stop_name') %>% clipr::write_clip()

  terse::terse()

rv %>%
  pluck('stops' )%>%
  count(wheelchair_boarding)

  terse::terse()

  gtfs_isochrone( rv, from="Flinders Street Railway Station/Flinders St (Melbourne City)",                      start_time = 12 * 3600 + 120,
                 end_time = 12 * 3600 + 720)  %>% plot()



