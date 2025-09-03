# Define input and output folders
input_dir <- "Raw_Data"
output_dir <- "Results"

# create output folder if not already exist

if(!dir.exists(output_dir)){
  dir.create(output_dir)
}

# List which files to process
files_to_process <- c("DEGs_Data_1.csv", "DEGs_Data_2.csv")
View(files_to_process)

# Prepare empty list to store results in R 
result_list <- list()


#Define the function to classify genes
classify_gene <- function(logFC, padj) {
  ifelse(logFC > 1 & padj < 0.05, "Upregulated",
         ifelse(logFC < -1 & padj < 0.05, "Downregulated",
                "Not_Significant"))
}

# Function to process datasets
for (data_files in files_to_process) {
  cat("\nProcessing:", data_files, "\n")
  
  input_file_path <- file.path(input_dir, data_files)
  
  # Import dataset
  data <- read.csv(input_file_path, header = TRUE)
  cat("File imported. Checking for missing values...\n")
  
  # handling missing values
  
  if("padj" %in% names(data)){
    missing_count <- sum(is.na(data$padj))
    
    cat("Missing values in 'padj':", missing_count, "\n")
    data$padj[is.na(data$padj)] <- 1
  }

  #Add a new column
  data$status <- classify_gene(data$logFC, data$padj)
  cat("column STATUS was created successfully.....\n")

  #save results in Results folder
  output_file_path <- file.path(output_dir, paste0("STATUS_results", data_files))
  write.csv(data, output_file_path, row.names = FALSE)
  cat("Results saved to:", output_file_path, "\n")

  # Count summaries
  summary_counts <- table(data$status)
  results[[data_files]] <- summary_counts
}
  
  return(results)
}

# Define the input files
input_files <- c("DEGs_Data_1.csv", "DEGs_Data_2.csv")

# Ensure the Results folder exists
if (!dir.exists("Results")) {
  dir.create("Results")
}


# Process the datasets and print summary counts
summary_counts <- process_datasets(input_files)

# Print summary results
for (data_files in names(summary_counts)) {
  cat(sprintf("Summary for %s:\n", data_files))
  print(summary_counts[[data_files]])
  cat("\n")
}



