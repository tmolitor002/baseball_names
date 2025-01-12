/*

Model:          int_player_season_ops_plus
Author:         Tom Molitor
Created:        1/10/2025
Last Modified:  1/10/2025

Description: Staging table to create player ops plus tables

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/10/2025 | Tom Molitor   | Initalized model and created ops plus player stats                                               |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:

*/

-- On Base Percentage:
-- (Hits + Walks + Hit By Pitch)/(At Bats + Walks + Hit By Pitch + Sac Fly)

-- Slugging Percentage:
-- (Singles * 1 + Doubles * 2 + Triples * 3 + Home Runs * 4)/ At Bats

WITH player_season_stats AS (

    SELECT 
        player_id
        , season
        , COALESCE(at_bats, 0)          AS at_bats
        , COALESCE(hits, 0)             AS hits
        , COALESCE(singles, 0)          AS singles
        , COALESCE(doubles, 0)          AS doubles
        , COALESCE(triples, 0)          AS triples
        , COALESCE(home_runs, 0)        AS home_runs
        , COALESCE(walks, 0)            AS walks
        , COALESCE(hit_by_pitches, 0)   AS hit_by_pitches
        , COALESCE(sacrifice_flies, 0)  AS sacrifice_flies
    FROM {{ ref('stg_player_season_league_offense') }}

)

, player_obp_and_slug AS (
    SELECT
        player_id
        , season
        , -- On Base Percentage:
        CASE
            WHEN (
                at_bats
                + walks
                + hit_by_pitches
                + sacrifice_flies
            ) = 0 THEN 0.0
            ELSE
            -- Numerator: Hits + Walks + Hit by Pitch
            (CAST( (
                hits
                + walks
                + hit_by_pitches
            ) AS FLOAT) 
            -- Denominator: At Bats + Walks + Hit by Pitch + Sacrifice Flies    
            / CAST( (
                at_bats
                + walks
                + hit_by_pitches
                + sacrifice_flies
            ) AS FLOAT)
            ) END AS on_base_percentage
        , -- Slugging Percentage
        CASE
            WHEN at_bats = 0 THEN 0.0
            ELSE (
                -- Numerator
                CAST((
                    singles
                    + (doubles * 2)
                    + (triples * 3)
                    + (home_runs * 4)
                ) AS FLOAT)
                -- Denominator
                / CAST(at_bats AS FLOAT)
            ) END AS slugging_percentage
    FROM player_season_stats
)

, player_obp_and_slug_with_league AS (
    SELECT a.*
        , b.league_on_base_percentage
        , b.league_slugging_percentage
FROM player_obp_and_slug a
LEFT JOIN {{ ref('int_league_season_ops_plus') }} b
ON a.season = b.season
)

, final AS (
    SELECT player_id
        , season
        , (
            100
            * (
                (on_base_percentage/league_on_base_percentage)
                + (slugging_percentage/league_slugging_percentage)
                - 1
            )
        ) AS ops_plus
    FROM player_obp_and_slug_with_league
)

SELECT *
FROM final
ORDER BY ops_plus DESC