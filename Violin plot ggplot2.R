# Load required library
library(ggplot2)

# Create example data
set.seed(123)  # For reproducibility
data <- data.frame(
  category = rep(c("A", "B", "C"), each = 100),
  value = c(rnorm(100, mean = 5, sd = 1),
            rnorm(100, mean = 7, sd = 1.5),
            rnorm(100, mean = 6, sd = 1.2))
)

# Generate publication-quality violin plot
p <- ggplot(data, aes(x = category, y = value, fill = category)) +
  geom_violin(trim = FALSE, alpha = 0.7, color = "black") +  # Violin with black borders
  geom_boxplot(width = 0.1, fill = "white", outlier.shape = NA) +  # Boxplot inside violin
  labs(title = "Sample Violin Plot", x = "Category", y = "Value") +
  theme_minimal(base_size = 14) +  # Set base font size for publication
  scale_fill_brewer(palette = "Set2") +  # Adjust colors
  theme(
    axis.line = element_line(color = "black", size = 0.8),  # Add axis lines
    panel.grid = element_blank(),  # Remove grid lines
    panel.border = element_blank(),  # Remove panel border
    legend.position = "none"  # Remove legend for a cleaner look
  )

# Save plot with high resolution
ggsave("violin_plot.png", p, width = 6, height = 4, dpi = 300)

# Print plot
print(p)
