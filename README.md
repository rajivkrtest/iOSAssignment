# iOS Proficiency Exercise  
Create a universal iOS app using Swift
Ingests a json feed from https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json
You can use a third party json parser to parse this if desired.
The feed contains a title and a list of rows
Displays the content (including image, title and description) in a table
The title in the navbar should be updated from the json
Each row should be the right height to display its own content and no taller. No content should be clipped. This means some rows will be larger than others.
Loads the images lazily
Don’t download them all at once, but only as needed
Refresh function
Either place a refresh button or use pull down to refresh.
Should not block UI when loading the data from the json feed.
