-- Skapar en databas, 'Player Stats'.
CREATE DATABASE playerStats;

-- Skapar tabeller.
CREATE TABLE season(
    seasonId INT PRIMARY KEY IDENTITY(1,1),
    seasonYear VARCHAR(50)
);

CREATE TABLE position(
    positionId INT PRIMARY KEY IDENTITY(1,1),
    positionName VARCHAR(50)
);

CREATE TABLE team(
    teamId INT PRIMARY KEY IDENTITY(1,1),
    teamName VARCHAR(50),
);

CREATE TABLE player(
    playerId INT PRIMARY KEY IDENTITY(1,1),
    playerName VARCHAR(50),
    playerTeamId INT,
    FOREIGN KEY (playerTeamId) REFERENCES team(teamId)
);

CREATE TABLE playerPosition(
    playerPositionId INT PRIMARY KEY IDENTITY(1,1),
    playerId INT,
    positionId INT,
    FOREIGN KEY (playerId) REFERENCES player(playerId),
    FOREIGN KEY (positionId) REFERENCES position(positionId)
);

CREATE TABLE playerStats(
    playerStatsId INT PRIMARY KEY IDENTITY(1,1),
    playerGoals INT,
    playerAssists INT,
    playerSeasonId INT,
    playerStatsPlayerId INT,
    FOREIGN KEY (playerSeasonId) REFERENCES season(seasonId),
    FOREIGN KEY (playerStatsPlayerId) REFERENCES player(playerId)
);

-- Uppdaterar tabellen med tre säsonger.
INSERT INTO season(seasonYear)
VALUES
('2015/16'), ('2016/17'), ('2017/18');

-- Visar tabellen med dem olika säsongerna.
SELECT * FROM season;

-- Uppdaterar tabellen med olika positionerna i fotboll förutom målvakt.
INSERT INTO position(positionName)
VALUES
('Striker'), ('Right Winger'), ('Left Winger'),
('Attacking Midfielder'), ('Center Midfielder'), ('Defensive Midfielder'),
('Right full-back'), ('Left full-back'), ('Center back');

-- Visar tabellen med dem olika positionerna.
SELECT * FROM position;

-- Uppdaterar tabellen med sex lag från Premier League.
INSERT INTO team(teamName)
VALUES
('Arsenal'),
('Chelsea'),
('Liverpool'),
('Manchester City'),
('Manchester United'),
('Tottenham Hotspur');

-- Visar tabellen med dem olika lagen.
SELECT * FROM team;

-- Uppdaterar med spelare laget dem spelade för.
INSERT INTO player(playerName, playerTeamId)
VALUES
('Harry Kane', 6),         -- Tottenham Hotspur
('Sergio Agüero', 4),      -- Manchester City
('Alexis Sánchez', 1),     -- Arsenal
('Diego Costa', 2),        -- Chelsea
('Eden Hazard', 2),        -- Chelsea
('Oliver Giroud', 1),      -- Arsenal
('Zlatan Ibrahimovic', 5), -- Manchester United
('Dele Alli', 6),          -- Tottenham Hotspur
('Cesc Fàbregas', 2),      -- Chelsea
('Santi Cazorla', 1),      -- Arsenal
('Ángel Di María', 5),     -- Manchester United
('Mesut Özil', 1),         -- Arsenal
('Christian Eriksen', 6),  -- Tottenham Hotspur
('Kevin De Bruyne', 4),    -- Manchester City
('David Silva', 4),        -- Manchester City
('James Milner', 3),       -- Liverpool
('Roberto Firmino', 3);    -- Liverpool

-- Visar tabellen med 'player.
SELECT * FROM player;

-- Kopplar spelare till sina positioner i playerPosition.
INSERT INTO playerPosition(playerId, positionId)
VALUES
(1, 1),   -- Harry Kane - Striker
(2, 1),   -- Sergio Agüero - Striker
(3, 3),   -- Alexis Sánchez - Left Winger
(4, 1),   -- Diego Costa - Striker
(5, 2),   -- Eden Hazard - Right Winger
(6, 1),   -- Olivier Giroud - Striker
(7, 1),   -- Zlatan Ibrahimovic - Striker
(8, 4),   -- Dele Alli - Attacking Midfielder
(9, 5),   -- Cesc Fàbregas - Center Midfielder
(10, 5),  -- Santi Cazorla - Center Midfielder
(11, 3),  -- Ángel Di María - Left Winger
(12, 4),  -- Mesut Özil - Attacking Midfielder
(13, 4),  -- Christian Eriksen - Attacking Midfielder
(14, 5),  -- Kevin De Bruyne - Center Midfielder
(15, 5),  -- David Silva - Center Midfielder
(16, 5),  -- James Milner - Center Midfielder
(17, 1);  -- Roberto Firmino - Striker

