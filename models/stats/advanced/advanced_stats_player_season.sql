/*

Model:          advanced_stats_player_season
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
| 1/7/2025  | Tom Molitor   | Initalized model and imported wRC and wOBA player stats                                       |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/9/2025  | Tom Molitor   | Pivoted data to be vertical. Set model to be materialized as a table                          |
+-----------+---------------+-----------------------------------------------------------------------------------------------+


TODO:


*/


WITH wRC AS (
    SELECT player_id
    , "Season" AS season
    , 'wRC' AS metric
    , "wRC" AS value
    FROM {{ ref('int_player_season_wRC') }}
)

, wOBA AS (
    SELECT player_id
    , "Season" AS season
    , 'wOBA' AS metric
    , "wOBA" AS value
    FROM {{ ref('int_player_season_wOBA') }}
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