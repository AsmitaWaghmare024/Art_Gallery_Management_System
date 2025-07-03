-- 🎨 Painting Types (Master)
CREATE TABLE painting_type (
  type_id NUMBER PRIMARY KEY,
  type_name VARCHAR2(100) NOT NULL UNIQUE
);

-- 🖼 Exhibition Types (Master)
CREATE TABLE exhibition_type (
  type_id NUMBER PRIMARY KEY,
  type_name VARCHAR2(100) NOT NULL UNIQUE
);

-- 👩‍🎨 Artist Master Table
CREATE TABLE artist (
  artist_id NUMBER PRIMARY KEY,
  name VARCHAR2(100) NOT NULL,
  address VARCHAR2(200) NOT NULL,
  phone VARCHAR2(20) NOT NULL CHECK (REGEXP_LIKE(phone, '^\d{10}$')),
  created_at DATE DEFAULT SYSDATE,
  updated_at DATE,
  is_deleted CHAR(1) DEFAULT 'N' CHECK (is_deleted IN ('Y','N'))
);

-- 🏛 Gallery Table
CREATE TABLE gallery (
  gallery_id NUMBER PRIMARY KEY,
  name VARCHAR2(100) NOT NULL,
  location VARCHAR2(100) NOT NULL,
  created_at DATE DEFAULT SYSDATE,
  updated_at DATE
);

-- 🖼 Exhibition Table
CREATE TABLE exhibition (
  e_id NUMBER PRIMARY KEY,
  name VARCHAR2(100) NOT NULL,
  location VARCHAR2(100) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  gallery_id NUMBER NOT NULL REFERENCES gallery(gallery_id),
  type_id NUMBER NOT NULL REFERENCES exhibition_type(type_id),
  created_at DATE DEFAULT SYSDATE,
  updated_at DATE
);

-- 🖌 Painting Table
CREATE TABLE painting (
  p_id NUMBER PRIMARY KEY,
  title VARCHAR2(200) NOT NULL,
  year NUMBER NOT NULL,
  type_id NUMBER NOT NULL REFERENCES painting_type(type_id),
  painted_by NUMBER NOT NULL REFERENCES artist(artist_id),
  price NUMBER NOT NULL CHECK (price >= 0),
  likes_pct NUMBER NOT NULL CHECK (likes_pct BETWEEN 0 AND 100),
  exhibition_id NUMBER NOT NULL REFERENCES exhibition(e_id),
  sold_flag CHAR(1) DEFAULT 'N' NOT NULL CHECK (sold_flag IN ('Y','N')),
  is_deleted CHAR(1) DEFAULT 'N' NOT NULL CHECK (is_deleted IN ('Y','N')),
  created_at DATE DEFAULT SYSDATE,
  updated_at DATE
);

-- 👥 Customer Table
CREATE TABLE customer (
  customer_id NUMBER PRIMARY KEY,
  name VARCHAR2(100) NOT NULL,
  phone VARCHAR2(20) NOT NULL CHECK (REGEXP_LIKE(phone, '^\d{10}$')),
  address VARCHAR2(200) NOT NULL,
  is_deleted CHAR(1) DEFAULT 'N' NOT NULL CHECK (is_deleted IN ('Y','N')),
  created_at DATE DEFAULT SYSDATE,
  updated_at DATE
);

-- 💰 Purchase Transactions
CREATE TABLE purchase (
  purchase_id NUMBER PRIMARY KEY,
  customer_id NUMBER NOT NULL REFERENCES customer(customer_id) ON DELETE CASCADE,
  painting_id NUMBER NOT NULL REFERENCES painting(p_id) ON DELETE CASCADE,
  purchase_date DATE DEFAULT SYSDATE NOT NULL,
  amount NUMBER NOT NULL
);

-- 🧾 Auditing Table
CREATE TABLE auditing (
  audit_id NUMBER PRIMARY KEY,
  purchase_id NUMBER NOT NULL REFERENCES purchase(purchase_id) ON DELETE CASCADE,
  transaction_type VARCHAR2(20) NOT NULL,
  amount NUMBER NOT NULL,
  audit_date DATE DEFAULT SYSDATE NOT NULL
);

-- ❗ Error Log Table
CREATE TABLE error_log (
  error_id NUMBER PRIMARY KEY,
  module_name VARCHAR2(100),
  error_code NUMBER,
  error_message VARCHAR2(4000),
  error_time DATE DEFAULT SYSDATE,
  user_context VARCHAR2(100)
);

-- ⚠️ Validation Log Table
CREATE TABLE validation_log (
  log_id NUMBER PRIMARY KEY,
  table_name VARCHAR2(100),
  column_name VARCHAR2(100),
  invalid_value VARCHAR2(500),
  reason VARCHAR2(200),
  log_time DATE DEFAULT SYSDATE,
  user_context VARCHAR2(100)
);

-- 📚 Data Audit Log Table
CREATE TABLE data_audit_log (
  audit_id NUMBER PRIMARY KEY,
  table_name VARCHAR2(100),
  operation VARCHAR2(10),
  record_key VARCHAR2(100),
  changed_data CLOB,
  change_time DATE DEFAULT SYSDATE,
  changed_by VARCHAR2(100)
);

CREATE SEQUENCE audit_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE data_audit_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE error_log_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE validation_log_seq START WITH 1 INCREMENT BY 1;
