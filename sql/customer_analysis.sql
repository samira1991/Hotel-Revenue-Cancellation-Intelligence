-- 5th View: customer_analysis
CREATE OR REPLACE VIEW
`project-e52c5edf-28c7-4932-8a2.hotel\\\_analytics.customer\\\_analysis`
AS

SELECT
    country,

    customer_type,

    agent_campany,

    is_repeated_guest,

    COUNT(*) AS total_bookings,

    ROUND(AVG(adr), 2) AS avg_adr,

    ROUND(SUM(estimated_revenue), 2) AS estimated_revenue,

    ROUND(
        SUM(is_canceled) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate

FROM
`project-e52c5edf-28c7-4932-8a2.hotel\\\_analytics.hotel\\\_bookings\\\_cleaned`

GROUP BY
    country,
    customer_type,
    agent_campany,
    is_repeated_guest

5th View:seasonality_analysis
CREATE OR REPLACE VIEW
`project-e52c5edf-28c7-4932-8a2.hotel\\\_analytics.seasonality\\\_analysis`
AS

SELECT
    arrival_date_year,

    arrival_date_month,

    arrival_date_week_number,

    hotel,

    COUNT(*) AS total_bookings,

    ROUND(AVG(adr), 2) AS avg_adr,

    ROUND(SUM(estimated_revenue), 2) AS estimated_revenue,

    ROUND(
        SUM(is_canceled) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate

FROM
`project-e52c5edf-28c7-4932-8a2.hotel\\\_analytics.hotel\\\_bookings\\\_cleaned`

GROUP BY
    arrival_date_year,
    arrival_date_month,
    arrival_date_week_number,
    hotel
