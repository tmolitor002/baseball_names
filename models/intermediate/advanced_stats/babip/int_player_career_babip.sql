/*

Model:          int_player_career_babip
Author:         Tom Molitor
Created:        1/10/2025
Last Modified:  1/10/2025

Description: Staging table to create player career babip tables

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/10/2025 | Tom Molitor   | Initalized model and created babip player stats                                               |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:

*/

WITH fields AS (

    SELECT 
        player_id
        , (
            singles
            + doubles
            + triples
        ) AS hits_less_home_runs
        , (
            at_bats
            - strikeouts
            + sacrifice_flies
        ) AS in_play_at_bats
    FROM {{ ref('stg_player_career_offense') }}
)

, babip AS (
    SELECT
        player_id
        , CASE
            WHEN in_play_at_bats = 0 THEN NULL
            ELSE (CAST(hits_less_home_runs AS FLOAT) / CAST(in_play_at_bats AS FLOAT)) 
            END AS babip
    FROM fields
)

, final AS (
    SELECT 
        player_id
        , babip
    FROM babip
    WHERE babip IS NOT NULL
)

SELECT *
FROM final