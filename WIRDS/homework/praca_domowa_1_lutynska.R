library(XLConnect)
library(dplyr)
library(ggplot2)
wb <- loadWorkbook('D:/Studia/IVr 2 semestr/WiRDS/Zaj.2/gospodarstwa.xls')
gosp <- readWorksheet(wb,'gospodarstwa')
vars <- readWorksheet(wb,'opis cech')
vars_labels <- readWorksheet(wb,'opis wariantów cech')


fac <- gosp %>% #factor-przypisujemy etykiety
  mutate(woj = factor( x = woj, #zmienna ktora edytujemy
                       levels = c('02','04','06','08','10','12','14',
                                  '16','18','20','22','24','26',
                                  '28','30','32'),
                       labels = c('dolnoslaskie','kujawsko-pomorskie',
                                  'lubelskie','lubuskie',
                                  'łódzkie','małopolskie',
                                  'mazowieckie','opolskie',
                                  'podkarpackie','podlaskie',
                                  'pomorskie','śląskie',
                                  'swietokrzyskie','warminsko-mazurskie',
                                  'wielkopolskie','zachodniopomorskie'),
                       ordered = T),
         klm = factor( x = klm, #zmienna ktora edytujemy
                       levels = 6:1, #jakie poziomy od 1 do 6 co 1
                       labels = c('Wieś',
                                  '<20',
                                  '[20,100)',
                                  '[100,200)',
                                  '[200,500)',
                                  '>=500'),
                       ordered = T))

fac %>%
  count(klm,woj) %>%
  group_by(woj)%>%
  mutate(procent = n/sum(n)) %>%
  ggplot(data = .,
         aes(x = " ",
             y = procent,
             fill = klm)) +
  xlab("Województwo")+
  ylab("Procent")+
  geom_bar(stat = 'identity',
           col=heat.colors) +
  facet_wrap( ~woj, ncol=1)+ 
  coord_flip()