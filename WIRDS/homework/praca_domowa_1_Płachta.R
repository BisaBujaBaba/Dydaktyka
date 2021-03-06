library(XLConnect)
library(dplyr)
library(ggplot2)
library(scales)
fName <- "C:/Users/Szymon/Desktop/gospodarstwa.xls"
wb <- loadWorkbook(fName)
gos <- readWorksheet(wb, sheet = "gospodarstwa")
gos$woj <- factor(gos$woj,
                  levels = c("02", "04", "06", "08", "10", "12", "14", "16", "18", "20",
                             "22", "24", "26", "28", "30", "32"),
                  labels = c("dolno�l�skie", "kujawsko-pomorskie", "lubelskie", "lubuskie", "��dzkie",
                             "ma�opolskie", "mazowieckie", "opolskie", "podkarpackie", "podlaskie",
                             "pomorskie", "�l�skie", "�wi�tokrzyskie", "warmi�sko-mazurskie",
                             "wielkopolskie", "zachodniopomorskie"))
gos$klm <- factor(gos$klm, 
                  levels = 6:1, 
                  labels = c("wie�", "miasto<20","[20,100)","[100,200)","[200,500)",">=500"), ordered=T)
         
gos %>% 
  count(klm,woj) %>%
  group_by(woj) %>%
  mutate(proc = n/sum(n)) %>%
  ggplot(data = ., aes(x = " ", y = proc, group = klm, fill = klm)) +
  xlab("wojew�dztwo") +
  scale_y_continuous("odsetek respondent�w", labels =percent) +
  geom_bar(stat = 'identity', col='black') +
  facet_wrap(~woj, ncol=1) + 
  coord_flip() +
  ggtitle("Udzia� respondent�w wed�ug klasy miejscowo�ci")