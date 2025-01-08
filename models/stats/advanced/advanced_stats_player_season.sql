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

TODO:


*/

SELECT 
    player_id
    , "Season"
    , "wRC"
    , "wOBA"
FROM {{ ref("int_player_season_wRC") }}