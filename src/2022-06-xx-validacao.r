# title: 2022 Curadoria de Metadados de Métodos de Análise de Solo
# people: Vitor, Debora e Luciana
# description: Validação do trabalho realizado pela equipe na planilha '2022 Curadoria de Metadados
#   de Métodos de Análise de Solo'. O formato correto de expressão das unidades de medida, definido
#   na atividade anterior, é comparado aos formatos efetivamente usados pelos membros da equipe na
#   curadoria.

# Get list of sheet names from 'indice'
# 2022 Curadoria de Metadados de Métodos de Análise de Solo
key <- "1M4K_jJj85gsgEeg1CzPpkWn45vYMnlRRUGzGZD26q58"
sheet_name <- "indice"
cmd <- paste0("https://docs.google.com/spreadsheets/d/", key, "/gviz/tq?tqx=out:csv&sheet=",
  sheet_name)
indice <- utils::read.table(cmd, header = TRUE, sep = ",", dec = ",")
indice[1, ]

# Read measurement units
# 2022 Curadoria de Metadados de Métodos de Análise de Solo
key <- "1M4K_jJj85gsgEeg1CzPpkWn45vYMnlRRUGzGZD26q58"
sheet_name <- indice[["dados_id_febr"]]
sheet_path <- paste0("https://docs.google.com/spreadsheets/d/", key, "/gviz/tq?tqx=out:csv&sheet=",
  sheet_name)
original <- list()
for (i in seq_along(sheet_path)) {
  table_head <-
    utils::read.table(
      file = sheet_path[i], header = TRUE, sep = ",", dec = ",", nrows = 4)
  row_colnames <- which(table_head == "campo_id", arr.ind = TRUE)[1, 1]
  if (row_colnames > 0) {
    original[[i]] <-
      utils::read.table(
        file = sheet_path[i], header = TRUE, sep = ",", dec = ",", skip = row_colnames)
  }
}
