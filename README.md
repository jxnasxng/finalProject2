# finalProject2
Updated Final Project Repository

# EarMatch

EarMatch is an app where you can search for albums, log them in your own personal library, and review them. 

# API

I used the Spotify API for this app. The endpoints I used are: 
- **POST https://accounts.spotify.com/api/token** to fetch an access token using my client ID and secret.
- **GET https://api.spotify.com/v1/search** to search for albums by query

# Features

- **Search**: The app's main feature is the search bar, in which the user can search either an album or artist. Up to 10 results show up.
- **Review**: When a user searches for an album & clicks on it, they can log and review the album. In the review, the user can rate it from 1 to 5 stars and write a short review. Users can view their logged albums in the "My Library" tab.
- **Favorites**: On the profile view, the user can see their profile picture, username, and 5-star albums.

# Obstacles

I struggled with trying to find out how to properly use the Spotify API. Since I was focusing on making sure that my app was actually functional, I neglected the visual aspect of the app. In the future, I would want to focus more on creating a visually pleasing app.
