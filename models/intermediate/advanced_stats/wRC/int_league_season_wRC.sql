/*

Model:          int_league_season_wRC
Author:         Tom Molitor
Created:        1/7/2025
Last Modified:  1/7/2025

Description: Staging table to create season wRC tables
Source: https://www.fangraphs.com/guts.aspx?type=cn

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/7/2025  | Tom Molitor   | Initalized model and created wRC league stats                                                 |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

*/

SELECT 

    season
    , league_woba
    , league_woba_scale
    , league_wbb
    , league_whbp
    , league_w1b
    , league_w2b
    , league_w3b
    , league_whr
    , league_rpa

FROM {{ ref("stg_season_constants") }}