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
    classes {
        int class_id PK
        varchar class_name
        varchar section
        varchar academic_year
    }

    students {
        int student_id PK
        varchar first_name
        varchar last_name
        date date_of_birth
        enum gender
        text address
        varchar phone
        varchar email
        int class_id FK
        date enrollment_date
        enum status
        timestamp created_at
        timestamp updated_at
    }

    fee_structure {
        int fee_id PK
        varchar fee_name
        int class_id FK
        decimal amount
        date due_date
        enum fee_type
        varchar academic_year
        timestamp created_at
    }

    fee_payments {
        int payment_id PK
        int student_id FK
        int fee_id FK
        decimal amount_paid
        date payment_date
        enum payment_mode
        varchar transaction_id
        varchar receipt_number
        text remarks
        timestamp created_at
    }

    late_fee_rules {
        int rule_id PK
        int fee_id FK
        int days_after_due
        decimal late_fee_amount
    }

    classes ||--o{ students : "has"
    classes ||--o{ fee_structure : "defines"
    fee_structure ||--o{ fee_payments : "tracks"
    students ||--o{ fee_payments : "makes"
    fee_structure ||--o{ late_fee_rules : "applies"
```

## Database Schema

### Tables
- **classes** - Class and section management per academic year
- **students** - Student personal and enrollment details
- **fee_structure** - Fee types and amounts per class and academic year
- **fee_payments** - Payment records with transaction details
- **late_fee_rules** - Late payment penalty rules

## Getting Started

1. Run `database/schema.sql` against your MySQL server.
2. The database `school_fee_db` will be created with all tables.
3. Insert class data first, then students, fee structure, and records.
