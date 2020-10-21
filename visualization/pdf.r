# Plots probability density fucntion (PDFs) 

setwd("/Users/danielpazmino")
library("ggplot2")

df <- read.csv("VIC_djf_ffdi_bc.csv", header = TRUE)

PDF = ggplot(df, aes(x=TMAX, colour=DATA)) + geom_density(size=3) + 
scale_color_brewer(palette = "Set1") +  
  xlab("TMAX (degC)") +
  ylab("Density") +
  ggtitle("")

PDF + theme_classic(base_size = 28, base_family = "Helvetica")

ggsave(filename = "VIC_TMAX_bc.eps", dpi = 600)

# To plot with color
#PDF = ggplot(df, aes(x=FFDI, colour=DATA)) + geom_density() + 
#scale_color_brewer(palette = "Set1") + 

# To plot in grey
# PDF = ggplot(df, aes(x=FFDI, colour=DATA)) + geom_density(size=3) + 
#scale_color_grey() + 

