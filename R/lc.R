#' List comprehension
#'
#' This function implements list comprehension, an alternative to Filter and Map for working
#' with lists. The syntax is as follows: lc(expr, lists, predicates) where \code{expr} is some expression to be evaluated for all elements in the \code{lists},
#' where \code{lists} are one or more named lists, where these are specified by a name
#' and an expression \code{name = list_expr}, and where \code{predicates} are expressions
#' that should evaluated to a boolean value. For example, to get a list of all even numbers, squared,
#' from a list \code{x} we can write lc(x ** 2, x = x, x \%\% 2 == 0). The result of a call to \code{lc} is a list constructed from the expressions in \code{expr},
#' for all elements in the input lists where the predicates evaluate to true.
#'
#' @param expr An expression that will be evaluated for each element in the input lists.
#' @param ...  Additional list or predicate arguments.
#'
#' @examples
#' qsort <- function(lst) {
#'     n <- length(lst)
#'     if (n < 2) return(lst)
#'     pivot <- lst[[sample(n, size = 1)]]
#'     smaller <- lc(x, x = lst, x < pivot)
#'     equal <- lc(x, x = lst, x == pivot)
#'     larger <- lc(x, x = lst, x > pivot)
#'     c(qsort(smaller), equal, qsort(larger))
#' }
#' (lst <- sample(1:10))
#' unlist(qsort(lst))
#'
#' @importFrom purrr map
#' @importFrom purrr pmap
#' @import rlang
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
