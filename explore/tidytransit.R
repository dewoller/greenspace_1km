install.packages('tidytransit')

library(tidytransit)


tidytransit::feedlist %>%
  as_tibble() %>%
  filter( str_detect( loc_t, 'Australia')) %>%
  distinct( url_i) %>%
  pluck('url_i') %>%
  map( function(x) {system( paste( 'firefox', x))} )

  count(loc_t) %>% clipr::write_clip()



loc_t	n
Adelaide SA, Australia	3
Airlie Beach QLD 4802, Australia	1
Alice Springs NT 0870, Australia	1
Bowen QLD 4805, Australia	1
Brisbane QLD, Australia	3
Bundaberg QLD 4670, Australia	1
Burnie TAS 7320, Australia	1
Byron Bay NSW 2481, Australia	1
Cairns QLD, Australia	2
Canberra ACT, Australia	1
Darwin NT, Australia	1
Gladstone QLD 4680, Australia	1
Gympie QLD 4570, Australia	1
Hobart TAS, Australia	1
Innisfail QLD 4860, Australia	1
Kilcoy QLD 4515, Australia	1
Launceston TAS, Australia	1
Mackay QLD 4740, Australia	1
Magnetic Island, Queensland, Australia	2
Maleny QLD 4552, Australia	1
Maryborough QLD 4650, Australia	1
Melbourne VIC, Australia	1
Mornington Peninsula, VIC, Australia	1
New South Wales, Australia	1
Perth WA, Australia	1
Rockhampton QLD, Australia	1
Toowoomba QLD, Australia	1
Townsville QLD, Australia	1
Warwick QLD 4370, Australia	1
Yeppoon QLD 4703, Australia	1
