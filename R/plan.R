

max_distance = 30
the_plan <-
  drake_plan(

             map_mesh= read_sf( 'data/meshblocks/MB_2016_VIC.shp') ,

             df_mesh_detail = read_excel("data/2016 census mesh block counts.xls", sheet="Table 2", skip=5,
                          na='Cells in this table have been randomly adjusted to avoid the release of confidential data.') %>%
               bind_rows( read_excel("data/2016 census mesh block counts.xls", sheet="Table 2.1", skip=5,
                          na='Cells in this table have been randomly adjusted to avoid the release of confidential data.')) %>%
               drop_na(1) %>%
               rename( MB_CODE16 = MB_CODE_2016) %>%
               mutate( MB_CODE16 = as.character( MB_CODE16) ),

             df_mesh_centroids = 
               map_mesh  %>%
               st_transform( 3577) %>%
               st_centroid() %>%
               st_transform(., '+proj=longlat +ellps=GRS80 +no_defs') %>%
               # since you want the centroids in a second geometry col:
               st_coordinates() %>%
               as_tibble() %>%
               set_names('mc_lon','mc_lat') %>%
               mutate( MB_CODE16 = map_mesh %>% pluck( 'MB_CODE16' )),

             df_covid_test = read_csv( 'data/COVID19-Victorian-Testing-Clinics-Public-Spreadsheet - vic-covid-testing.csv') %>%
               janitor::clean_names() %>%
               mutate( id = row_number()) ,
             df_covid_test_location = address_to_lonlat( df_covid_test ),
             df_crow_distances = calculate_crow_distances( df_covid_test_location, df_mesh_centroids),
#             df_mesh_in_reach = target( exclude_distant_meshes( df_crow_distances, maximum_distance),
#                                                   transform=map(maximum_distance=max_distances)),
             df_mesh_in_reach = exclude_distant_meshes( df_crow_distances, max_distance),
             df_population_in_reach = calculate_population_in_reach( df_mesh_in_reach, df_mesh_detail),
             df_driving_time = calculate_driving_time( df_mesh_in_reach),

             a=TRUE
  )

check1 = function() {
  plot(st_geometry(map_mesh))
  plot(df_mesh_centroids, add = T, col = 'red', pch = 19)

  df_mesh_in_reach_5
  drake_cache()
}


calc_means <- function(df, var, n) {
  pb <- progress_estimated(n)
  var <- enquo(var)
  map_df(seq_len(n), ~calc_mean(df = df, var = var, pb = pb))
}

calc_mean <- function(df, var, pb) {
  pb$pause(1.2)$tick()$print()
  df %>%
    sample_n(nrow(df), replace = T) %>%
    summarise(m = mean(!!var))
}

