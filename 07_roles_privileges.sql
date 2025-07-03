--Create Roles
CREATE ROLE gallery_admin;
CREATE ROLE gallery_artist;
CREATE ROLE gallery_customer;

--Create Sample Users (Optional for Dev/Test)
CREATE USER admin_user IDENTIFIED BY admin123;
GRANT gallery_admin TO admin_user;

CREATE USER artist_001 IDENTIFIED BY art123;
GRANT gallery_artist TO artist_001;

CREATE USER customer_001 IDENTIFIED BY cust123;
GRANT gallery_customer TO customer_001;

--Grant Role-Based Permissions
--Admin – Full Access
GRANT SELECT, INSERT, UPDATE, DELETE ON artist TO gallery_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON painting TO gallery_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON customer TO gallery_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON purchase TO gallery_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON gallery TO gallery_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON exhibition TO gallery_admin;
GRANT SELECT ON auditing TO gallery_admin;
GRANT SELECT ON error_log TO gallery_admin;
GRANT SELECT ON validation_log TO gallery_admin;
GRANT SELECT ON data_audit_log TO gallery_admin;
GRANT EXECUTE ON log_error TO gallery_admin;
GRANT EXECUTE ON soft_delete_painting TO gallery_admin;
GRANT EXECUTE ON get_exhibition_summary TO gallery_admin;

--Artist – Read-Only View of Their Paintings
GRANT SELECT ON vw_painting_details TO gallery_artist;

-- GRANT EXECUTE ON insert_painting_proc TO gallery_artist;

--Customer – Browse + Purchase
GRANT SELECT ON vw_painting_details TO gallery_customer;
GRANT SELECT ON vw_customer_purchases TO gallery_customer;
GRANT SELECT ON vw_exhibition_summary TO gallery_customer;

GRANT INSERT ON purchase TO gallery_customer;
GRANT EXECUTE ON show_exhibition_summary TO gallery_customer;