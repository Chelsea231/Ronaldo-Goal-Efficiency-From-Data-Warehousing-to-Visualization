SELECT * FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED";

SELECT 
    column_name, 
    SUM(null_count) AS total_nulls
FROM (
    SELECT 'Unnamed: 0' AS column_name, COUNT(*) AS null_count FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE "Unnamed: 0" IS NULL
    UNION ALL
    SELECT 'MATCH_EVENT_ID', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE MATCH_EVENT_ID IS NULL
    UNION ALL
    SELECT 'LOCATION_X', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE LOCATION_X IS NULL
    UNION ALL
    SELECT 'LOCATION_Y', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE LOCATION_Y IS NULL
    UNION ALL
    SELECT 'REMAINING_MIN', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE REMAINING_MIN IS NULL
    UNION ALL
    SELECT 'POWER_OF_SHOT', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE POWER_OF_SHOT IS NULL
    UNION ALL
    SELECT 'KNOCKOUT_MATCH', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE KNOCKOUT_MATCH IS NULL
    UNION ALL
    SELECT 'GAME_SEASON', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE GAME_SEASON IS NULL
    UNION ALL
    SELECT 'REMAINING_SEC', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE REMAINING_SEC IS NULL
    UNION ALL
    SELECT 'DISTANCE_OF_SHOT', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE DISTANCE_OF_SHOT IS NULL
    UNION ALL
    SELECT 'IS_GOAL', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE IS_GOAL IS NULL
    UNION ALL
    SELECT 'AREA_OF_SHOT', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE AREA_OF_SHOT IS NULL
    UNION ALL
    SELECT 'SHOT_BASICS', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE SHOT_BASICS IS NULL
    UNION ALL
    SELECT 'RANGE_OF_SHOT', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE RANGE_OF_SHOT IS NULL
    UNION ALL
    SELECT 'TEAM_NAME', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE TEAM_NAME IS NULL
    UNION ALL
    SELECT 'DATE_OF_GAME', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE DATE_OF_GAME IS NULL
    UNION ALL
    SELECT '"home/away"', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE "home/away" IS NULL
    UNION ALL
    SELECT 'SHOT_ID_NUMBER', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE SHOT_ID_NUMBER IS NULL
    UNION ALL
    SELECT '"LAT/LNG"', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE "lat/lng" IS NULL
    UNION ALL
    SELECT 'TYPE_OF_SHOT', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE TYPE_OF_SHOT IS NULL
    UNION ALL
    SELECT 'MATCH_ID', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE MATCH_ID IS NULL
    UNION ALL
    SELECT 'TEAM_ID', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE TEAM_ID IS NULL
    UNION ALL
    SELECT 'REMAINING_MIN_1', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE REMAINING_MIN_1 IS NULL
    UNION ALL
    SELECT 'POWER_OF_SHOT_1', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE POWER_OF_SHOT_1 IS NULL
    UNION ALL
    SELECT 'KNOCKOUT_MATCH_1', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE KNOCKOUT_MATCH_1 IS NULL
    UNION ALL
    SELECT 'REMAINING_SEC_1', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE REMAINING_SEC_1 IS NULL
    UNION ALL
    SELECT 'DISTANCE_OF_SHOT_1', COUNT(*) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED" WHERE DISTANCE_OF_SHOT_1 IS NULL
) subquery
GROUP BY column_name
ORDER BY total_nulls DESC;

/* event_match_id */
UPDATE "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
SET match_event_id = (
    SELECT MEDIAN(match_event_id) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
)
WHERE match_event_id IS NULL;

/* Fill missing values in location_x with its median */
UPDATE "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
SET location_x = (
    SELECT MEDIAN(location_x) 
    FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
)
WHERE location_x IS NULL;

/* Fill missing values in location_y with its median */
UPDATE "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
SET location_y = (
    SELECT MEDIAN(location_y) 
    FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
)
WHERE location_y IS NULL;

/* remaining_min */
UPDATE "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
SET remaining_min = (
    SELECT MEDIAN(remaining_min) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
)
WHERE remaining_min IS NULL;

/* Fill missing values in power_of_shot with the most frequent value */
UPDATE "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
SET power_of_shot = (
    SELECT power_of_shot 
    FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
    GROUP BY power_of_shot
    ORDER BY COUNT(*) DESC 
    LIMIT 1
)
WHERE power_of_shot IS NULL;

/* remaining_sec */
UPDATE "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
SET remaining_sec = (
    SELECT MEDIAN(remaining_sec) FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
)
WHERE remaining_sec IS NULL;

/* team_name */
UPDATE "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
SET TEAM_NAME = 'Manchester United'
WHERE TEAM_NAME IS NULL;

/*Type of shot 
UPDATE YDS_DATA_CLEANED
SET TYPE_OF_SHOT = COALESCE(TYPE_OF_SHOT, TYPE_OF_COMBINED_SHOT),
    TYPE_OF_COMBINED_SHOT = COALESCE(TYPE_OF_COMBINED_SHOT, TYPE_OF_SHOT);
ALTER TABLE YDS_DATA_CLEANED DROP COLUMN TYPE_OF_COMBINED_SHOT;
*/

/*Power of shot .0 */
UPDATE YDS_DATA_CLEANED
SET POWER_OF_SHOT_1 = COALESCE(POWER_OF_SHOT_1, POWER_OF_SHOT)
WHERE POWER_OF_SHOT_1 IS NULL;

