# Tides-Medical-Problem-

For this project, I used R to implement the code. This code can have multiple substrings and pdfs inputted. To use this algorithm, the working directory in R needs to be set to the place where the downloaded UniProt pdfs are located and the substring parameters need to be inputted with quotation marks. To input the pdfs into the algorithm_multi_pdf function, a vector of pdf files (this needs to be a character vector and each file needs to be in quotation marks) needs to inputted. (ie pdf_vector <- c(“file1.pdf”, “file2.pdf”).

To search for the substrings in all the pdfs inputted, I used a for loop that goes through each pdf file and then stores the results in a list. Specifically to find the substrings, I used the grep() function to search for substrings and used the lapply() function to apply the grep() function to all the substrings.The list with results for each pdf is then used later to print the highlighted substrings and the total number of matches found. 

I tried to make this algorithm efficient by only including code that I thought was necessary to run this program. This algorithm currently only works for pdfs downloaded from UniProt and the pdf name inputted must be a valid name. I tried implementing the algorithm with pdfs from PubMed but there were formatting issues that the algorithm currently can’t handle. 
