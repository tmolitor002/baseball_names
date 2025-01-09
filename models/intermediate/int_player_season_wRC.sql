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
| 1/7/2025  | Tom Molitor   | Initalized model and created wRC and wOBA player stats                                        |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/9/2025  | Tom Molitor   | Broke down query into smaller models, saved in intermediate/wRC_steps                         |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
- break into smaller reference tables

*/

-- Get applicable season stats for each player
WITH final AS (
    SELECT 
        player_id
        , plate_appearances
        , season as "Season"
        , (
            (
                (
                    (woba - league_woba) / league_woba_scale
                ) + league_rpa
            ) * plate_appearances
        ) AS "wRC"
        , woba AS "wOBA"
    FROM {{ ref("int_wOBA_stats_calc_1") }}
)

SELECT *
FROM final
ORDER BY "wRC" DESC