-- Visar alla spelare och deras positioner.
SELECT
    player.playerName AS PlayerName,
    position.positionName AS Position
FROM
    player
INNER JOIN playerPosition ON player.playerId = playerPosition.playerId
INNER JOIN position ON playerPosition.positionId = position.positionId

-- Uppdaterar spelarna med antal mål + assist för vald säsong.
INSERT INTO playerStats(playerGoals, playerAssists, playerStatsPlayerId, playerSeasonId)
VALUES
(29, 7, 1, 1),    -- Harry Kane, säsong 2015/16 (36 poäng)
(20, 6, 2, 1),    -- Sergio Agüero, säsong 2015/16 (26 poäng)
(24, 10, 3, 1),   -- Alexis Sánchez, säsong 2015/16 (34 poäng)
(20, 3, 4, 1),    -- Diego Costa, säsong 2015/16 (23 poäng)
(16, 5, 5, 2),    -- Eden Hazard, säsong 2016/17 (21 poäng)
(12, 3, 6, 2),    -- Olivier Giroud, säsong 2016/17 (15 poäng)
(17, 5, 7, 3),    -- Zlatan Ibrahimovic, säsong 2017/18 (22 poäng)
(18, 7, 8, 3),    -- Dele Alli, säsong 2017/18 (25 poäng)
(5, 12, 9, 2),    -- Cesc Fàbregas, säsong 2016/17 (17 poäng)
(2, 6, 10, 2),    -- Santi Cazorla, säsong 2016/17 (8 poäng)
(4, 7, 11, 3),    -- Ángel Di María, säsong 2017/18 (11 poäng)
(8, 9, 12, 1),    -- Mesut Özil, säsong 2015/16 (17 poäng)
(12, 11, 13, 2),  -- Christian Eriksen, säsong 2016/17 (23 poäng)
(6, 18, 14, 3),   -- Kevin De Bruyne, säsong 2017/18 (24 poäng)
(5, 11, 15, 3),   -- David Silva, säsong 2017/18 (16 poäng)
(7, 5, 16, 1),    -- James Milner, säsong 2015/16 (12 poäng)
(11, 7, 17, 1);   -- Roberto Firmino, säsong 2015/16 (18 poäng)

-- Hämtar varje spelarens namn tillsammans med deras mål, assist och säsong.
SELECT
    player.playerName AS PlayerName,
    playerStats.playerGoals AS Goals,
    playerStats.playerAssists AS Assists,
    season.seasonYear AS Season,
    (playerStats.playerGoals + playerStats.playerAssists) AS TotalPoints
FROM
    player
INNER JOIN playerStats ON player.playerId = playerStats.playerStatsPlayerId
INNER JOIN season ON playerStats.playerSeasonId = season.seasonId -- Se över namnet på playerStats.

GO

------------------------------------------------------------------------------------
------------------------------------- DROP -----------------------------------------

-- Börjar droppa tabeller nedifrån, uppåt.
DROP TABLE season; -- 6.
DROP TABLE position; -- 5.
DROP TABLE team; -- 4.
DROP TABLE player; -- 3.
DROP TABLE playerPosition; -- 2.
DROP TABLE playerStats; -- 1.

----

-- För att droppa vyerna.
DROP VIEW PlayerSeasonStats;
DROP VIEW TeamSeasonPoints;

----

-- För att droppa Store Procedures.
DROP PROCEDURE ADD_team;
DROP PROCEDURE ADD_playerWithDetails;
DROP PROCEDURE UPDATE_playerStats;
DROP PROCEDURE DELETE_player;

------------------------------------- DROP -----------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
---------------------------------- UNIKA INDEX -------------------------------------

-- Unikt index för spelare i samma lag.
CREATE UNIQUE INDEX UniquePlayerPerTeam
ON player (playerName, playerTeamId);

