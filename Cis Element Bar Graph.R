library(ggplot2)
library(dplyr)
library(readr)

# Read Input File
input_file <- "R Scripts/gene_data.csv"  # Replace with your file path
genes_data <- read_csv(input_file)

# Preview data
print(head(genes_data))

# Define more contrastive colors for all 7 domains
gene_colors <- c(
  "SAR" = "#1F4E79",   # Dark Blue
  "LRE" = "#2C6B3D",   # Dark Green
  "GRE" = "#66ff00",   # Bright green
  "MYB" = "#FFEA00",   # Bright Yellow
  "ABRE" = "#D5008F",  # Bright Magenta
  "MEJA" = "#00BCD4",  # Bright Cyan
  "AuxRE" = "#673AB7"   # Dark Purple
)

# Count the number of elements per GeneID and Domain
domain_count <- genes_data %>%
  group_by(GeneID, Domain) %>%
  summarise(Number_of_elements = n(), .groups = "drop") 

# Arrange GeneID by the sum of Number_of_elements (descending order)
domain_count <- domain_count %>%
  group_by(GeneID) %>%
  mutate(Total_elements = sum(Number_of_elements)) %>%
  ungroup() %>%
  arrange(desc(Total_elements))

# Ensure GeneID is a factor with levels based on Total_elements order
domain_count$GeneID <- factor(domain_count$GeneID, levels = unique(domain_count$GeneID))

# Plot using bar graph with "Number of elements" on the y-axis
ggplot(domain_count, aes(x = GeneID, y = Number_of_elements, fill = Domain)) +
  geom_bar(stat = "identity", position = "stack", show.legend = TRUE) +  # Create stacked bar
  scale_fill_manual(values = gene_colors, name = "Domain") +  # Apply new color scale for domains
  labs(
    title = " ",
    x = "Gene ID",
    y = "Number of Elements"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis text for readability
    axis.title = element_text(size = 14),  # Larger axis title for better readability
    legend.position = "right",
    legend.title = element_text(size = 12),  # Larger legend title for clarity
    legend.text = element_text(size = 10),  # Larger legend text for readability
    axis.line = element_line(color = "black", size = 0.5),  # Add axis lines back
    axis.ticks = element_line(color = "black", size = 0.5),  # Add axis ticks back
    panel.grid = element_blank()  # Remove grid lines
  )

