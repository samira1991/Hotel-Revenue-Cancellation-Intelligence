-- Third View: revenue_analysis
CREATE OR REPLACE VIEW
`project-e52c5edf-28c7-4932-8a2.hotel\\\_analytics.revenue\\\_analysis`
AS

SELECT
    hotel,

    arrival_date_year,

    arrival_date_month,

    market_segment,

    customer_type,

    COUNT(*) AS total_bookings,

    ROUND(SUM(estimated_revenue), 2) AS estimated_revenue,

    ROUND(AVG(adr), 2) AS avg_adr,

    ROUND(AVG(total_nights), 2) AS avg_stay_duration

FROM
`project-e52c5edf-28c7-4932-8a2.hotel\\\_analytics.hotel\\\_bookings\\\_cleaned`

WHERE is_canceled = 0

GROUP BY
    hotel,
    arrival_date_year,
    arrival_date_month,
    market_segment,
    customer_type
