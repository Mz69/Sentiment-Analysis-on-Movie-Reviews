Sentiment Analysis on Movie Reviews

Project Overview

This project implements sentiment analysis on a collection of movie reviews, classifying them as positive or negative. Using machine learning and natural language processing (NLP) techniques, the project processes a dataset of 50,000 movie reviews and builds a sentiment classification model. The application allows users to input their own reviews and receive predictions of whether the review is positive or negative.

The model is trained using the Naive Bayes classifier, and the text data is preprocessed to improve accuracy and efficiency. A word cloud is also generated from the reviews to visualize common words in the dataset.

Technologies Used

R: The primary programming language used for building the sentiment analysis model and the Shiny application.
Shiny: A web application framework for R, used for creating interactive applications.
tm: A text mining package used for text preprocessing, including removing punctuation, numbers, stopwords, and extra whitespace.
wordcloud: A package used for generating word clouds to visualize the most frequent words in the dataset.
e1071: A package that provides the Naive Bayes classifier, used for sentiment classification.
ggplot2: A package for creating visualizations (optional, depending on the implementation).
Features

Sentiment Prediction: Users can enter their own movie reviews, and the model will predict whether the sentiment is positive or negative.
Sample Review Selection: Users can select a sample review from the dataset to analyze its sentiment.
Word Cloud Visualization: A word cloud is generated based on the most common words in the movie reviews, providing a visual summary of the dataset.
Setup and Installation

Clone the repository:
git clone https://github.com/Mz69/sentiment-analysis-movie-reviews.git
Install Required Packages: Make sure you have R installed on your system. Then, you can install the required packages by running the following commands in R:
install.packages(c("shiny", "tm", "wordcloud", "e1071", "ggplot2", "dplyr"))
Load the Dataset: Download the IMDb movie reviews dataset (CSV format) and place it in the project directory. The dataset can be obtained from sources like Kaggle.
Run the Application: After installing the necessary packages and placing the dataset in the correct folder, you can run the Shiny app by executing:
shiny::runApp("app_directory")
Usage

Input Review: You can input a movie review directly into the text box and click "Analyze Sentiment" to get a prediction of whether the sentiment is positive or negative.
Sample Review: Alternatively, you can select a sample review from the dataset, and the app will predict the sentiment for that review.
Word Cloud: A word cloud is displayed to visualize the most frequent words across all reviews, highlighting the key themes in the dataset.
Example

Input Review: "I love this movie! It's the best film I've seen all year."

Predicted Sentiment: Positive

Contributions

Feel free to fork this repository and submit pull requests with improvements, bug fixes, or additional features.

License

This project is open-source and available under the MIT License. See the LICENSE file for more details.

Acknowledgments

Dataset: IMDb Movie Reviews (50,000 reviews)
Libraries: shiny, tm, wordcloud, e1071, ggplot2






