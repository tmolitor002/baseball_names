/*

Model:          advanced_stats_player_season
Author:         Tom Molitor
Created:        1/7/2025
Last Modified:  1/11/2025

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
| 1/10/2025 | Tom Molitor   | Added babip and iso to advanced stats                                                         |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/11/2025 | Tom Molitor   | Added ops+ to advanced stats                                                                  |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
- Add additional advanced stats

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

, babip AS (
    SELECT player_id
    , season
    , 'BABIP' AS metric
    , babip AS value
    FROM {{ ref('int_player_season_babip') }}
)

, iso AS (
    SELECT
        player_id
        , season
        , 'ISO' AS metric
        , isolated_power AS value
    FROM {{ ref('stg_player_season_league_offense') }}
    WHERE plate_appearances > 0
    AND isolated_power IS NOT NULL
)

, ops_plus AS (
    SELECT player_id
    , season
    , 'OPS Plus' AS metric
    , ops_plus AS value
    FROM {{ ref('int_player_season_ops_plus') }}
    WHERE ops_plus IS NOT NULL
)

, final AS (
    SELECT *
    FROM wRC
    UNION
    SELECT *
    FROM wOBA
    UNION
    SELECT *
    FROM babip
    UNION SELECT *
    FROM iso
    UNION SELECT *
    FROM ops_plus
)

SELECT *
FROM final