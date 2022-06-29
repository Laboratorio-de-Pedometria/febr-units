# title: 2022 Curadoria de Metadados de Métodos de Análise de Solo
# people: Vitor, Debora e Luciana
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
for (i in seq_along(cmd)) {
  original[[i]] <-
    utils::read.table(file = cmd[i], header = TRUE, sep = ",", dec = ",", skip = 1)[, c(1, 3)]
  idx_duplicated <- which(!duplicated(original[[i]][["Unidade.de.medida"]]))
  original[[i]] <- original[[i]][idx_duplicated, ]
  if (nrow(original[[i]]) > 0) {
    original[[i]][["dados_id_febr"]] <- sheet_name[i]
  }
}

# Identify unique measurement units
original <- do.call(rbind, original)
idx_duplicated <- which(!duplicated(original[["Unidade.de.medida"]]))
original <- original[idx_duplicated, ]
write.table(original,
  file = "febr-units/data/2022-06-22-mapeamento.csv", row.names = FALSE, sep = "\t")
