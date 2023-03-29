#Substring Search Algorithm for 
#install.packages("pdftools")
#install.packages("tesseract")
#install.packages("stringi")
#install.packages("stringr")
#install.packages("glue")

#libraries that are needed to run this progra, 
library(tesseract)
library(pdftools)
library(tidyverse)
library(stringi)
library(stringr)
library(glue)
library(readr)


#The function finds the number of occurrences of a substring and in various 
#documents and visualizes the results. It is called algorithm_multi_pdf. 
#Parameters:
  ## pdf_files: vector of pdf files (this needs to be a character vector and 
  ## each file needs to be in quotation marks)
  ## first word : substring to search for 
  ## after the first substring is included, then other substrings can be added 
  ## as well 
  ### Additional Notes: The substring parameters need to be in quotation marks 
  ### to be inputted correctly. 


#####
algorithm_multi_pdf <- function(pdf_files, first_word, ...) {
  ## defining the substrings to search
  substring <- c(first_word, ...)
  
  ## initializing empty list to store results for each pdf file
  pdf_results <- list()
  
  ## looping over each pdf file
  for (pdf in pdf_files) {
    ## reading in the pdf 
    text <- pdftools::pdf_text(pdf)
    
    ## finding matches for each substring (both upper and lowercase)
    matches <- lapply(substring, function(x) {
      grep(x, text, ignore.case = TRUE)
    })
    
    ## combining all matches into a single vector and calculating the total 
    ## matches
    total <- unlist(matches)
    iterations <- length(total)
    
    ## storing results for this pdf file in the list
    pdf_results[[pdf]] <- list(matches = matches, iterations = iterations, 
                               text = text)
  }
  
  ## stopping the program if no matches were found in any pdf files
  if (all(sapply(pdf_results, function(x) x$iterations == 0))) {
    stop("The substring or combination of substrings cannot be found in any 
         of the PDF files. Please try a different substring or combination 
         of substrings.")
  }
  
  # Define the ANSI escape codes for highlighting
  highlight_start <- "\033[43m"
  highlight_end <- "\033[0m"
  
  ## looping over each pdf file again to print results (the substrings are 
  ## highlighted)
  for (pdf in pdf_files) {
    matches <- pdf_results[[pdf]]$matches
    iterations <- pdf_results[[pdf]]$iterations
    text <- pdf_results[[pdf]]$text
    
    ## printing the number of matches for this pdf file
    cat(paste("Found",iterations, "matche[s] in", pdf, ".\n"))
    
    ## highlighting the matching substrings
    for (i in seq_along(matches)){
      for (j in seq_along(matches[[i]])){
        text[matches[[i]][j]] <- gsub(substring[i], 
                                      paste0(highlight_start, substring[i], 
                                             highlight_end),
                                      text[matches[[i]][j]],
                                      ignore.case = TRUE)
      }
    }
    
    ## printing the highlighted text
    cat(text)
  }
}


