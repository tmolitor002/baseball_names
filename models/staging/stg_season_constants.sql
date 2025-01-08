/*

Model:          stg_season_constants
Author:         Tom Molitor
Created:        1/6/2025
Last Modified:  1/7/2025

Description: Staging table to bring in season constants for futher analysis
Source: https://www.fangraphs.com/guts.aspx?type=cn

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/6/2025  | Tom Molitor   | Initalized model                                                                              |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/7/2025  | Tom Molitor   | Cast fields as appropriate data type. Reorganized some fields for better readability          |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

*/

SELECT 

    season
    , CAST(woba         AS FLOAT) AS league_woba
    , CAST(wobascale    AS FLOAT) AS league_woba_scale
    , CAST(wbb          AS FLOAT) AS league_wbb
    , CAST(whbp         AS FLOAT) AS league_whbp
    , CAST(w1b          AS FLOAT) AS league_w1b
    , CAST(w2b          AS FLOAT) as league_w2b
    , CAST(w3b          AS FLOAT) AS league_w3b
    , CAST(whr          AS FLOAT) AS league_whr
    , CAST(runsb        AS FLOAT) AS league_run_sb
    , CAST(runcs        AS FLOAT) AS league_run_cs
    , CAST(rpa          AS FLOAT) AS league_rpa
    , CAST(rw           AS FLOAT) AS league_rw
    , CAST(cfip         AS FLOAT) AS league_cfip

FROM {{ source('baseball', 'season_constants') }}