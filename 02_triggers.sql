--Logs every new purchase into the auditing table
CREATE OR REPLACE TRIGGER trg_audit_purchase
AFTER INSERT ON purchase
FOR EACH ROW
BEGIN
  INSERT INTO auditing (audit_id, purchase_id, transaction_type, amount)
  VALUES (
    audit_seq.NEXTVAL,
    :NEW.purchase_id,
    'Bought',
    :NEW.amount
  );
END;
/

--Customer Phone Validation Trigger
CREATE OR REPLACE TRIGGER trg_validate_customer_phone
BEFORE INSERT OR UPDATE ON customer
FOR EACH ROW
BEGIN
  IF NOT REGEXP_LIKE(:NEW.phone, '^\d{10}$') THEN
    INSERT INTO validation_log (
      log_id, table_name, column_name, invalid_value, reason, user_context
    ) VALUES (
      validation_log_seq.NEXTVAL,
      'customer', 'phone', :NEW.phone,
      'Phone must be exactly 10 numeric digits', USER
    );
  END IF;
END;
/

--Painting Validation Trigger
CREATE OR REPLACE TRIGGER trg_validate_painting
BEFORE INSERT OR UPDATE ON painting
FOR EACH ROW
BEGIN
  IF :NEW.price < 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Price must be non-negative');
  END IF;

  IF :NEW.likes_pct < 0 OR :NEW.likes_pct > 100 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Likes % must be between 0 and 100');
  END IF;
END;
/

--Soft Delete Logging for Painting
CREATE OR REPLACE PROCEDURE soft_delete_painting(p_id IN NUMBER) IS
BEGIN
  UPDATE painting
  SET is_deleted = 'Y'
  WHERE p_id = p_id;

  INSERT INTO data_audit_log (
    audit_id, table_name, operation, record_key, changed_data, changed_by
  ) VALUES (
    data_audit_seq.NEXTVAL,
    'painting', 'DELETE',
    'p_id=' || p_id,
    'Soft delete issued by user',
    USER
  );
END;
/