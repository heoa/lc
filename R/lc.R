#' @import rlang
#' @import purrr
#' @export
lc <- function(expr, ...) {
  expr <- enquo(expr)
  rest <- quos(...)

  lists <- map(rest[names(rest) != ""], eval_tidy)
  predicates <- map(rest[names(rest) == ""], UQE)

  keep_index <- rep(TRUE, length(lists[[1]]))
  for (pred in predicates) {
    p <- new_function(lists, body = pred, env = get_env(expr))
    keep_index <- keep_index & unlist(pmap(lists, p))
  }
  filtered_lists <- map(lists, ~.x[keep_index])

  f <- new_function(lists, body = UQE(expr), env = get_env(expr))
  pmap(filtered_lists, f)
}
