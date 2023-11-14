formatar_numero <- function(x, acc = 0.1) {
  scales::number(
    x = x,
    accuracy = acc,
    big.mark = ".",
    decimal.mark = ","
  )
}