-- Utförningsexemplar som visar att det ej går lägga till samma spelare:
EXEC ADD_playerWithDetails 'Harry Kane', 6, 1, 1, 25, 5; -- Tottenham, Striker, 2015/16, 25, 5 assist.
EXEC ADD_playerWithDetails 'Dominik Calwin-Lewis', 7, 1, 3, 15, 6; -- Everton, Striker, 2017/18, 15 mål, 6 assist. 


GO

-- Unikt index för lagets namn.
CREATE UNIQUE INDEX UniqueTeamName
ON team (teamName);

-- Utförningsexempel för att visa att det ej går att lägga till samma lag.
INSERT INTO team(teamName)
VALUES('Arsenal');

GO

---------------------------------- UNIKA INDEX -------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------------- VIEWS ----------------------------------------

-- Vy 1: Visar spelarnas statistik per säsong.
CREATE VIEW PlayerSeasonStats AS
SELECT 
    player.playerName AS PlayerName,
    team.teamName AS Team,
    season.seasonYear AS Season,
    playerStats.playerGoals AS Goals,
    playerStats.playerAssists AS Assists,
    (playerStats.playerGoals + playerStats.playerAssists) AS totalPoints
FROM 
    player
INNER JOIN playerStats ON player.playerId = playerStats.playerStatsPlayerId
INNER JOIN team ON player.playerTeamId = team.teamId
INNER JOIN season ON playerStats.playerSeasonId = season.seasonId;

GO

-- Använder vy 1 för att få fram spelare med mer än 20 poäng en viss säsong.
SELECT * FROM PlayerSeasonStats 
WHERE totalPoints > 20;

GO

-- Vy 2: Visar lagets totala poäng per säsong.
CREATE VIEW TeamSeasonPoints AS
SELECT 
    team.teamName AS Team,
    season.seasonYear AS Season,
    SUM(playerStats.playerGoals + playerStats.playerAssists) AS TotalPoints
FROM 
    player
INNER JOIN team ON player.playerTeamId = team.teamId
INNER JOIN playerStats ON player.playerId = playerStats.playerStatsPlayerId
INNER JOIN season ON playerStats.playerSeasonId = season.seasonId
GROUP BY 
    team.teamName, season.seasonYear;

GO

-- Använder vy 2 för att visa lagens prestationer från högst poäng nedåt.
SELECT * FROM TeamSeasonPoints 
ORDER BY totalPoints DESC;

GO

------------------------------------- VIEWS ----------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
----------------------------------- TRANSACTION ------------------------------------

-- Transaktion: Lägger till en ny säsong och uppdaterar statistik för flera spelare.
BEGIN TRANSACTION;

BEGIN
    -- Lägger till en ny säsong.
    INSERT INTO season (seasonYear)
    VALUES ('2018/19');

    -- Hämtar det nya säsongs-ID:t.
    DECLARE @newSeasonId INT = SCOPE_IDENTITY();

    -- Uppdaterar statistik för flera spelare för den nya säsongen.
    INSERT INTO playerStats (playerGoals, playerAssists, playerStatsPlayerId, playerSeasonId)
    VALUES 
        (22, 10, 1, @newSeasonId), -- Harry Kane
        (15, 8, 2, @newSeasonId); -- Sergio Agüero
END

-- Visar vyn med alla spelare + lag, mål och assist.
SELECT * FROM PlayerSeasonStats

-- Bekräftar alla ändringar.
COMMIT;

-- Återställer ändringar om ett fel inträffar.
ROLLBACK;

GO

-- Transaktion: Uppdaterar Harry Kane's mål och assist samtidigt.
BEGIN TRANSACTION;

BEGIN
    UPDATE playerStats
    SET 
        playerGoals = 30,
        playerAssists = 10
    WHERE 
        playerStatsPlayerId = 1 AND playerSeasonId = 1;
END

-- Visar vyn med alla spelare + lag, mål och assist.
SELECT * FROM PlayerSeasonStats

-- Bekräftar transaktionen.
COMMIT;

-- Återställer ändringar om ett fel inträffar.
ROLLBACK;


GO

----------------------------------- TRANSACTION ------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--------------------------------- STORE PROCUDUERS ---------------------------------

-- Skapar en procedure för att lägga till ett nytt lag i tabellen 'team'.
CREATE PROCEDURE ADD_team (@team VARCHAR(50))
AS
BEGIN
    INSERT INTO team
    VALUES(@team)
