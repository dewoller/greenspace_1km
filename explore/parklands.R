source('_drake.R')

loadd(df_mesh_detail)

loadd(df_mesh_lga)


map_lga %>%
  inner_join( df_lga_lockdown by=c('municipality'='lga_name'))

df_mesh_lga %>%
  filter( lga_name != '') %>% 
  inner_join( df_mesh_detail, by='MB_CODE16') 
