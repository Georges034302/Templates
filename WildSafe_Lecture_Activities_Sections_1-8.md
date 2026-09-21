# WildSafe SQL Investigation — Sections 1–8

## Section 1 — WildSafe Crisis
**Mode:** Instructor-led

- Introduce WildSafe Australia and rogue hacker **K4NG4**.
- Explain that some data may have been manipulated.
- Students must use SQL evidence to decide whether claims are **true, false, misleading, or unsupported**.

---

## Section 2 — Database + Cloud
**Mode:** Instructor-led

Explain:

```text
Application → Database → Persistent Data
```

and:

```text
AWS RDS → PostgreSQL → wild-safe → Schemas → Tables
```

Key point: the database keeps data after the application stops and allows everyone to work on the same shared dataset.

---

## Section 3 — Connect + First SQL
**Mode:** Instructor-led

Connect:

```bash
psql -h wild-safe.carmelisrww3.ap-southeast-2.rds.amazonaws.com -p 5432 -U postgres -d "wild-safe"
```

Show schemas:

```sql
\dn
```

Show tables:

```sql
\dt wildsafe_sane.*
\dt wildsafe_corrupted.*
```

First query:

```sql
SELECT *
FROM wildsafe_sane.animal_rescues
LIMIT 10;
```

Filtered query:

```sql
SELECT *
FROM wildsafe_sane.animal_rescues
WHERE rescue_cost > 1000
ORDER BY rescue_cost DESC
LIMIT 10;
```

---

# Section 4 — Breakout 1: SQL Investigation

## Team Instructions

Each team must answer the investigation questions using SQL and report the result.

### Task 1 — Most expensive rescues

```sql
SELECT *
FROM wildsafe_sane.animal_rescues
ORDER BY rescue_cost DESC
LIMIT 10;
```

### Task 2 — Released animals costing more than $1,000

```sql
SELECT *
FROM wildsafe_sane.animal_rescues
WHERE rescue_cost > 1000
  AND status = 'Released'
ORDER BY rescue_cost DESC;
```

### Task 3 — Search by animal type

```sql
SELECT *
FROM wildsafe_sane.animal_rescues
WHERE species = 'Koala'
ORDER BY rescue_date;
```

**Team output:** SQL + result + one-sentence conclusion.

---

# Section 5 — Breakout 2: SQL Battle Royale

## Team Instructions

Teams compete to solve each SQL challenge correctly.

### Challenge 1 — Top 5 highest rescue costs

```sql
SELECT *
FROM wildsafe_corrupted.animal_rescues
ORDER BY rescue_cost DESC
LIMIT 5;
```

### Challenge 2 — Koalas with high rescue costs

```sql
SELECT *
FROM wildsafe_corrupted.animal_rescues
WHERE species = 'Koala'
  AND rescue_cost > 1000
ORDER BY rescue_cost DESC;
```

### Challenge 3 — Released cases only

```sql
SELECT *
FROM wildsafe_corrupted.animal_rescues
WHERE status = 'Released'
ORDER BY rescue_date DESC;
```

**Rule:** Correct SQL and correct explanation matter more than speed.

---

# Section 6 — Breakout 3: Red Team vs Blue Team

## Red Team Instructions

1. Select the exact records you intend to change.
2. Confirm the rows.
3. Run the matching `UPDATE`.
4. Record what you changed.
5. Do not tell the Blue Team.

### Red Team Example

Check first:

```sql
SELECT *
FROM wildsafe_corrupted.animal_rescues
WHERE rescue_cost < 300;
```

Then sabotage:

```sql
UPDATE wildsafe_corrupted.animal_rescues
SET rescue_cost = rescue_cost + 500
WHERE rescue_cost < 300;
```

Check the changed rows:

```sql
SELECT *
FROM wildsafe_corrupted.animal_rescues
WHERE rescue_cost BETWEEN 500 AND 800
ORDER BY rescue_cost DESC;
```

### Safety Rule

```text
SELECT before UPDATE
```

Never run:

```sql
UPDATE wildsafe_corrupted.animal_rescues
SET rescue_cost = rescue_cost + 500;
```

because it changes every row.

## Blue Team Instructions

Investigate the corrupted data and identify suspicious changes.

Start with:

```sql
SELECT *
FROM wildsafe_corrupted.animal_rescues
ORDER BY rescue_cost DESC
LIMIT 20;
```

Then compare suspicious values against the clean data:

```sql
SELECT *
FROM wildsafe_sane.animal_rescues
ORDER BY rescue_cost DESC
LIMIT 20;
```

**Blue Team output:**
- suspected manipulation
- affected records
- SQL evidence

---

# Section 7 — Breakout 4: K4NG4 Claims + Data Quality

## Team Instructions

Each team investigates K4NG4's claims using SQL.

View claims:

```sql
SELECT *
FROM wildsafe_corrupted.k4ng4_claims;
```

### Claim 1 — Rescue cost above $8,000

```sql
SELECT *
FROM wildsafe_corrupted.animal_rescues
WHERE rescue_cost > 8000
ORDER BY rescue_cost DESC;
```

### Claim 4 — Koalas above 70 kg

```sql
SELECT *
FROM wildsafe_corrupted.animal_rescues
WHERE species = 'Koala'
  AND weight_kg > 70
ORDER BY weight_kg DESC;
```

### Claim 6 — Is Released common?

```sql
SELECT status, COUNT(*) AS total
FROM wildsafe_corrupted.animal_rescues
GROUP BY status
ORDER BY total DESC;
```

### Claim 7 — Missing data

```sql
SELECT *
FROM wildsafe_corrupted.animal_rescues
WHERE species IS NULL
   OR rescue_cost IS NULL
   OR status IS NULL;
```

**Team output:** claim + SQL + result + conclusion.

---

# Section 8 — Breakout 5: JOIN Investigation + Press Conference

## Team Instructions

Join rescue records with rescue centres and prepare one final evidence-based finding.

### JOIN

```sql
SELECT
    a.rescue_id,
    a.species,
    a.rescue_cost,
    a.status,
    c.centre_name,
    c.city,
    c.state
FROM wildsafe_corrupted.animal_rescues a
INNER JOIN wildsafe_corrupted.rescue_centres c
    ON a.centre_id = c.centre_id
ORDER BY a.rescue_cost DESC;
```

### Find expensive rescues and their centres

```sql
SELECT
    a.rescue_id,
    a.species,
    a.rescue_cost,
    c.centre_name,
    c.state
FROM wildsafe_corrupted.animal_rescues a
INNER JOIN wildsafe_corrupted.rescue_centres c
    ON a.centre_id = c.centre_id
WHERE a.rescue_cost > 1000
ORDER BY a.rescue_cost DESC;
```

## Press Conference

Each team presents:

- one suspicious finding
- the SQL query
- the result
- whether the related K4NG4 claim is true, false, misleading, or unsupported

Use:

```text
"The query shows..."
```

not:

```text
"I think..."
```

---

# Session Flow

```text
1. Crisis
2. Database + Cloud
3. Connect + SQL Demo
4. SQL Investigation
5. Battle Royale
6. Red Team vs Blue Team
7. K4NG4 Claims
8. JOIN + Press Conference
```
