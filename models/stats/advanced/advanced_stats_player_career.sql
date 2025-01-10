/*

Model:          advanced_stats_player_career
Author:         Tom Molitor
Created:        1/9/2025
Last Modified:  1/9/2025

Description: Final tables for player career advanced stats
Source: https://www.fangraphs.com/guts.aspx?type=cn

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/9/2025  | Tom Molitor   | Initalized model and imported wRC and wOBA player stats                                       |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:

*/

WITH wRC AS (
    SELECT player_id
    , 'wRC' AS metric
    , "wRC" AS value
    FROM {{ ref('int_player_career_wRC') }}
)

, wOBA AS (
    SELECT player_id
    , 'wOBA' AS metric
    , "wOBA" AS value
    FROM {{ ref('int_player_career_wOBA') }}
)

, final AS (
    SELECT *
    FROM wRC
    UNION
    SELECT *
    FROM wOBA
)

SELECT *
FROM final