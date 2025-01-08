/*

Model:          int_player_season_wRC
Author:         Tom Molitor
Created:        1/7/2025
Last Modified:  1/7/2025

Description: Staging table to create player wRC tables
Source: https://www.fangraphs.com/guts.aspx?type=cn

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/7/2025  | Tom Molitor   | Initalized model and created wRC and wOBA player stats                                                 |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
- break into smaller reference tables

*/

-- Get applicable season stats for each player
WITH player_stats AS ( 

    SELECT

        player_id
        , season
        , plate_appearances
        , at_bats
        , singles
        , doubles
        , triples
        , home_runs
        , walks -- includes intentional
        , intentional_walks
        , walks - intentional_walks AS unintentional_walks
        , hit_by_pitches
        , sacrifice_flies


    FROM {{ ref("stg_player_season_league_offense") }}
    -- Can only calculate for seasons where constants are available
    WHERE season IN (
        SELECT season
        FROM {{ ref("stg_season_constants") }}
    )
)

, intermediate_calcs AS (

    SELECT
        a.player_id
        , a.season
        , a.plate_appearances
        , (COALESCE(a.unintentional_walks,0) * b.league_wbb)    AS woba_unintentional_bb
        , (COALESCE(a.hit_by_pitches,0) * b.league_whbp)        AS woba_hbp
        , (COALESCE(a.singles,0) * b.league_w1b)                AS woba_w1b
        , (COALESCE(a.doubles,0) * b.league_w2b)                AS woba_w2b
        , (COALESCE(a.triples,0) * b.league_w3b)                AS woba_w3b
        , (COALESCE(a.home_runs,0) * b.league_whr)              AS woba_hr
        , (
                COALESCE(a.at_bats,0)
                + COALESCE(a.unintentional_walks,0)
                + COALESCE(a.sacrifice_flies,0) -- per site, this is "SF"
                + COALESCE(a.hit_by_pitches,0)
            ) AS woba_denominator
        , b.league_woba
        , b.league_woba_scale
        , b.league_rpa
    FROM player_stats a
    LEFT JOIN {{ ref("stg_season_constants") }} b
    ON a.season = b.season

)

, player_woba AS(

    SELECT 
        player_id
        , season
        , plate_appearances
        , (
            ( -- create numerator
                woba_unintentional_bb
                + woba_hbp
                + woba_w1b
                + woba_w2b
                + woba_w3b
                + woba_hr
            ) / woba_denominator
        ) AS woba
        , league_woba
        , league_woba_scale
        , league_rpa
    FROM intermediate_calcs
    WHERE woba_denominator != 0 -- don't qualify
)

, final AS (
    SELECT 
        player_id
        , season as "Season"
        , (
            (
                (
                    (woba - league_woba) / league_woba_scale
                ) + league_rpa
            ) * plate_appearances
        ) AS "wRC"
        , woba AS "wOBA"
    FROM player_woba
)

SELECT *
FROM final
ORDER BY "wRC" DESC