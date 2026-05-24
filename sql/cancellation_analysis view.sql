-- Second View: cancellation_analysis
CREATE OR REPLACE VIEW
`project-e52c5edf-28c7-4932-8a2.hotel\\\_analytics.cancellation\\\_analysis`
AS

SELECT
    hotel,

    market_segment,

    deposit_type,

    customer_type,

    agent_campany,

    CASE
        WHEN lead_time <= 30 THEN '0-30 Days'
        WHEN lead_time <= 90 THEN '31-90 Days'
        WHEN lead_time <= 180 THEN '91-180 Days'
        WHEN lead_time <= 365 THEN '181-365 Days'
        ELSE '365+ Days'
    END AS lead_time_category,

    COUNT(*) AS total_bookings,

    SUM(is_canceled) AS canceled_bookings,

    ROUND(
        SUM(is_canceled) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate,

    ROUND(AVG(adr), 2) AS avg_adr,

    ROUND(AVG(total_nights), 2) AS avg_stay_duration

FROM
`project-e52c5edf-28c7-4932-8a2.hotel\\\_analytics.hotel\\\_bookings\\\_cleaned`

GROUP BY
    hotel,
    market_segment,
    deposit_type,
    customer_type,
    agent_campany,
    lead_time_category
