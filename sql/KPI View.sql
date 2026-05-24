-- First View: KPIs
CREATE OR REPLACE VIEW
`project-e52c5edf-28c7-4932-8a2.hotel\\\_analytics.booking\\\_kpis`
AS

SELECT
    COUNT(*) AS total_bookings,

    SUM(is_canceled) AS canceled_bookings,

    ROUND(
        SUM(is_canceled) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate,

    ROUND(AVG(adr),2) AS avg_daily_rate,

    ROUND(SUM(estimated_revenue),2) AS total_revenue,

    ROUND(AVG(total_nights),2) AS avg_stay_duration

FROM
`project-e52c5edf-28c7-4932-8a2.hotel\\\_analytics.hotel\\\_bookings\\\_cleaned`

