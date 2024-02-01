## ----setup, include = FALSE---------------------------------------------------
library(rgraph6)
requireNamespace("igraph")
requireNamespace("knitr")

knitr::opts_chunk$set(
  collapse = TRUE
  # comment = "#>"
)

## ----fig.width=5, fig.height=5------------------------------------------------
set.seed(123)
g_directed <- igraph::sample_gnm(12, 12, directed=TRUE)
g_undirected <- igraph::as.undirected(g_directed)
igraph::igraph_options(vertex.color="white", vertex.label.color="black",
                       edge.color="black", edge.arrow.size=0.5)
plot(g_directed)
plot(g_undirected)

## -----------------------------------------------------------------------------
as_digraph6(g_directed)

## -----------------------------------------------------------------------------
as_graph6(g_undirected)

## -----------------------------------------------------------------------------
as_sparse6(g_undirected)

## -----------------------------------------------------------------------------
set.seed(666)
igraph_list <- replicate(5, igraph::sample_gnp(10, 0.1, directed=FALSE), 
                         simplify = FALSE)

## -----------------------------------------------------------------------------
as_graph6(igraph_list)

## -----------------------------------------------------------------------------
as_sparse6(igraph_list)

## ----example-mixed------------------------------------------------------------
# Create a vector with a mixture of 'graph6', 'digraph6' and 'sparse6' symbols
x <- c(g6[1], s6[2], d6[3])
x

# Parse to igraph objects (package igraph required)
igraph_from_text(x)

# Parse to network objects (package network required)
network_from_text(x)

## -----------------------------------------------------------------------------
# Generate list of igraph objects
set.seed(666)

d <- data.frame(
  g6 = as_graph6(replicate(
    10,
    igraph::sample_gnp(sample(3:12, 1), p=.5, directed=FALSE),
    simplify=FALSE
  ))
)
d

## -----------------------------------------------------------------------------
d2 <- within(
  d, {
    igraphs <- igraph_from_text(g6)
    vc <- vapply(igraphs, igraph::vcount, numeric(1))
    ec <- vapply(igraphs, igraph::ecount, numeric(1))
    density <- vapply(igraphs, igraph::edge_density, numeric(1))
})
d2$igraphs <- NULL
str(d2, 1)

## -----------------------------------------------------------------------------
write.csv(d2, row.names = FALSE)

