--1. Create a table named 'matches' with appropriate data types for columns

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

DESCRIBE matches;

--2. Create a table named 'deliveries' with appropriate data types for columns

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

DESCRIBE deliveries;

--3. Import data from CSV file 'IPL_matches.csv' attached in resources to 'matches'

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\IPL_matches.csv" INTO TABLE matches
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id,city,date,player_of_match,venue,neutral_venue,team1,team2,toss_winner,toss_decision,winner,result,result_margin,eliminator,method,umpire1,umpire2)
;

--4. Import data from CSV file ’IPL_Ball.csv’ attached in resources to ‘deliveries’

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\IPL_Ball.csv" INTO TABLE deliveries
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--5. Select the top 20 rows of the deliveries table.

SELECT * FROM deliveries
LIMIT 20;

--6. Select the top 20 rows of the matches table.

SELECT * FROM matches
LIMIT 20;

--7. Fetch data of all the matches played on 2nd May 2013.

SELECT * FROM matches
WHERE date = '2008-05-02';

--8. Fetch data of all the matches where the margin of victory is more than 100 runs.

SELECT * FROM matches
WHERE result_margin > 100;

--9. Fetch data of all the matches where the final scores of both teams are tied and order it in descending order of the date.

SELECT * FROM matches
WHERE result = 'tie'
ORDER BY date DESC;

--10. Get the count of cities that have hosted an IPL match.

SELECT COUNT(DISTINCT city) 
FROM matches;

--11. Get the count of venues that have hosted IPL matches.

SELECT COUNT(DISTINCT venue)
FROM matches;

--12. Fetch data of 10 matches played before 2015.

SELECT * FROM matches
WHERE date < '2015-01-01'
LIMIT 10;

--13. Select the 10 matches ordered by winner, venue then city in descending order.

SELECT * FROM matches
ORDER BY winner DESC, venue DESC, city DESC
LIMIT 10;

--14. Name different Non-strikers played in the IPL

SELECT DISTINCT non_striker
FROM deliveries;

--15. Find all the winner teams who have result margin above 100 and won by runs.

SELECT * FROM matches
WHERE result_margin > 100 AND result = 'runs';

--16. Find average and sum of result margins when Rajasthan Royals is winner.

SELECT AVG(result_margin) FROM matches
WHERE winner = 'Rajasthan Royals';

SELECT SUM(result_margin) FROM matches
WHERE winner = 'Rajasthan Royals';

--17. Find name of stadiums that are named under associations and rename it (column name) as Stadium. 
--Find which cities these stadiums are located.

SELECT DISTINCT venue AS  Stadium, city FROM matches
WHERE venue LIKE '%Association%';

--18. Create a database comprising of id, player of match, batsman and bowler using
--left join of 10 rows.

SELECT matches.id, matches.player_of_match, deliveries.batsman, deliveries.bowler
FROM matches
LEFT JOIN deliveries
ON matches.id = deliveries.id
LIMIT 10;

