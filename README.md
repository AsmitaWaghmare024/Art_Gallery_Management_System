# 🎨 Art Gallery Management System – Oracle SQL Mini Project

## 📚 Overview
A normalized, secure, and auditable database system to manage art galleries, exhibitions, artists, customers, and painting sales. Implements role-based access, triggers, logging, and reporting views with modular procedures.

## 🏗 Modules Included
| File                         | Purpose                                                |
|-----------------------------|--------------------------------------------------------|
| 01_create_tables.sql        | Master + transactional schema, lifecycle columns      |
| 02_triggers.sql             | Validations, audits, and soft deletes                 |
| 03_functions_procedures.sql | Modular logic with logging                             |
| 04_sample_data.sql          | Seeded data with real-world entities                   |
| 05_test_all.sql             | Full test suite using DBMS_OUTPUT                      |
| 06_views.sql                | Read-only views for UI/reporting                       |
| 07_roles_privileges.sql     | RBAC for admin, artist, and customer users             |
| 08_schema_comments.sql      | Inline documentation for tables, views, and sequences  |

## 💾 Run Order
1. `01_create_tables.sql`
2. `02_triggers.sql`
3. `03_functions_procedures.sql`
4. `04_sample_data.sql`
5. `05_test_all.sql`
6. `06_views.sql`
7. `07_roles_privileges.sql`
8. `08_schema_comments.sql`

## 🔑 Roles & Access
- `gallery_admin`: Full privileges
- `gallery_artist`: Read-only access to painting details
- `gallery_customer`: Limited access to browse and purchase

## ✨ Features
- Soft delete implementation
- Purchase auditing
- Dynamic exhibition revenue summaries
- Validation and error logging
- Predefined demo users: admin_user, artist_001, customer_001

## ✅ Tools Used
- Oracle 11g / 19c
- SQL Developer
- DBMS_OUTPUT / CLOB logs
 
 
