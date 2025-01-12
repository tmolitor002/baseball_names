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
| 1/10/2025 | Tom Molitor   | Added babip and iso                                                                           |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
- Add On-base Plus Slugging (OPS+): https://www.mlb.com/glossary/advanced-stats/on-base-plus-slugging-plus
*/

WITH wRC AS (
    SELECT player_id
    , 'wRC' AS metric
    , career_wRC_season_weighted AS value
    FROM {{ ref('int_player_career_wRC') }}
)

, wOBA AS (
    SELECT player_id
    , 'wOBA' AS metric
    , career_wOBA_season_weighted AS value
    FROM {{ ref('int_player_career_wOBA') }}
)
, babip AS (
    SELECT player_id
        , 'BABIP' AS metric
        , babip AS value
    FROM {{ ref('int_player_career_babip') }}
)

, iso AS (
    SELECT player_id
        , 'ISO' AS metric
        , isolated_power AS value
    FROM {{ ref('stg_player_career_offense') }}
    WHERE plate_appearances > 0
    AND isolated_power IS NOT NULL
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
    UNION
    SELECT *
    FROM iso
)

SELECT *
FROM final

SELECT *
FROM {{ ref('stg_season_constants') }}