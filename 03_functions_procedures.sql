--Log Error Utility (Reusable Across Modules)
CREATE OR REPLACE PROCEDURE log_error (
  p_module_name   IN VARCHAR2,
  p_error_code    IN NUMBER,
  p_error_message IN VARCHAR2,
  p_user_context  IN VARCHAR2 DEFAULT USER
) IS
BEGIN
  INSERT INTO error_log (
    error_id, module_name, error_code, error_message, user_context
  ) VALUES (
    error_log_seq.NEXTVAL, p_module_name, p_error_code, p_error_message, p_user_context
  );
EXCEPTION
  WHEN OTHERS THEN
    -- Optional: raise again or log internally
    NULL;
END;
/

--Exhibition Summary – Function with Business Logic
CREATE OR REPLACE FUNCTION get_exhibition_summary (
  p_exhibition_id IN NUMBER
) RETURN VARCHAR2 IS
  v_total_exhibited NUMBER := 0;
  v_total_sold      NUMBER := 0;
  v_total_amount    NUMBER := 0;
  v_discounted_amt  NUMBER := 0;
  v_eligible_artist NUMBER := 0;
  v_result          VARCHAR2(4000);
BEGIN
  SELECT COUNT(*) INTO v_total_exhibited
  FROM painting WHERE exhibition_id = p_exhibition_id;

  SELECT COUNT(*), NVL(SUM(amount), 0)
  INTO v_total_sold, v_total_amount
  FROM purchase pu
  JOIN painting p ON pu.painting_id = p.p_id
  WHERE p.exhibition_id = p_exhibition_id;

  SELECT COUNT(*) INTO v_eligible_artist
  FROM (
    SELECT painted_by
    FROM purchase pu
    JOIN painting p ON pu.painting_id = p.p_id
    WHERE p.exhibition_id = p_exhibition_id
    GROUP BY painted_by
    HAVING COUNT(*) > 2
  );

  v_discounted_amt := CASE
    WHEN v_eligible_artist > 0 THEN v_total_amount * 0.95
    ELSE v_total_amount
  END;

  v_result := 'Total Exhibited: ' || v_total_exhibited || CHR(10) ||
              'Total Sold: ' || v_total_sold || CHR(10) ||
              'Discount Applied: ' || CASE WHEN v_eligible_artist > 0 THEN 'Yes (5%)' ELSE 'No' END || CHR(10) ||
              'Final Revenue: ₹' || TO_CHAR(v_discounted_amt, 'FM999G999G999');

  RETURN v_result;

EXCEPTION
  WHEN OTHERS THEN
    log_error('get_exhibition_summary', SQLCODE, SQLERRM);
    RETURN 'Error occurred. See error_log.';
END;
/

--Print-Only Procedure for Exhibition Summary
CREATE OR REPLACE PROCEDURE show_exhibition_summary (
  p_exhibition_id IN NUMBER
) IS
  v_output VARCHAR2(4000);
BEGIN
  v_output := get_exhibition_summary(p_exhibition_id);
  DBMS_OUTPUT.PUT_LINE(v_output);
END;
/

--Find Customers Who Bought from Artist Within Range
CREATE OR REPLACE PROCEDURE custs_by_artist_price_range (
  p_artist_id IN NUMBER
) IS
BEGIN
  FOR rec IN (
    SELECT DISTINCT c.customer_id, c.name
    FROM customer c
    JOIN purchase pu ON c.customer_id = pu.customer_id
    JOIN painting p ON pu.painting_id = p.p_id
    WHERE p.painted_by = p_artist_id
      AND pu.amount BETWEEN 200000 AND 300000
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.name || ' (ID: ' || rec.customer_id || ')');
  END LOOP;

EXCEPTION
  WHEN OTHERS THEN
    log_error('custs_by_artist_price_range', SQLCODE, SQLERRM);
    DBMS_OUTPUT.PUT_LINE('Failed. See error_log.');
END;
/