END;

-- Utförningsexempel:
EXEC ADD_team 'Everton';

-- Visar tabellen med dem olika lagen i fallande ordning på teamId.
SELECT * FROM team ORDER by teamId ASC

GO

-- Skapar en procedure som lägger till en ny spelare + lag, position samt deras statistik (antal mål och assist).
CREATE PROCEDURE ADD_playerWithDetails
    @playerName VARCHAR(50),
    @teamId INT,
    @positionId INT,
    @seasonId INT,
    @goals INT,
    @assists INT
AS
BEGIN
    -- Lägger till spelaren i player-tabellen.
    INSERT INTO player (playerName, playerTeamId)
    VALUES (@playerName, @teamId);

    -- Hämtar det nyligen skapade spelarens ID.
    DECLARE @newPlayerId INT = SCOPE_IDENTITY();

    -- Lägger till spelarens position i playerPosition-tabellen.
    INSERT INTO playerPosition (playerId, positionId)
    VALUES (@newPlayerId, @positionId);

    -- Lägger till spelarens statistik i playerStats-tabellen.
    INSERT INTO playerStats (playerGoals, playerAssists, playerStatsPlayerId, playerSeasonId)
    VALUES (@goals, @assists, @newPlayerId, @seasonId);
END;

-- Utförningsexempel:
EXEC ADD_playerWithDetails 'Dominik Calwin-Lewis', 7, 1, 3, 15, 6; -- Everton, Striker, 2017/18, 15 mål, 6 assist. 
EXEC ADD_playerWithDetails 'Bukayo Saka', 5, 2, 2, 20, 10; -- Arsenal, Left Winger, 2016/17, 20 mål, 10 assist.

-- Visar vyn med alla spelare + lag, mål och assist.
SELECT * FROM PlayerSeasonStats

GO

-- Skapar en procedure som uppdaterar mål och assist för en spelare för en specifik säsong.
CREATE PROCEDURE UPDATE_playerStats
    @playerStatsPlayerId INT,
    @playerSeasonId INT,
    @newGoals INT,
    @newAssists INT
AS
BEGIN
    UPDATE playerStats
    SET 
        playerGoals = @newGoals,
        playerAssists = @newAssists
    WHERE 
        playerStatsPlayerId = @playerStatsPlayerId AND playerSeasonId = @playerSeasonId;
END;

-- Utförningsexempel:
EXEC UPDATE_playerStats 17, 1, 16, 8; -- Uppdaterar Roberto Firmino statistik för säsongen 2015/16 till 15 mål och 8 assists.
EXEC UPDATE_playerStats 5, 2, 23, 17; -- Uppdaterer Eden Hazard statistik för säsongen 2016/17 till 23 mål och 17 assists.

-- Visar vyn med alla spelare + lag, mål och assist.
SELECT * FROM PlayerSeasonStats

GO

-- Skapar en procedure som raderar en spelare, dess postioner och statistik.
CREATE PROCEDURE DELETE_player (@playerId INT)
AS
BEGIN
    -- Raderar statistiken.
    DELETE FROM playerStats WHERE playerStatsPlayerId = @playerId;

    -- Raderar positionen.
    DELETE FROM playerPosition WHERE playerId = @playerId;

    -- Raderar spelaren.
    DELETE FROM player WHERE playerId = @playerId;
END;

-- Utförningsexempel:
EXEC DELETE_player 16; -- Tar bort spelaren James Milner + lag, position, mål och assist.
EXEC DELETE_player 10; -- Tar bort spelaren Santi Cazorla + lag, position, mål och assist.

-- Visar vyn med alla spelare + lag, mål och assist.
SELECT * FROM PlayerSeasonStats

GO

--------------------------------- STORE PROCUDUERS ---------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-------------------------------------- CRUD ----------------------------------------

------------- // C // ------------- 
-- Lägger till säsongen 2023/24 och anfallaren Erling Haaland som spelare för Manchester City.
-- Lägger till positionen 'striker' för Erling Haaland.
-- Lägger till Erling Haaland's statistik för säsongen 2023/24.

INSERT INTO season(seasonYear)
VALUES('2023/24')

