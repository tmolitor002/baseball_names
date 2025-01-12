/*

Model:          int_league_season_ops_plus
Author:         Tom Molitor
Created:        1/10/2025
Last Modified:  1/10/2025

Description: Intermediate table used to calculate ops_plus

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/10/2025 | Tom Molitor   | Initalized model and created league average obp and slugging                                  |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
- Replaced with league factor OBP and SLG: https://www.mlb.com/glossary/advanced-stats/on-base-plus-slugging-plus

*/

WITH player_season_stats AS (

    SELECT 
        player_id
        , season
        , at_bats
        , hits
        , singles
        , doubles
        , triples
        , home_runs
        , walks
        , CASE -- hit_by_pitches not always tracked in earlier years
            WHEN hit_by_pitches IS NULL THEN 0
            ELSE hit_by_pitches
            END AS hit_by_pitches
        , CASE -- sacrifice_flies not always tracked in earlier years
            WHEN sacrifice_flies IS NULL THEN 0
            ELSE sacrifice_flies
            END AS sacrifice_flies
    
    FROM {{ ref('stg_player_season_league_offense') }}
)

-- On Base Percentage:
-- (Hits + Walks + Hit By Pitch)/(At Bats + Walks + Hit By Pitch + Sac Fly)

-- Slugging Percentage:
-- (Singles * 1 + Doubles * 2 + Triples * 3 + Home Runs * 4)/ At Bats

, league_season_stats AS (
    SELECT
        season
        , -- On Base Percentage:
        (
            CAST((
                -- Numerator
                SUM(hits)
                + SUM(walks)
                + SUM(hit_by_pitches)
            ) AS FLOAT) /
            CAST((
                -- Denominator
                SUM(at_bats)
                + SUM(walks)
                + SUM(hit_by_pitches)
                + SUM(sacrifice_flies)
            ) AS FLOAT)
        ) AS on_base_percentage
        , -- Slugging Percentage
        (
            CAST((
                -- Numerator
                SUM(singles)
                + (SUM(doubles) * 2)
                + (SUM(triples) * 3)
                + (SUM(home_runs) * 4)
            ) AS FLOAT)
            /
            CAST((
                SUM(at_bats)
            ) AS FLOAT)
        ) AS slugging_percentage

    FROM player_season_stats
    GROUP BY season
)

, final AS (
    SELECT 
        season
        , on_base_percentage    AS league_on_base_percentage
        , slugging_percentage   AS league_slugging_percentage
    FROM league_season_stats
)

SELECT *
FROM final