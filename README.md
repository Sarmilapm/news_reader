Flutter News Reader App 
Project Overview: 
  The project is to develop a Flutter News Reader App that fetches and 
displays news articles from an API in an aesthetically pleasing and user-friendly manner. 
This app ensure smooth navigation, state management, and optional offline functionality.
Features:
1. API Integration: Used https://newsapi.org to fetch articles.
2. State Management: Used Getx for efficient state handling.
3. Responsive UI: Implemented a modern, adaptive UI.
4. Navigation: Smooth transition from article list to detail view.
5. Error Handling: Displayed appropriate error messages for API failures.
6. Local Storage : Cached news articles for offline access.
Requirements:
1. Fetching Data from API
    Used API to fetch news articles.
    Display essential information:
   o Title
   o Description
   o Thumbnail Image
   o Published Date
2. Home Screen UI Design
    Implemented a clean, responsive layout with the following elements:
   o Navigation Tabs: Explore, Entertainment, Lifestyle, Travel etc.
   o Top Story Section: Featured news with an image, title, and date
   o Popular News List: Thumbnail, title, description, date, and engagement stats
   o Bottom Navigation Bar: Home, Videos, Podcasts, Categories, Profile
3. Detailed News View
    Navigate to a new screen on article tap.
    Display:
   o Full Title
   o Full Content/Description
   o Full-size Image
   o Published Date
   o Back Button for navigation
   o Engagement Section: Views, Likes, Comments
4. State Management
    Implement a state management solution to:
   o Show a loading indicator while fetching data
   o Display articles on success
   o Handle errors gracefully
5. Error Handling
    If fetching fails (e.g., no internet), display:
   "Failed to load news. Please try again."
    Include a Retry Button.
6. Local Storage (Bonus Feature)
    Cache news articles for offline access.
    Display saved articles when there is no internet.
  