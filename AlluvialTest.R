install.packages(c("tidyverse", "ggplot2", "alluvial", "ggalluvial"))
library(alluvial)
library(ggalluvial)
library(tidyverse)

grouped_data <- Alluvial.Plot.Test.1 %>% 
  group_by(PbEl04Residue, C2Residue) %>%
  summarise(Freq = n())
grouped_data_mut <- grouped_data %>% 
  mutate(across(c(PbEl04Residue, C2Residue)))

#ggplot is the main function that renders the plot
ggplot(as.data.frame(grouped_data), 
       aes(y = Freq, 
         axis1 = PbEl04Residue, 
         axis2 = C2Residue,)) +
geom_alluvium(aes(fill = PbEl04Residue)) +
  geom_alluvium(color="white")+
  #geom_stratum receives a dataset of the horizontal 
  #(x) and vertical (y) positions of the strata of an alluvial plot.
  #It plots rectangles for these strata (columns) of a provided width
  geom_stratum(color = "grey", aes(fill = PbEl04Residue)) +
  geom_text(family = "Courier New", size = 4, stat = "stratum", aes(label = after_stat(stratum))) +
#The "strat = stratum" argument here references
#that the text present here is to be based on 
#stratum (columns) regarding the grouped data data frame
  ggtitle("Interactions between PbEL04 Residues and C2 Residues") +
  #coord_flip() +
  theme_void()
