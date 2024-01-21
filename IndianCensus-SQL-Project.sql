
Select * from [Indiancensus_project]..Dataset1 
select * from [Indiancensus_project]..Dataset2

-------------------------------------------------------------------------------------------------------

--Number of rows in dataset

select count(*) from [Indiancensus_project]..Dataset1
select count(*) from [Indiancensus_project]..Dataset2

--------------------------------------------------------------------------------------------------------

--Create view of full dataset

create view Full_dataset as 
select d1.District,d1.State,d1.growth,d1.sex_ratio,d1.literacy,d2.area_km2,d2.population from [Indiancensus_project]..Dataset1 d1
inner join [Indiancensus_project]..Dataset2 d2 
on d1.District=d2.District and d1.State=d2.State 

Select * from Full_dataset
select * from [Indiancensus_project]..full_dataset

------------------------------------------------------------------------------------------------------------

--selecting Literacy Rate greater than 80

select District,Literacy from [Indiancensus_project]..Dataset1 where Literacy>80

--------------------------------------------------------------------------------------------------------

-- Dataset for Jharkhand And Bihar

select * from [Indiancensus_project]..Dataset1 where District in ('Jharkhand','Bihar')


--------------------------------------------------------------------------------------------------------

-- Population of india

Select sum(population) Total_population from [Indiancensus_project]..Dataset2

--------------------------------------------------------------------------------------------------------
-- Average growth of india

select round(100*AVG(growth),3) Average_growth from [Indiancensus_project]..Dataset1

--------------------------------------------------------------------------------------------------------

-- Avg sex ratio statewise

Select state,Round(AVG(sex_ratio),3) Average_Sex_Ratio from [Indiancensus_project]..Dataset1 
group by State

--------------------------------------------------------------------------------------------------------

--- Avg literacy rate statewise

Select state,Round(AVG(literacy),3) Average_Literacy_Rate from [Indiancensus_project]..Dataset1 
group by State

--------------------------------------------------------------------------------------------------------

-- Top 3 state with highest growth

select top 3 state,Round(100*AVG(growth),3) Average_growth from [Indiancensus_project]..Dataset1
group by State 
order by Average_growth desc

--------------------------------------------------------------------------------------------------------

--- Total males and females

Select c.District , c.Males,c.Females from
 (select a.district, a.state, round((b.population)/(1+ (a.sex_ratio/1000)),0) males,
 round((b.population*(a.sex_ratio/1000))/(1+(a.Sex_Ratio/1000)),0) females,
  b.population population from [Indiancensus_project]..Dataset1 a 
  inner join [Indiancensus_project]..Dataset2 b on a.District= b.District )c 

  --------------------------------------------------------------------------------------------------------
  
--Total literacy rate and area of state

select d1.State,avg(d1.literacy) Literacy_Rate,sum(d2.Area_km2) Area from [Indiancensus_project]..Dataset1 d1
join [Indiancensus_project]..Dataset2 d2 on d1.District=d2.district and d1.State=d2.State
group by d1.State

 --------------------------------------------------------------------------------------------------------

--- Previous year population

Select State,District,population,round(Population/(1+Growth),0) Previous_year_population from Full_dataset


 --------------------------------------------------------------------------------------------------------

-- window
-- top 3 states having heighest litracy rate 

select a.* from
(select district,state,literacy,rank() over(partition by state order by literacy desc) rank from [Indiancensus_project]..Dataset1) a
where a.rank in (1,2,3) order by state


