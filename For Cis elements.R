library(ggplot2)
library(readr)

# Read Input File
input_file <- "R Scripts/gene_data.csv"  # Replace with your file path
genes_data <- read_csv(input_file)

# Preview data
print(head(genes_data))

# Add Midpoint for text labels
genes_data$Midpoint <- (genes_data$Start + genes_data$End) / 2

# Define more contrastive colors for all 7 domains
gene_colors <- c(
  "SAR" = "#1F4E79",   # Dark Blue
  "LRE" = "#2C6B3D",   # Dark Green
  "GRE" = "#66ff00",   # Brigth Green
  "MYB" = "#FFEA00",   # Bright Yellow
  "ABRE" = "#D5008F",  # Bright Magenta
  "MEJA" = "#00BCD4",  # Bright Cyan
  "AuxRE" = "#673AB7"   # Dark Purple
)

# Define max length for scaling x-axis (replace with appropriate value or compute from data)
max_length <- max(genes_data$End)

# Plot all genes together, using color for each domain with higher contrast colors
ggplot(genes_data, aes(x = Midpoint, y = GeneID)) +
  geom_segment(aes(x = Start, xend = End, y = GeneID, yend = GeneID, color = Domain), 
               size = 2, lineend = "butt") +  # Reduced segment size for better visibility
  geom_point(aes(color = Domain), size = 4, position = position_jitter(width = 0.3, height = 0)) +  # Add color to points
  geom_hline(yintercept = unique(genes_data$GeneID), linetype = "solid", color = "black", size = 0.5) +  # Add line for each GeneID
  scale_x_continuous(breaks = seq(0, max_length, by = 200), 
                     limits = c(0, max_length + 1)) +
  scale_color_manual(values = gene_colors, name = "Domain") +  # Apply new color scale for domains
  labs(
    title = "Cis-Element Mapping for All Genes",
    x = "Position (bp)",
    y = "Gene ID"
  ) +
  theme_minimal() +
  theme(
    axis.text.y = element_text(size = 12),  # Larger text for readability
    axis.ticks.y = element_blank(),
    axis.title = element_text(size = 14),  # Larger axis title for better readability
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),  # Removed major grid lines for clean look
    legend.position = "right",
    legend.title = element_text(size = 12),  # Larger legend title for clarity
    legend.text = element_text(size = 10)  # Larger legend text for readability
  )

