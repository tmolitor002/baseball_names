/*

Model:          int_player_career_wRC
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
| 1/7/2025  | Tom Molitor   | Initalized model and created wRC and wOBA player career stats                                 |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/9/2025  | Tom Molitor   | Renamed wRC and wOBA to clarify they are season weighted                                      |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
- Confirm this is the right way to calc career wRC and wOBA

*/

WITH final AS(
    SELECT

        player_id
        , SUM(plate_appearances)                    AS "Career Plate Appearances"
        , COUNT("Season")                           AS "Seasons"
        , (SUM("wRC") / COUNT("Season"))            AS "Career wRC Season Weighted"
        , (SUM("wOBA") / COUNT("Season"))           AS "Career wOBA Season Weighted"

    FROM {{ ref("int_player_season_wRC") }}
    GROUP BY player_id
)

SELECT *
FROM final
ORDER BY "Career wRC Season Weighted" DESC