/* Reamining min .0 */
UPDATE YDS_DATA_CLEANED
SET REMAINING_MIN_1 = COALESCE(REMAINING_MIN_1 ,REMAINING_MIN )
WHERE REMAINING_MIN_1  IS NULL;

/* KNOCKOUT_MATCH_1 */
UPDATE YDS_DATA_CLEANED
SET KNOCKOUT_MATCH_1 = COALESCE(KNOCKOUT_MATCH_1 ,KNOCKOUT_MATCH )
WHERE KNOCKOUT_MATCH_1  IS NULL;


/* REMAINING_SEC_1 */
UPDATE YDS_DATA_CLEANED
SET REMAINING_SEC_1 = COALESCE(REMAINING_SEC_1 ,REMAINING_SEC )
WHERE REMAINING_SEC_1 IS NULL;

/*DISTANCE_OF_SHOT_1*/
UPDATE YDS_DATA_CLEANED
SET DISTANCE_OF_SHOT_1 = COALESCE(DISTANCE_OF_SHOT_1,DISTANCE_OF_SHOT )
WHERE DISTANCE_OF_SHOT_1  IS NULL;

/* Visual 1 */
SELECT 
    SHOT_BASICS, 
    COUNT(DISTINCT SHOT_ID_NUMBER) AS TOTAL_SHOTS,  -- Count of unique shots
    COUNT(DISTINCT CASE WHEN IS_GOAL = 0 THEN SHOT_ID_NUMBER END) AS MISSED_SHOTS,
    COUNT(DISTINCT CASE WHEN IS_GOAL = 1 THEN SHOT_ID_NUMBER END) AS GOALS,
    ROUND(
        (COUNT(DISTINCT CASE WHEN IS_GOAL = 1 THEN SHOT_ID_NUMBER END) * 100.0) / 
        NULLIF(COUNT(DISTINCT SHOT_ID_NUMBER), 0), 2
    ) AS GOAL_CONVERSION_RATE,
    ROUND(AVG(DISTANCE_OF_SHOT), 2) AS AVG_SHOT_DISTANCE  -- Average distance of shots per category
FROM RONALDO_DATA.PUBLIC.YDS_DATA_CLEANED
GROUP BY SHOT_BASICS
ORDER BY GOAL_CONVERSION_RATE DESC;

/*Visual 2 */
SELECT 
    REMAINING_MIN,
    KNOCKOUT_MATCH,
    COUNT(SHOT_ID_NUMBER) AS TOTAL_SHOTS,
    SUM(CASE WHEN IS_GOAL = 1 THEN 1 ELSE 0 END) AS GOALS,
    (SUM(CASE WHEN IS_GOAL = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(SHOT_ID_NUMBER) AS GOAL_SUCCESS_PERCENTAGE
FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
GROUP BY REMAINING_MIN, KNOCKOUT_MATCH
ORDER BY REMAINING_MIN ASC, KNOCKOUT_MATCH DESC;

/*visual 3 */
SELECT 
    YEAR(TO_DATE(DATE_OF_GAME)) AS YEAR,  -- Convert to DATE first
    CASE 
        WHEN "home/away" LIKE 'MANU vs%' THEN 'Home' 
        WHEN "home/away" LIKE 'MANU @%' THEN 'Away' 
        ELSE 'Neutral' 
    END AS MATCH_LOCATION, 
    COUNT(SHOT_ID_NUMBER) AS TOTAL_SHOTS,
    SUM(CASE WHEN IS_GOAL = 1 THEN 1 ELSE 0 END) AS GOALS,
    ROUND((SUM(CASE WHEN IS_GOAL = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(SHOT_ID_NUMBER), 2) AS GOAL_SUCCESS_PERCENTAGE
FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
GROUP BY YEAR(TO_DATE(DATE_OF_GAME)), 
         CASE 
            WHEN "home/away" LIKE 'MANU vs%' THEN 'Home' 
            WHEN "home/away" LIKE 'MANU @%' THEN 'Away' 
            ELSE 'Neutral' 
         END
ORDER BY YEAR ASC, GOAL_SUCCESS_PERCENTAGE DESC;

/* visual 4 */
SELECT 
    DISTANCE_OF_SHOT,
    POWER_OF_SHOT,
    COUNT(SHOT_ID_NUMBER) AS TOTAL_SHOTS,
    SUM(CASE WHEN IS_GOAL = 1 THEN 1 ELSE 0 END) AS SUCCESSFUL_SHOTS,
    SUM(CASE WHEN IS_GOAL = 0 THEN 1 ELSE 0 END) AS MISSED_SHOTS,
    ROUND((SUM(CASE WHEN IS_GOAL = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(SHOT_ID_NUMBER), 2) AS GOAL_SUCCESS_PERCENTAGE
FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
GROUP BY DISTANCE_OF_SHOT, POWER_OF_SHOT
ORDER BY DISTANCE_OF_SHOT , POWER_OF_SHOT asc ;

/* Visual 5 */
SELECT 
    AREA_OF_SHOT, 
    COUNT(*) AS TOTAL_SHOTS, 
    COUNT(CASE WHEN IS_GOAL = 1 THEN 1 END) AS GOALS_SCORED,
    ROUND(
        COUNT(CASE WHEN IS_GOAL = 1 THEN 1 END) * 100.0 / COUNT(*), 
        2
    ) AS SHOT_CONVERSION_PERCENTAGE
FROM "RONALDO_DATA"."PUBLIC"."YDS_DATA_CLEANED"
GROUP BY AREA_OF_SHOT
ORDER BY TOTAL_SHOTS DESC;
