/*

Model:          int_player_career_ops_plus
Author:         Tom Molitor
Created:        1/10/2025
Last Modified:  1/10/2025

Description: Staging table to create player career ops plus tables

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/10/2025 | Tom Molitor   | Initalized model and created ops plus player stats                                               |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:

*/

WITH player_ops_calc_1 AS (
    SELECT
        player_id
        , SUM(ops_plus) AS sum_ops_plus
        , COUNT(season) AS seasons
    FROM {{ ref('int_player_season_ops_plus') }}
    GROUP BY player_id
)

, final AS (
    SELECT player_id
        , ( sum_ops_plus / seasons ) AS ops_plus
    FROM player_ops_calc_1
)

SELECT *
FROM final