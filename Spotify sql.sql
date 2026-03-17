CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
select * from spotify
----Count Rows
select count(*) 
from spotify

===unique count album, artist,track, album type,channel
  Select count(distinct artist ),
         count(distinct album),
         count(distinct track),
         count(distinct album_type),
		 count(distinct channel)
from spotify
====maximum  and minimum duration
select max(duration_min),
       min(duration_min)
from spotify
===cleaning data
Select *from spotify
where duration_min=0

Delete from spotify
where duration_min=0

-----Retrieve the names of all tracks that have more than 1 billion streams
    Select artist from spotify
	where stream >1000000000
	
-----List all albums along with their respective artists.
	Select album,artist
	from spotify
	
------Get the total number of comments for tracks where licensed = TRUE
      Select comments,licensed
	  from spotify
	  where licensed=true
	  
	  Select sum (comments)
	  from spotify
	  where licensed=true
------Find all tracks that belong to the album type single	  
 Select track,album_type
	  from spotify
	  where album_type='single'
-------Count the total number of tracks by each artist.	

Select artist,count(track)
	  from spotify
	  group by artist
-----Find the top 5 tracks with the highest energy values.
	Select *
	  from spotify;
	Select track,max(energy)
	  from spotify
	  group by 1
	  order by 2 desc
	  limit 5
	  
----List all tracks along with their views and likes where official_video = TRUE.
Select track,sum(views) as total_views,sum(likes) as total_likes
	  from spotify
	  where official_video=true
	  group by 1 
	  order by 2 desc 
	  limit 5
	  
-----For each album, calculate the total views of all associated tracks.  
Select album,track, sum(views) as total_views
	  from spotify
	  group by 1,2 
	  order by 3 desc 
	  limit 5
-----Retrieve the track names that have been streamed on Spotify more than YouTube.
select * from 
(Select track,
    coalesce (sum(case when most_played_on='YouTube'then stream End ),0)as streamed_on_YouTube,
    coalesce (sum(case when most_played_on='spotify'then stream End ),9)as streamed_on_spotify
   from spotify
   group by 1)as t1
   where streamed_on_spotify >streamed_on_YouTube
   and
   streamed_on_YouTube <>0
   
   
   

	  
