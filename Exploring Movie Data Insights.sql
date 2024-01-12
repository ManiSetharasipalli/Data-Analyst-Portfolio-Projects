-- Query 1: Top-Rated Movies
-- What are the top-rated movies in the dataset based on IMDb ratings?

SELECT
	ROW_NUMBER() OVER(ORDER BY imdb_rating DESC, vote_count DESC) AS Rating_Rank,
	title,
	release_date,
	genres,
	original_language,
	IMDB_Rating,
	vote_count
FROM movies
WHERE IMDB_Rating >= 8.5;

-- Query 2: Movies per Genre
-- How is the distribution of movies across different genres?

SELECT
    genres,
    COUNT(title) AS No_of_movies
FROM movies
GROUP BY genres
ORDER BY No_of_movies DESC;

-- Query 3: Language Distribution
-- What is the distribution of movies based on their original language?

SELECT
    original_language,
    COUNT(movie_id) AS no_of_movies
FROM movies
GROUP BY original_language
ORDER BY no_of_movies DESC;

-- Query 4: Monthly Movie Distribution
-- How is the distribution of movies across different release months?

SELECT
    MONTH(release_date) AS Month,
    COUNT(title) AS No_of_movies
FROM movies
GROUP BY MONTH(release_date)
ORDER BY No_of_movies DESC;

-- Query 5: Genres with Longest Runtime
-- Which genre tends to have the longest average runtime?

SELECT
        genres,
        ROUND(AVG(runtime)) AS Average_runtime
FROM movies
GROUP BY genres
ORDER BY average_runtime DESC;

-- Query 6: Top 10 Highest Collection Movies
-- What are the top 10 movies with the highest collections?

SELECT
    title,
    ROUND(collections / 1000000000,2) AS collections_in_billions
FROM movies
ORDER BY collections_in_billions DESC
LIMIT 10;

-- Query 7: Top 10 Most Profitable Movies and How Often Do Profits Exceed Budgets

WITH Most_Profitable_Movies AS (
    SELECT
        title,
        genres,
        ROUND((collections - budget) / 1000000000,2) AS profit_in_billions,
        budget / 1000000 AS budget_in_millions
    FROM movies
    ORDER BY profit_in_billions DESC
    LIMIT 10
    
)
SELECT
    *,
    ROUND(profit_in_billions * 1000 / budget_in_millions) AS No_of_times
FROM Most_Profitable_Movies
ORDER BY profit_in_billions DESC;