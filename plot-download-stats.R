library("ggplot2")
library("readr")
library("reshape2")
library("RColorBrewer")
files <- list.files("download-stats", full.names=TRUE)
x <- lapply(files, function(f) {
    ls <- read_lines(f)
    cs <- strsplit(ls, ": ")
    out <- lapply(cs, function(l) as.numeric(l[[2]]))
    names(out) <- sapply(cs, function(x) x[[1]])
    df <- as.data.frame(out, check.names=FALSE)
    df$Date <- as.Date(gsub("download-stats/(.*).txt", "\\1", f))
    df
})


df <- do.call(rbind, x)
df <- df[, c("Total QuPath downloads")] # filter to just the columns you're interested in...

mdf <- melt(df, id.vars="Date")

ggplot(mdf) +
    aes(x = Date, y = value, color=variable) +
    geom_line() +
    geom_point() +
    theme_bw() +
    scale_color_brewer(palette = "Set2", name=NULL) +
    guides(color=guide_legend(nrow = 2, byrow = TRUE)) +
    scale_y_continuous(labels = scales::comma, name = "Number of downloads") +
    theme(legend.position = "bottom")
