# Load required libraries
library(circlize)
library(RColorBrewer)

# Chromosome lengths
chromosomes <- read.table("R_DATA/Cs/chromosome.txt", sep = "\t", header = TRUE, stringsAsFactors = FALSE)

# Links between regions (connections)
links <- read.table("R_DATA/Cs/links.txt", sep = "\t", header = TRUE, stringsAsFactors = FALSE)

# Gene data
genes <- read.table("R_DATA/Cs/Gene.txt", sep = "\t", header = TRUE, stringsAsFactors = FALSE)

# Get a contrasting color palette for chromosomes
chromosome_colors <- brewer.pal(8, "Pastel1")  # 'Set3' provides distinct colors

# Clear any previous Circos plot
circos.clear()
circos.par("track.height" = 0.1)  # Set track height

# Initialize and plot chromosomes
circos.initialize(sectors = chromosomes$chr, xlim = chromosomes[, 2:3])

# Add genomic labels for Transcript_ID with bold font
circos.genomicLabels(
  genes[, c("Chromosome_ID", "Start", "Stop", "Transcript_ID")],  # Columns required for genomicLabels
  labels.column = 4,  # The column index for Transcript_ID
  side = "outside",  # Place the labels outside the circular plot
  col = "black",  # Label color
  line_col = "black",  # Line color connecting labels to regions (new color)
  font = 2,  # Set the font to bold
  cex = 0.6  # Set label size (new size)
)

# Plot chromosomes with labels
circos.trackPlotRegion(
  sectors = chromosomes$chr, ylim = c(0, 1),
  bg.col = chromosome_colors,  # Apply contrasting colors
  panel.fun = function(x, y) {
    chr <- CELL_META$sector.index
    xlim <- CELL_META$xlim
    circos.text(mean(xlim), 0.5, chr, cex = 0.8, facing = "inside", niceFacing = TRUE)
  }
)

# Add links between regions with customized color and size
for (i in 1:nrow(links)) {
  circos.link(
    sector.index1 = links$source_chr[i], 
    point1 = c(links$source_start[i], links$source_end[i]),
    sector.index2 = links$target_chr[i], 
    point2 = c(links$target_start[i], links$target_end[i]),
    col = "tomato",  # Link line color (new color)
    lwd = 2  # Link line width (new size)
  )
}

# Finalize the plot
circos.clear()

