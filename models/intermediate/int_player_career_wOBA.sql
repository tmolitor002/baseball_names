/*

Model:          int_player_career_wOBA
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
| 1/9/2025  | Tom Molitor   | Initalized model and created wOBA player career stats                                 |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
- Confirm this is the right way to calc career wOBA

*/

WITH final AS(
    SELECT

        player_id
        , COUNT("Season")                           AS seasons
        , (SUM("wOBA") / COUNT("Season"))           AS career_wOBA_season_weighted

    FROM {{ ref("int_player_season_wOBA") }}
    GROUP BY player_id
)

SELECT *
FROM final
ORDER BY career_wOBA_season_weighted DESC