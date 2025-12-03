/* Query 1: Cleaning and Event Ordering
The goal is to filter for the relevant events (view, cart, purchase) 
and order them by session time. */
CREATE TABLE funnel_events AS
SELECT
    user_id,
    user_session,
    event_time,
    event_type,
    -- Assigns a sequence number (1, 2, 3...) to events within each user_session
    ROW_NUMBER() OVER (
        PARTITION BY user_session
        ORDER BY event_time
    ) AS event_sequence
FROM
    raw_user_events
WHERE
    event_type IN ('view', 'cart', 'purchase')
    AND user_id IS NOT NULL;

/* Query 2: Calculate Conversion Counts
This query counts the unique users who completed each major stage 
and saves the final output table. */
CREATE TABLE funnel_user_counts AS
SELECT
    'View Product' AS stage,
    COUNT(DISTINCT user_id) AS unique_users
FROM funnel_events
WHERE event_type = 'view'

UNION ALL

SELECT
    'Add to Cart' AS stage,
    COUNT(DISTINCT user_id) AS unique_users
FROM funnel_events
WHERE event_type = 'cart'

UNION ALL

SELECT
    'Purchase' AS stage,
    COUNT(DISTINCT user_id) AS unique_users
FROM funnel_events
WHERE event_type = 'purchase';

/* Deeper Dive Analysis: Segmenting the Bottleneck
SQL Analysis: Brand Performance
The goal is to calculate the View Product --> Add to Cart (VC) 
Conversion Rate for every brand in our raw_user_events table. */
-- Create a new table to store the brand-level performance results
CREATE TABLE brand_vc_performance AS
WITH Brand_Views AS (
    -- CTE 1: Count unique users who viewed a product, segmented by brand
    SELECT
        brand,
        COUNT(DISTINCT user_id) AS total_viewers
    FROM raw_user_events
    WHERE event_type = 'view'
      AND brand IS NOT NULL
    GROUP BY 1
),
Brand_Carts AS (
    -- CTE 2: Count unique users who added to cart, segmented by brand
    SELECT
        brand,
        COUNT(DISTINCT user_id) AS total_cart_adders
    FROM raw_user_events
    WHERE event_type = 'cart'
      AND brand IS NOT NULL
    GROUP BY 1
)
SELECT
    v.brand,
    v.total_viewers,
    -- Use COALESCE to handle cases where a brand has views but zero carts
    COALESCE(c.total_cart_adders, 0) AS total_cart_adders,
    -- Calculate V->C conversion rate (Carts / Views) * 100
    (CAST(COALESCE(c.total_cart_adders, 0) AS NUMERIC) / v.total_viewers) * 100 AS vc_conversion_rate_pct
FROM
    Brand_Views v
LEFT JOIN
    Brand_Carts c ON v.brand = c.brand
WHERE
    v.total_viewers > 1000 -- -- Ensures we only analyze brands with a meaningful number of views
ORDER BY
    vc_conversion_rate_pct ASC;