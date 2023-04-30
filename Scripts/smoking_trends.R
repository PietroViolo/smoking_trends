#---------------------------------------------------------------------------#
# Nom : smoking_trends.R                                    			          #
# Description : Data viz on murderdata                                      #
# Auteur : Pietro Violo                                                     #
# Date : April 30  2023                                                     #
# Modifications :                                                           #
#---------------------------------------------------------------------------#

options(scipen=999)
rm(list = ls())

#---------------------------------------------------------------------------#
# Library and data                                                          #
#---------------------------------------------------------------------------#
library(tidyverse)


df <- read.csv("./Data/comparing-the-share-of-men-and-women-who-are-smoking.csv") %>% 
  filter(Entity %in% c("Canada", "United States", "France", "Germany", "Italy", "Japan", "Russia", "United Kingdom")) %>% 
  filter(!is.na(Prevalence.of.current.tobacco.use..males....of.male.adults.))

# Order by biggest loser

order <- df %>% filter(Year == 2000) %>% arrange(Prevalence.of.current.tobacco.use..males....of.male.adults.) %>% 
  pull(Entity) %>% unique() %>% rev()

df <- df %>% mutate(Entity = factor(Entity, levels = order))


#---------------------------------------------------------------------------#
# Visualization                                                             #
#---------------------------------------------------------------------------#

df %>% filter(Year == 2000) %>% 
  ggplot(aes(x = Entity, y = Prevalence.of.current.tobacco.use..males....of.male.adults.)) + 
  geom_bar(stat = "identity") +
  geom_bar(data = df %>% filter(Year == 2020),
           aes(x = Entity, y = Prevalence.of.current.tobacco.use..males....of.male.adults.), 
           stat = "identity",
           color = "red")
