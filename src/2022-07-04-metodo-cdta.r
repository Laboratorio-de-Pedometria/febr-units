# title: 2022 Curadoria de Metadados de Métodos de Análise de Solo
# people: Graziele
# description: Alguns métodos analíticos foram erroneamente modificados. A modificação consistiu
#   em substituir CDTA por EDTA. Este código identifica os trabalhos originais que faziam menção
#   ao uso de CDTA. A correção das modificações é realizada manualmente.

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
  col_name <- "Descricao.do.metodo.analitico"
  original[[i]] <-
    utils::read.table(file = cmd[i], header = TRUE, sep = ",", dec = ",", skip = 1)[, col_name]
  original[[i]] <- any(grepl("CDTA", original[[i]]))
  # idx_duplicated <- which(!duplicated(original[[i]][["Unidade.de.medida"]]))
  # original[[i]] <- original[[i]][idx_duplicated, ]
  # if (nrow(original[[i]]) > 0) {
  #   original[[i]][["dados_id_febr"]] <- sheet_name[i]
  # }
}
original <- unlist(original)
sheet_name[original]