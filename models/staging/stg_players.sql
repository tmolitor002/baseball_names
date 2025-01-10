/*

Model:          stg_players
Author:         Tom Molitor
Created:        1/6/2025
Last Modified:  1/7/2025

Description: Staging table to bring in raw players for futher analysis

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/6/2025  | Tom Molitor   | Initalized model                                                                              |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/7/2025  | Tom Molitor   | Cast fields as appropriate data type. Reorganized some fields for better readability          |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/9/2025  | Tom Molitor   | Replaced '\N' for player_id and baseball_reference_id fields with person_id                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
-Better birth_date parsing
-More player info such as primary position
*/

SELECT 
    person_id
    , CASE
        WHEN player_id = '\N' THEN person_id
        ELSE player_id
        END AS player_id
    , CASE
        WHEN baseball_reference_player_id = '\N' THEN person_id
        ELSE baseball_reference_player_id
        END AS baseball_reference_player_id
    , first_name
    , last_name
    , official_name
    , CASE
        WHEN bats = '\N' THEN NULL
        ELSE bats
        END AS bats
    , CASE
        WHEN throws = '\N' THEN NULL
        ELSE throws
        END AS throws
    , CASE
        WHEN birth_year = '\N' THEN NULL
        ELSE birth_year
        END AS birth_year
    , CASE 
        WHEN birth_date = '\N' THEN NULL
        WHEN birth_year = '\N' THEN NULL
        WHEN CAST(birth_year AS INT) > 1950 THEN CAST(birth_date AS DATE) --arbitrary year selected. Some birth dates only have month/year
        ELSE NULL
        END AS birth_date
    , birth_date AS birth_date_str    
    , CASE
        WHEN birth_city = '\N' THEN NULL
        ELSE birth_city
        END AS birth_city
    , CASE
        WHEN birth_state = '\N' THEN NULL
        ELSE birth_state
        END AS birth_state
    , CASE
        WHEN birth_country = '\N'
        THEN NULL
        ELSE birth_country
        END AS birth_country
    , CASE
        WHEN height_inches = '\N' THEN NULL
        ELSE CAST(height_inches AS FLOAT)
        END AS height_inches
    , CASE
        WHEN weight_pounds = '\N' THEN NULL
        ELSE CAST(weight_pounds AS FLOAT)
        END AS weight_pounds

FROM {{ source('baseball', 'players') }}