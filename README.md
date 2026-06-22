# School Fee Database System

A MySQL relational database system for managing school fees, student records, and payment tracking.

## Project Structure

```
School-Fee-DataBase-System/
│
├── database/
│   └── schema.sql       # Database schema and table definitions
│
└── README.md
```

## ER Diagram

```mermaid
erDiagram
    teachers {
        int teacher_id PK
        varchar teacher_name
        varchar subject
        varchar phone
        varchar class_incharge
    }

    academic_years {
        int year_id PK
        varchar year_name
        date start_date
        date end_date
        varchar is_current
    }

    classes {
        int class_id PK
        varchar class_name
        varchar section
        int teacher_id FK
        int total_students
    }

    students {
        int student_id PK
        varchar student_name
        varchar class
        varchar section
        varchar gender
        varchar phone
        varchar city
        date join_date
    }

    parents {
        int parent_id PK
        int student_id FK
        varchar parent_name
        varchar relation
        varchar phone
        varchar email
    }

    fee_category {
        int category_id PK
        varchar category_name
        varchar description
    }

    fee_structure {
        int fee_id PK
        varchar class
        int category_id FK
        decimal amount
        varchar academic_year
    }

    due_dates {
        int due_id PK
        int fee_id FK
        varchar term
        date due_date
        decimal penalty_per_day
    }

    payments {
        int payment_id PK
        int student_id FK
        int fee_id FK
        decimal amount_paid
        date payment_date
        varchar payment_mode
        varchar receipt_no
    }

    receipts {
        int receipt_id PK
        int payment_id FK
        date issued_date
        varchar issued_by
    }

    discounts {
        int discount_id PK
        int student_id FK
        varchar discount_type
        decimal discount_amt
        varchar academic_year
    }

    complaints {
        int complaint_id PK
        int student_id FK
        varchar complaint_msg
        date raised_date
        varchar status
    }

    penalty_log {
        int penalty_id PK
        int payment_id FK
        int student_id FK
        int days_late
        decimal penalty_amt
        date logged_date
    }

    monthly_summary {
        int summary_id PK
        varchar month_year
        decimal total_collected
        int total_students
        date created_at
    }

    transport {
        int transport_id PK
        int student_id FK
        varchar route_name
        varchar pickup_point
        varchar bus_no
    }

    teachers ||--o{ classes : "incharges"
    classes ||--o{ students : "enrolled in"
    students ||--o{ parents : "has"
    students ||--o{ payments : "makes"
    students ||--o{ discounts : "avails"
    students ||--o{ complaints : "raises"
    students ||--o{ penalty_log : "incurs"
    students ||--o{ transport : "uses"
    fee_category ||--o{ fee_structure : "categorizes"
    fee_structure ||--o{ due_dates : "has"
    fee_structure ||--o{ payments : "for"
    payments ||--o{ receipts : "generates"
    payments ||--o{ penalty_log : "logs"
```

## Tables (15)

| # | Table | Description |
|---|-------|-------------|
| 1 | academic_years | Academic year references (e.g. 2024-25) |
| 2 | teachers | Teacher details and class in-charge assignments |
| 3 | classes | Class sections with teacher assignments |
| 4 | students | Student personal and enrollment info |
| 5 | parents | Parent/guardian contact details linked to students |
| 6 | fee_category | Fee types (Tuition, Transport, Library, etc.) |
| 7 | fee_structure | Fee amounts per class and category per year |
| 8 | due_dates | Payment due dates and penalty per day per fee |
| 9 | payments | Fee payment records |
| 10 | receipts | Receipt issuance records |
| 11 | discounts | Student-specific discounts (scholarships, quotas) |
| 12 | complaints | Student fee complaints and resolution status |
| 13 | penalty_log | Late payment penalty tracking |
| 14 | monthly_summary | Aggregated monthly collection stats |
| 15 | transport | Student bus route and pickup assignments |

## Getting Started

1. Run `database/schema.sql` against your MySQL server.
2. The database `school_fee_db` will be created with all 15 tables.
3. Insert reference data first: `academic_years`, `teachers`, `fee_category`, then dependent data.
