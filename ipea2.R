
#Limpa a memoria R
gc()
memory.limit (9999999999)
gc()




library(data.table)
library(stringr)
library(dplyr)
library(plyr)
library(tidyr)
library(ggplot2)
library(plm)
library(hexbin)


dados<-read.csv2("simulacao_ipea2.csv", stringsAsFactors = FALSE)

attach(dados)

summary(dados)
dados$X<- NULL


#Questão 6

ipea<- dados[dados$orgao=="IPEA" & dados$ano=="2015",]

head(ipea)


nivel<- count(ipea$escolaridade)

any(is.na(nivel))

#soma total das frequencias


total_nivel<- sum(nivel$freq)

nivel$x<- NULL

# Pegando a escolaridade igual a 4

nivel4<- nivel[4,]

# Percentual de trabalhadores

percent4= (nivel4/total_nivel)*100

percent4



#Questão 4
questao4 <- dados$sexo== "M" & dados$uf== "BA" & dados$idade>= "50" & dados$ano== "2019"


head(questao4)
table(questao4)["TRUE"]



mulher <- dados[dados$sexo== "F",]



head(mulher)

mulher$uf<- NULL 
mulher$idade<- NULL
mulher$escolaridade <- NULL
mulher$salario<- NULL

head(mulher)

#Questão 7

questao7<-  mulher[mulher$orgao=="UFSJ" & mulher$ano== "2010",]

questao7<- na.omit(questao7)

any(is.na(questao7))

quantos.na <- colwise(function(x) sum(is.na(x)))
quantos.na(questao7)
           
    count(questao7$raca)       
                      
#Questão 5

mulher$raca<- NULL
count(mulher)

x<- count(mulher)


posit <- order(x[, 'freq'], decreasing = TRUE) # retornar posição do maior valor
maior <- x[posit, c('orgao', 'ano')] 


head(maior)

# QUESTAO 8
head(dados)

dados$salario<- as.numeric(dados$salario)
dados$salario<-  round(dados$salario, digits = 1)



head(dados)
summary(dados)


organizar<- order(dados[, 'ano'], decreasing = FALSE) # retornar posição do maior valor
dados_organizados <- dados[organizar, c('orgao', 'raca',"sexo", "uf","idade","salario","escolaridade", "ano")]



head(dados_organizados)




dados_organizados$idade<- NULL
dados_organizados$ano<- NULL
dados_organizados$uf<- NULL
dados_organizados$orgao<- NULL
dados_organizados$sexo<- NULL

grafico<- count(dados_organizados)



head(grafico)


       


#limpa a memoria
gc()
memory.limit (9999999999)
gc()


  
  set.seed(1)
  n <- 1e7
  
  df <- data.frame(escolaridade = rnorm(grafico$escolaridade), 
                   salario = rnorm(grafico$salario), 
                   z = runif(grafico$freq), 
                   raca = grafico$raca)
  
  ggplot(df, aes(x = escolaridade, y = salario)) +
    geom_hex(bins = 20) +
    facet_wrap(~ raca)
  
  
  
  