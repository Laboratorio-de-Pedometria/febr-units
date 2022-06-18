# title: 2022 Curadoria de Metadados de Métodos de Análise de Solo
# people: Vitor, Debora e Luciana
# date: 2022-06-17
# description: Preparação de tabela com unidades de medida como encontradas originalmente em
#   trabalhos de levantamento de solos. A equipe deve indicar o formato correto de expressão das
#   respectivas unidades. Também deve criar uma nota instrutiva para que uma pessoa consiga mapear
#   uma unidade de medida para o formato usado no repositório. Uma vez definidos os mapeamentos,
#   os formatos corretos serão usados para validar o trabalho realizado pela equipe na planilha
#   '2022 Curadoria de Metadados de Métodos de Análise de Solo'.

# Get list of sheet names from 'indice'
# 2022 Curadoria de Metadados de Métodos de Análise de Solo
key <- "1M4K_jJj85gsgEeg1CzPpkWn45vYMnlRRUGzGZD26q58"
sheet_name <- "indice"
cmd <- paste0("https://docs.google.com/spreadsheets/d/", key, "/gviz/tq?tqx=out:csv&sheet=",
  sheet_name)
indice <- utils::read.table(cmd, header = TRUE, sep = ",", dec = ",")
indice[1, ]

# Read measurement units from original sheets
# 2021 Compilação de Metadados de Métodos de Análise de Solo
key <- "1WwNeVkVRlccLMcFkmZUPQn2wREOmvnCc4PnNlybmiRg"
sheet_name <- indice[["dados_id_febr"]]
cmd <- paste0("https://docs.google.com/spreadsheets/d/", key, "/gviz/tq?tqx=out:csv&sheet=",
  sheet_name)
original <- list()
for (file in cmd) {
  original[[file]] <-
    utils::read.table(
      file = file, header = TRUE, sep = ",", dec = ",", skip = 1)[["Unidade.de.medida"]]
}

# Identify unique measurement units
original <- unlist(original)
names(original) <- NULL
write.table(unique(original), file = "febr-units/data/2022-06-17-mapeamento.csv", row.names = FALSE)
