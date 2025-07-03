--vw_painting_details – Full Painting Showcase
CREATE OR REPLACE VIEW vw_painting_details AS
SELECT
  p.p_id AS painting_id,
  p.title,
  pt.type_name AS painting_type,
  a.name AS artist_name,
  e.name AS exhibition_name,
  g.name AS gallery_name,
  g.location AS gallery_location,
  p.price,
  p.likes_pct,
  p.sold_flag
FROM painting p
JOIN painting_type pt ON p.type_id = pt.type_id
JOIN artist a ON p.painted_by = a.artist_id
JOIN exhibition e ON p.exhibition_id = e.e_id
JOIN gallery g ON e.gallery_id = g.gallery_id
WHERE p.is_deleted = 'N';

--vw_customer_purchases – Who Bought What & From Whom
CREATE OR REPLACE VIEW vw_customer_purchases AS
SELECT
  c.customer_id,
  c.name AS customer_name,
  a.name AS artist_name,
  p.title AS painting_title,
  pu.amount,
  pu.purchase_date
FROM purchase pu
JOIN customer c ON pu.customer_id = c.customer_id
JOIN painting p ON pu.painting_id = p.p_id
JOIN artist a ON p.painted_by = a.artist_id
WHERE c.is_deleted = 'N' AND p.is_deleted = 'N';

--vw_exhibition_summary – Exhibition Stats at a Glance
CREATE OR REPLACE VIEW vw_exhibition_summary AS
SELECT
  e.e_id AS exhibition_id,
  e.name AS exhibition_name,
  g.name AS gallery_name,
  COUNT(p.p_id) AS total_paintings,
  SUM(CASE WHEN p.sold_flag = 'Y' THEN 1 ELSE 0 END) AS sold_paintings
FROM exhibition e
JOIN gallery g ON e.gallery_id = g.gallery_id
LEFT JOIN painting p ON e.e_id = p.exhibition_id AND p.is_deleted = 'N'
GROUP BY e.e_id, e.name, g.name;