/*

Model:          int_player_season_wOBA
Author:         Tom Molitor
Created:        1/9/2025
Last Modified:  1/9/2025

Description: Staging table to create player wOBA table
Source: https://www.fangraphs.com/guts.aspx?type=cn

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/9/2025  | Tom Molitor   | Initalized model and created wOBA player stats                                                |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:

*/

-- Get applicable season stats for each player
WITH final AS (
    SELECT 
        player_id
        , season as "Season"
        , woba AS "wOBA"
    FROM {{ ref("int_wOBA_stats_calc_1") }}
)

SELECT *
FROM final
ORDER BY "wOBA" DESC