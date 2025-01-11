/*

Model:          int_wRC_stats_calc_1
Author:         Tom Molitor
Created:        1/9/2025
Last Modified:  1/9/2025

Description: Intermediate table to calculate wRC by season and player


+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/9/2025  | Tom Molitor   | Initalized model to calculate wRC by players and season                                       |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
*/

-- Calculate stats by player
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
    FROM {{ ref("int_wRC_player_season_stats") }} a
    LEFT JOIN {{ ref("stg_season_constants") }} b
    ON a.season = b.season