EXEC ADD_playerWithDetails 
    @playerName = 'Erling Haaland', 
    @teamId = 4,  -- Manchester City
    @positionId = 3,  -- Striker
    @seasonId = 1,  -- Säsong 2015/16
    @goals = 27, -- 27 mål
    @assists = 5; -- 5 assist

-- Visar vyn med alla spelare + lag, mål och assist.
SELECT * FROM PlayerSeasonStats

------------- // R // -------------
-- Visar spelarnas namn, lag och antal mål för säsongen 2015/16 i fallande ordning.
SELECT 
    player.playerName,
    team.teamName,
    playerStats.playerGoals,
    season.seasonYear
FROM 
    player
INNER JOIN team ON player.playerTeamId = team.teamId
INNER JOIN playerStats ON player.playerId = playerStats.playerStatsPlayerId
INNER JOIN season ON playerStats.playerSeasonId = season.seasonId
WHERE 
    season.seasonYear = '2015/16'
ORDER BY
    playerGoals DESC;

------------- // U // -------------
-- Uppdaterar spelarens Alexis Sánchez position.
UPDATE playerPosition
SET positionId = 4  -- Ny position: Attacking Midfielder
WHERE playerId = 3; -- Alexis Sánchez

-- Hämtar alla spelare och deras positioner.
SELECT
    player.playerName AS PlayerName,
    position.positionName AS Position
FROM
    player
INNER JOIN playerPosition ON player.playerId = playerPosition.playerId
INNER JOIN position ON playerPosition.positionId = position.positionId;


------------- // D // -------------

-- Utförningsexempel:
EXEC DELETE_player 3; -- Raderar spelaren 'Alexis Sánchez' och tillhörande data.
EXEC DELETE_player 11 -- Raderar spelaren 'Ángel Di Maria' och tillhörande data. 

-- Visar vyn med alla spelare + lag, mål och assist.
SELECT * FROM PlayerSeasonStats

GO

-------------------------------------- CRUD ----------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------------ SQL-frågor ------------------------------------

-- Fråga: Visar spelarnas namn, lag och antal mål för säsongen 2015/16 i fallande ordning.
SELECT 
    player.playerName,
    team.teamName,
    playerStats.playerGoals,
    season.seasonYear
FROM 
    player
INNER JOIN team ON player.playerTeamId = team.teamId
INNER JOIN playerStats ON player.playerId = playerStats.playerStatsPlayerId
INNER JOIN season ON playerStats.playerSeasonId = season.seasonId
WHERE 
    season.seasonYear = '2015/16'
ORDER BY
    playerGoals DESC;

GO

    -- Fråga: Visar alla spelare med deras position och poäng (mål + assist) för bästa säsongen i fallande ordning.
SELECT 
    player.playerName AS PlayerName,
    position.positionName AS Position,
    playerStats.playerGoals AS Goals,
    playerStats.playerAssists AS Assists,
    (playerStats.playerGoals + playerStats.playerAssists) AS TotalPoints
FROM 
    player
INNER JOIN playerPosition ON player.playerId = playerPosition.playerId
INNER JOIN position ON playerPosition.positionId = position.positionId
INNER JOIN playerStats ON player.playerId = playerStats.playerStatsPlayerId
ORDER BY 
    TotalPoints DESC;

GO

-- Fråga: Beräknar det genomsnittliga antalet mål för alla spelare under säsongen 2015/16.
SELECT 
    season.seasonYear AS Season,
    AVG(playerStats.playerGoals) AS AverageGoals
FROM 
    playerStats
INNER JOIN season ON playerStats.playerSeasonId = season.seasonId
WHERE 
    season.seasonYear = '2015/16'
GROUP BY 
    season.seasonYear;

GO

-- Fråga: Visar den totala poängen (mål + assist) per lag under säsongen 2017/18 i alfabetisk ordning.
SELECT 
    team.teamName AS Team,
    SUM(playerStats.playerGoals + playerStats.playerAssists) AS TotalPoints
FROM 
    player
INNER JOIN team ON player.playerTeamId = team.teamId
INNER JOIN playerStats ON player.playerId = playerStats.playerStatsPlayerId
INNER JOIN season ON playerStats.playerSeasonId = season.seasonId
WHERE 
    season.seasonYear = '2017/18'
GROUP BY 
    team.teamName;

GO

----------------------------------- SQL-frågor ------------------------------------
-----------------------------------------------------------------------------------