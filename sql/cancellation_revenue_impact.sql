-- View:cancellation_revenue_impact
CREATE OR REPLACE VIEW
`project-e52c5edf-28c7-4932-8a2.hotel\_analytics.cancellation\_revenue\_impact`
AS

SELECT
    hotel,

    arrival_date_year,

    arrival_date_month,

    market_segment,

    customer_type,

    deposit_type,

    CASE
        WHEN lead_time <= 30 THEN '0-30 Days'
        WHEN lead_time <= 90 THEN '31-90 Days'
        WHEN lead_time <= 180 THEN '91-180 Days'
        WHEN lead_time <= 365 THEN '181-365 Days'
        ELSE '365+ Days'
    END AS lead_time_category,

    COUNT(*) AS canceled_bookings,

    ROUND(
        SUM(adr * total_nights),
        2
    ) AS lost_revenue,

    ROUND(AVG(adr), 2) AS avg_adr,

    ROUND(AVG(total_nights), 2) AS avg_stay_duration

FROM
`project-e52c5edf-28c7-4932-8a2.hotel\_analytics.hotel\_bookings\_cleaned`

WHERE is_canceled = 1

GROUP BY
    hotel,
    arrival_date_year,
    arrival_date_month,
    market_segment,
    customer_type,
    deposit_type,
    lead_time_category

View: revenue_loss_analysis (percentage)
CREATE OR REPLACE VIEW
`project-e52c5edf-28c7-4932-8a2.hotel\_analytics.revenue\_loss\_analysis`
AS

SELECT
    hotel,

    ROUND(
        SUM(estimated_revenue),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            CASE
                WHEN is_canceled = 1
                THEN estimated_revenue
                ELSE 0
            END
        ),
        2
    ) AS lost_revenue,

    ROUND(
        (
            SUM(
                CASE
                    WHEN is_canceled = 1
                    THEN estimated_revenue
                    ELSE 0
                END
            ) * 100.0
        ) / SUM(estimated_revenue),
        2
    ) AS loss_rate

FROM
`project-e52c5edf-28c7-4932-8a2.hotel\_analytics.hotel\_bookings\_cleaned`

GROUP BY
    hotel
