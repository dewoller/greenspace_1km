calculate_driving_time <- function( df_mesh_in_reach ) {

  n_row_per_query = 1000
  options(osrm.server = "http://localhost:5000/")
  getOption("osrm.server")
  df_mesh_in_reach %>%
    drop_na() %>%
    { . } -> df_mesh_rv

   df_mesh_rv %>%
    select( id=MB_CODE16, lon = mc_lon, lat=mc_lat) %>%
    { . } -> df_mesh_location
#
  df_mesh_rv %>%
    select( id, lon = covid_lon, lat=covid_lat) %>%
    { . } -> df_covid_location
#
  nlocation = df_covid_location %>% nrow()
  npass = floor(nlocation / n_row_per_query) + 1
  rv = c()
  t0 = Sys.time()
  for (i in 1:npass) {
    elapsed = Sys.time() - t0
    eta = (t0 + (elapsed / i ) * npass - Sys.time()) / 3600
    print(glue::glue('{i}/{npass} , {elapsed} seconds, eta {eta} hours'))
    start_index = ((i-1)*n_row_per_query)+1
    end_index = pmin( start_index + n_row_per_query-1, nlocation)

    slice = osrmTable(src = df_mesh_location[start_index:end_index,],
                      dst = df_covid_location[start_index:end_index,],
                      measure='duration') %>%
    pluck('durations')

    rv = c(rv, slice)

  }
  df_mesh_rv %>%
    mutate( duration = rv)
}
