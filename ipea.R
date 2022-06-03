
library(data.table)
library(stringr)
library(dplyr)
library(plyr)
library(tidyr)


dados<-read.csv2("simulacao_ipea.csv", stringsAsFactors = FALSE)

attach(dados)

summary(dados)

# verificar se tem NA
any(is.na(dados))

quantos.na <- colwise(function(x) sum(is.na(x)))
quantos.na(dados)

#Verificar se tem NaN
quantos.nan <- colwise(function(x) sum(is.nan(x)))

quantos.nan(dados)


# verificar se tem dados nulos 
quantos.null <- colwise(function(x) sum(is.null(x)))

quantos.null(dados)


#verificar se tem dados infinitos
quantos.infinite <- colwise(function(x) sum(is.infinite(x)))

quantos.infinite(dados)
##remuneracao<- as.numeric(as.character(remuneracao))

#summary(dados)

# coloca maiuscula
orgao<- toupper(dados$orgao)
raca<- toupper(dados$raca)
sexo<-toupper(dados$sexo)
uf<- toupper(dados$uf)

#remove espaço no inicio e no final caso ocorra

orgao<- str_trim(orgao)
raca<- str_trim(raca)
sexo<- str_trim(sexo)
uf<- str_trim(uf)
idade<- str_trim(dados$idade)
escolaridade<- str_trim(dados$escolaridade)
salario<- str_trim(dados$remuneracao)
ano<- str_trim(dados$ano)



# remove acentos travessao  caso ocorra

orgao <-gsub("[~|^|~|\"|'|`|-]","",orgao)
raca <-gsub("[~|^|~|\"|'|`|-]","",raca)
sexo<-gsub("[~|^|~|\"|'|`|-]","",sexo)
uf <-gsub("[~|^|~|\"|'|`|-]","",uf)
idade <-gsub("[~|^|~|\"|'|`|-]","",idade)
escolaridade<-gsub("[~|^|~|\"|'|`|-]","",escolaridade)
salario <-gsub("[~|^|~|\"|'|`|-]","",salario)
ano <-gsub("[~|^|~|\"|'|`|-]","",ano)


dados<- cbind(orgao, raca, sexo, uf, idade, escolaridade, salario, ano)


write.csv2(dados, file = "simulacao_ipea2")

