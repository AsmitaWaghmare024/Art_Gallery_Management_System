SET SERVEROUTPUT ON;

--Exhibition Summary
BEGIN
  show_exhibition_summary(301);  -- Exhibition ID: Brushstroke Bliss
END;
/

--Customers Who Bought ₹2L–₹3L Paintings from Artist Ravi Varma
BEGIN
  custs_by_artist_price_range(101);  -- Artist ID: Ravi Varma
END;
/

--Count Paintings by Amrita in Year 2023
SELECT count_paintings_by_artist_on_date(102, DATE '2023-09-01') AS artist_paint_count FROM dual;

--View Audit Trail
SELECT * FROM auditing ORDER BY audit_date DESC;

--Error Log Review (Post-Failure or Manual Insert)
SELECT * FROM error_log ORDER BY error_time DESC;

--Validation Log Review
-- Insert bad phone and check log
UPDATE customer SET phone = 'abcd1234' WHERE customer_id = 502;
COMMIT;

SELECT * FROM validation_log ORDER BY log_time DESC;

--Soft Delete a Painting and Audit It
BEGIN
  soft_delete_painting(403);
END;
/

SELECT p_id, title, is_deleted FROM painting WHERE p_id = 403;

--Data Audit Log (Triggered by Soft Delete)
SELECT * FROM data_audit_log ORDER BY change_time DESC;

--Test Views
-- All painting details
SELECT * FROM vw_painting_details;

-- All customer purchases
SELECT * FROM vw_customer_purchases;

-- Summary stats per exhibition
SELECT * FROM vw_exhibition_summary;
