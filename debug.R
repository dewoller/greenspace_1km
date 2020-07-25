options(error=recover)
generate_random_neighbours = function( lon, lat, id, max_distance = 10000, n_neighbours=10) {

  browser()
  my_revgeo  = addMemoization(revgeo)
  print(paste('id = ', id))

  generate_random_points(lon, lat, max_distance = max_distance ) %>%
    head(10) %>%
#    mutate( neighbour_address = map2(target_lon, target_lat, my_revgeo,  provider = 'google', API=google_maps_geocode_api_key, output='string') ) %>%
    mutate(ds= glue::glue('revgeo( {target_lon}, {target_lat},   provider = "google", API=google_maps_geocode_api_key, output="string")' )) %>%
    pluck('ds')

    dput()


    unnest( neighbour_address ) %>%
    unnest( neighbour_address ) %>%
    { . } -> rv

 print(rv)
  rv



 revgeo( 145.044519686526, -37.8122183537358,   provider = "google", API=google_maps_geocode_api_key, output="hash")
}



