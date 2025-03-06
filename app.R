# Load required libraries
library(shiny)
library(tm)
library(wordcloud)
library(e1071)
library(ggplot2)
library(dplyr)
library(RColorBrewer)

# Load dataset
imdb_data <- read.csv("imdb dataset.csv", stringsAsFactors = FALSE)

# Preprocess text function
preprocess_text <- function(text) {
  text <- tolower(text)  # Convert to lowercase
  text <- removePunctuation(text)  # Remove punctuation
  text <- removeNumbers(text)  # Remove numbers
  text <- removeWords(text, stopwords("en"))  # Remove stopwords
  text <- stripWhitespace(text)  # Remove extra spaces
  return(text)
}

# Preprocess reviews
imdb_data$review <- sapply(imdb_data$review, preprocess_text)

# Reduce the dataset size for training (take a random sample of 5,000 reviews to avoid memory issues)
set.seed(42)  # For reproducibility
sample_data <- imdb_data[sample(nrow(imdb_data), 5000), ]

# Create a Document-Term Matrix (DTM) on a smaller dataset with max 500 features (most frequent words)
corpus <- Corpus(VectorSource(sample_data$review))
dtm <- DocumentTermMatrix(corpus, control = list(maxFeatures = 500))

# Convert DTM to a sparse matrix and prepare training data
dtm_matrix <- as.matrix(dtm)
labels <- factor(sample_data$sentiment)

# Train a Naive Bayes sentiment classifier
classifier <- naiveBayes(dtm_matrix, labels)

# Define UI
ui <- fluidPage(
  titlePanel("Movie Review Sentiment Analyzer 🎥"),
  sidebarLayout(
    sidebarPanel(
      textAreaInput("user_input", "Enter a Movie Review:", "", rows = 5),
      actionButton("analyze", "Analyze Sentiment"),
      br(),
      selectInput("sample_review", "Or Select a Sample Review:", choices = imdb_data$review)
    ),
    mainPanel(
      h3("Predicted Sentiment:"),
      textOutput("sentiment_result"),
      hr(),
      h3("Word Cloud of Movie Reviews"),
      plotOutput("wordcloud_plot")
    )
  )
)

# Define Server
server <- function(input, output, session) {
  observeEvent(input$analyze, {
    review_text <- ifelse(input$user_input != "", input$user_input, input$sample_review)
    processed_review <- preprocess_text(review_text)
    dtm_test <- DocumentTermMatrix(Corpus(VectorSource(processed_review)), control = list(dictionary = Terms(dtm)))
    dtm_test <- as.matrix(dtm_test)
    
    # Add missing columns if necessary
    if (ncol(dtm_test) != ncol(dtm_matrix)) {
      missing_cols <- setdiff(colnames(dtm_matrix), colnames(dtm_test))
      for (col in missing_cols) {
        dtm_test <- cbind(dtm_test, 0)
      }
      dtm_test <- dtm_test[, colnames(dtm_matrix), drop = FALSE]
    }
    
    # Predict sentiment
    predicted_sentiment <- predict(classifier, dtm_test)
    output$sentiment_result <- renderText({ predicted_sentiment })
  })
  
  # Render Word Cloud
  output$wordcloud_plot <- renderPlot({
    wordcloud(sample_data$review, max.words = 100, colors = brewer.pal(8, "Dark2"))
  })
}

# Run the app
shinyApp(ui, server)
