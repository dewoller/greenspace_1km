the_plan <-
  drake_plan(

   ## Plan targets in here.
             df_hospitals = read_csv( 'data/hospital_locations.csv'),
             df_neighbours = get_neighbours( df_hospitals ),
             df_pt_segments = get_segments( df_neighbours ),
             df_pt_segments_small = df_pt_segments %>% select(-directions),
             df_gtfs_melbourne = load_gtfs(),
             df_covid_testing = read_csv('data/COVID19-Victorian-Testing-Clinics-Public-Spreadsheet - vic-covid-testing.csv'),
             df_covid_geo = revgeo_address( df_covid_testing) ,
             df_covid_closest_pt = closest_pt( df_gtfs_melbourne, df_covid_geo),
             df_pt_to_covid = closest_covid( df_gtfs_melbourne, df_covid_closest_pt),
             map_sa1 = read_sf("data/sa1/SA1_2016_AUST.shp"),
             map_remoteness = read_sf("data/remoteness/RA_2016_AUST.shp"),


            a=TRUE
)
