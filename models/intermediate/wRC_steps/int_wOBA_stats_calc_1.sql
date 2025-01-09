/*

Model:          int_wOBA_stats_calc_1
Author:         Tom Molitor
Created:        1/9/2025
Last Modified:  1/9/2025

Description: Intermediate table to calculate wOBA by season and player


+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/9/2025  | Tom Molitor   | Initalized model to calculate wOBA by players and season                                       |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
*/

-- Calculate stats by player
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
    FROM {{ ref("int_wRC_stats_calc_1") }}
    WHERE woba_denominator != 0 -- don't qualify