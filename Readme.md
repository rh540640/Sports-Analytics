# **Problem Statement 2**

> Methods and solutions are well explained here. Highly recommended to go through `Readme.md` to understand the methods and solutions of the project.

## Introduction

As a data analysis intern, you have to analyse sports data for a client. You are given two datasets related to IPL (Indian Premier League) cricket matches. One dataset contains ball-by-ball data and the other contains match-wise data. You have to import the datasets into an SQL database and perform the tasks given in this assignment to find important insights from this dataset.

## *_Quick Access_*

**DataSets**

[IPL_matches.csv](https://github.com/rh540640/Sports-Analytics/blob/master/IPL_matches.csv)

[IPL_Ball.csv](https://raw.githubusercontent.com/rh540640/Sports-Analytics/master/IPL_Ball.csv)


**Code**

[sports_data_analytics.sql](https://github.com/rh540640/Sports-Analytics/blob/master/sports_data_analytics.sql)

**Read File**

[Readme.md](https://github.com/rh540640/Sports-Analytics/blob/master/Readme.md)


## About the Data



#### The "IPL_Ball.csv" file is for ball-by-ball data and it has information of all the 19,3468 balls bowled between the years 2008 and 2020. It has 17 columns.
#### The "IPL_matches.csv" file contains match-wise data and has data of 816 IPL matches. This table has 17 columns.
---------------------------------------------------------------------------------------------
## **Project**

### *__Prerquisites before solving the problem statement__*


* Creating a database in MySQL Commandline Client
```sql
CREATE DATABASE ipl;
```
* Using the database
```sql
use ipl;
```

**1. Create a table named `matches` with appropriate data types for columns.**

`id` is used as `PRIMARY KEY` here
```sql
CREATE TABLE matches(
    id INT PRIMARY KEY,
    city VARCHAR(40),
    date DATE,
    player_of_match VARCHAR(40),
    venue VARCHAR(80),
    neutral_venue INT,
    team1 VARCHAR(80),
    team2 VARCHAR(80),
    toss_winner VARCHAR(80),
    toss_decision VARCHAR(20),
    winner VARCHAR(80),
    result VARCHAR(40),
    result_margin INT,
    eliminator VARCHAR(10),
    method VARCHAR(10),
    umpire1 VARCHAR(40),
    umpire2 VARCHAR(40)
);
```
Then describe the table.
```sql
DESCRIBE matches;
```
![Alt text](describe_matches.png)

**2. Create a table named `deliveries` with appropriate data types for columns.**

Here `id` is used as a `FOREIGN KEY`.

```sql
CREATE TABLE deliveries (
    `id` INT,
    `inning` INT,
    `over` INT,
    `ball` INT,
    `batsman` VARCHAR(40),
    `non_striker` VARCHAR(40),
    `bowler` VARCHAR(40),
    `batsman_runs` INT,
    `extra_runs` INT,
    `total_runs` INT,
    `is_wicket` INT,
    `dismissal_kind` VARCHAR(40),
    `player_dismissed` VARCHAR(40),
    `fielder` VARCHAR(40),
    `extras_type` VARCHAR(40),
    `batting_team` VARCHAR(40),
    `bowling_team` VARCHAR(40),
     FOREIGN KEY(id) REFERENCES matches(id)
);
```
Describing the Table.
```sql
DESCRIBE deliveries;
```

![Alt text](describe_deliveries.png)

**3. Import data from CSV file 'IPL_matches.csv' attached in resources to `matches`.**

*Prerequisite*

* Open the csv files and save as in 'CSV MS-DOS' format to avoid encryption (It is probably 'CSV comma delimited' prior). 

* Remove all the commas contained in the observations using excel by, Selecting the column > Home > Editing tab > Find & Select > Replace.

* Change to yyyy-mm-dd format by right cick > Format cells > Number > Time > selecting 'yyyy-mm-dd' format > Ok. And save te file.

* For the sql version above 5.6, there must be a restriction to import file. So, you have to paste the importing file in the file directory. File directories are mostly a hidden file.

* Check the directory.

```sql
show variables like "secure_file_priv";
```

![Alt text](check_directory.png)

* Apply show all hidden files > search the directory in pc > paste the files in the directory.

Importing 'IPL_matches.csv'.

```sql
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\IPL_matches.csv" INTO TABLE matches
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id,city,date,player_of_match,venue,neutral_venue,team1,team2,toss_winner,toss_decision,winner,result,result_margin,eliminator,method,umpire1,umpire2)
;
```

![Alt text](import_ipl.png)

**4. Import data from CSV file ’IPL_Ball.csv’ attached in resources to ‘deliveries’**

```sql
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\IPL_Ball.csv" INTO TABLE deliveries
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
```
![Alt text](import_ball.png)

**5. Select the top 20 rows of the deliveries table.**

```sql
SELECT * FROM deliveries
LIMIT 20;
```
![Alt text](limit20_deliveries.png)

**6. Select the top 20 rows of the matches table.**

```sql
SELECT * FROM matches
LIMIT 20;
```

![Alt text](limit20_matches.png)

**7. Fetch data of all the matches played on 2nd May 2013.**

```sql
SELECT * FROM matches
WHERE date = '2013-05-02';
```
![2013-05-02](https://user-images.githubusercontent.com/106378212/173740430-6b1755c6-9a7f-4dea-a2b1-e9a3df390384.png)

**8. Fetch data of all the matches where the margin of victory is more than 100 runs.**

```sql
SELECT * FROM matches
WHERE result_margin > 100;
```
![Alt text](resultmargin_100.png)

**9. Fetch data of all the matches where the final scores of both teams are tied and order it in descending order of the date.**

```sql
SELECT * FROM matches
WHERE result = 'tie'
ORDER BY date DESC;
```
![Alt text](tie_desc.png)

**10. Get the count of cities that have hosted an IPL match.**
```sql
SELECT COUNT(DISTINCT city) 
FROM matches;
```

![Alt text](count_city.png)

**11. Get the count of venues that have hosted IPL matches.**

```sql
SELECT COUNT(DISTINCT venue)
FROM matches;
```
![Alt text](count_venue.png)


**12. Fetch data of 10 matches played before 2015.**

```sql
SELECT * FROM matches
WHERE date < '2015-01-01'
LIMIT 10;
```
![Alt text](date_before.png)

**13. Select the 10 matches ordered by winner, venue then city in descending order.**

```sql
SELECT * FROM matches
ORDER BY winner DESC, venue DESC, city DESC
LIMIT 10;
```

![winner_venue_city](https://user-images.githubusercontent.com/106378212/173237746-f121a140-aec4-4960-a102-08b73a590dd6.png)

**14. Name different Non-strikers played in the IPL.**
```sql
SELECT DISTINCT non_striker
FROM deliveries;
```

![non_striker](https://user-images.githubusercontent.com/106378212/173237835-ece52a19-e8e2-497f-a97b-037e83340e09.png)

**15. Find all the winner teams who have result margin above 100 and won by runs.**

```sql
SELECT * FROM matches
WHERE result_margin > 100 AND result = 'runs';
```

![margin_above100](https://user-images.githubusercontent.com/106378212/173237903-11df9a69-addc-4187-abdc-0351cbc3b5ea.png)

**16. Find average and sum of result margins when Rajasthan Royals is winner.**

```sql
SELECT AVG(result_margin) FROM matches
WHERE winner = 'Rajasthan Royals';
```

```sql
SELECT SUM(result_margin) FROM matches
WHERE winner = 'Rajasthan Royals';
```

![margin_rroyals](https://user-images.githubusercontent.com/106378212/173237985-5526e8a0-cb65-4a12-ad45-2532248b8428.png)
![sum_rroyals](https://user-images.githubusercontent.com/106378212/173238047-321ad8a3-651a-40eb-8699-b9a001b4dfa9.png)

**17. Find name of stadiums that are named under associations and rename it (column name) as Stadium. Find which cities these stadiums are located.**

```sql
SELECT DISTINCT venue AS  Stadium, city FROM matches
WHERE venue LIKE '%Association%';
```

![association](https://user-images.githubusercontent.com/106378212/173238148-4e13663f-e512-4da5-b4aa-1a4cd6fb481a.png)

**18. Create a database comprising of id, player of match, batsman and bowler usingleft join of 10 rows.**

```sql
SELECT matches.id, matches.player_of_match, deliveries.batsman, deliveries.bowler
FROM matches
LEFT JOIN deliveries
ON matches.id = deliveries.id
LIMIT 10;
```
![left_join](https://user-images.githubusercontent.com/106378212/173238744-2904305f-423c-4c28-b8bf-5df9c2c66a5e.png)




