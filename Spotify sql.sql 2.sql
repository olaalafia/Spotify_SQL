select* from spotify  
---Find the top 3 most-viewed tracks for each artist using window functions.
with ranking_artist
as
(select artist,track, sum(views) as total_view,
Dense_rank()over (partition by artist order by sum(views) desc)as rank
from spotify 
group by 1,2
order by 1,3 desc)
select* from ranking_artist
where rank<=3

----Write a query to find tracks where the liveness score is above the average.
   select track
   from spotify
   where liveness>(select avg(liveness) from spotify)
 ----Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
   with diff as
   (select album,
   max (energy) as max_energy,
   min (energy) as min_energy 
  from spotify             
  group by 1)
  select album,
   max_energy-min_energy
  from diff
  order by 2 desc
  
 ---Find tracks where the energy-to-liveness ratio is greater than 1.2.
with cte as
  (select track,
   sum(energy) as total_energy,
   sum(liveness) as liveness_energy 
  from spotify
  group by 1)
  select track ,
  total_energy/liveness_energy as Energy_livesness
  from cte
  where total_energy/liveness_energy >0.5
  order by 2



 
 