# Group Peer Review Processing Template

## Purpose

This template defines an automated workflow for processing weekly group peer-review data from Excel files.

The model assumes:

- Students belong to **Groups A-H**.
- Each week, groups are paired to review one another.
- Each student in the reviewing group submits one peer-review form.
- Each submission contains the **student ID**, the **reviewing group**, the **reviewed group**, quantitative ratings, and optional qualitative comments.
- The **student ID is the primary key**.
- A separate Excel group list/roster is the authoritative source for student ID, student name, and group membership.

The script produces both:

1. a **group mark report**; and
2. an **individual mark report**.

---

## Core Rules

### 1. Roster is the source of truth

The roster contains at minimum:

| Student ID | Student Name | Group |
|---|---|---|
| 12345678 | Alice Smith | A |
| 12345679 | Bob Jones | A |
| 12345680 | Carol Lee | B |

The roster determines:

- which students exist;
- each student's name;
- each student's group;
- the number of students in each group;
- the expected number of peer-review submissions from each reviewing group.

If a review submission contains a group value that conflicts with the roster, the roster wins and the mismatch is recorded in the validation output.

---

### 2. Student ID is the primary key

Student names are display fields only.

Every review submission must be matched against the roster using the submitting student's **Student ID**.

Unknown student IDs are not counted as valid attendance and are not included in the group mark calculation.

---

### 3. Group pairings

A weekly peer-review pairing follows this pattern:

- Group A reviews Group B
- Group B reviews Group A

The same applies to the other paired groups.

A review file may encode the pairing in either:

- the spreadsheet columns; or
- the filename, for example `GroupA-GroupB.xlsx`.

The first group is the **reviewing group** and the second group is the **reviewed group**.

---

## Quantitative Mark Calculation

Each week may contain a different number of quantitative peer-review questions.

For example:

| Week | Rating Questions |
|---:|---:|
| 1 | 6 |
| 2 | 10 |
| 3 | 8 |
| 4 | 12 |

This does not affect the scoring model because every quantitative question uses the same **1-5 rating scale**.

### Reviewer score

For each valid student submission:

\[
\text{Reviewer Score /5} = \text{mean of all valid 1-5 rating responses in that form}
\]

Example:

- Q1 = 4
- Q2 = 5
- Q3 = 4
- Q4 = 4

Reviewer score:

\[
(4+5+4+4)/4 = 4.25/5
\]

Missing answers are ignored. A submission with no valid quantitative answers does not contribute to the group mean.

---

## Group Mark Calculation

If Group A reviews Group B and Group A contains four students, Group B expects four reviews.

Example:

| Reviewer | Reviewing Group | Reviewed Group | Reviewer Score /5 |
|---|---|---|---:|
| Student 1 | A | B | 4.20 |
| Student 2 | A | B | 4.50 |
| Student 3 | A | B | 4.00 |
| Student 4 | A | B | 4.30 |

Group B receives:

\[
(4.20+4.50+4.00+4.30)/4 = 4.25/5
\]

The final group report is:

| Week | Reviewing Group | Reviewed Group | Reviews Expected | Reviews Received | Mean /5 |
|---:|---|---|---:|---:|---:|
| 4 | Group A | Group B | 4 | 4 | 4.25 |

**Reviews Expected** is derived from the roster size of the reviewing group.

**Reviews Received** is the number of valid submissions that produced a reviewer score.

Missing reviews do not change the calculation formula. The group mean is calculated from the valid reviews actually received.

---

## Attendance Rule

Peer-review submission is also used as weekly attendance evidence.

The rule is:

\[
\text{Valid peer-review submission} \Rightarrow \text{Present}
\]

\[
\text{No valid peer-review submission} \Rightarrow \text{Absent}
\]

A valid submission must:

- contain a Student ID found in the roster;
- correspond to the student's roster group;
- identify a reviewed group;
- contain at least one valid quantitative rating.

---

## Individual Mark Calculation

A student's individual mark is based on the mark received by **their own group**, but only if the student submitted a valid peer review that week.

\[
\text{Individual Mark} =
\begin{cases}
\text{Student's Group Mark}, & \text{if present}\\
0, & \text{if absent}
\end{cases}
\]

Example:

Suppose Group A receives a group mark of **4.40/5**.

| Student ID | Student Name | Group | Attendance | Group Mark /5 | Individual Mark /5 |
|---|---|---|---|---:|---:|
| 12345678 | Alice Smith | A | Present | 4.40 | 4.40 |
| 12345679 | Bob Jones | A | Present | 4.40 | 4.40 |
| 12345680 | Carol Lee | A | Present | 4.40 | 4.40 |
| 12345681 | David Chen | A | Absent | 4.40 | 0.00 |

This separates two concepts:

- the **reviewed group** is assessed by its paired peer group;
- the **individual student** earns that group mark only by participating in the week's peer-review activity.

---

## Qualitative Comments

Qualitative comments are preserved but do **not** affect the mark.

They are used for:

- peer feedback;
- moderation evidence;
- identifying inconsistencies;
- reviewing the quality of peer comments if required later.

The script stores qualitative responses in a separate worksheet.

---

## Recommended Folder Structure

The script supports either a single weekly folder or a parent folder containing multiple weekly folders.

Example:

```text
peer_reviews/
├── Week_01/
│   ├── Group_List.xlsx
│   ├── GroupA-GroupB.xlsx
│   ├── GroupB-GroupA.xlsx
│   ├── GroupC-GroupD.xlsx
│   ├── GroupD-GroupC.xlsx
│   ├── GroupE-GroupF.xlsx
│   ├── GroupF-GroupE.xlsx
│   ├── GroupG-GroupH.xlsx
│   └── GroupH-GroupG.xlsx
├── Week_02/
│   ├── Group_List.xlsx
│   └── ...
└── Week_03/
    ├── Group_List.xlsx
    └── ...
```

The roster filename should contain either `roster`, `group list`, or `group_list` so it can be detected automatically.

---

## Script Usage

Install dependencies once:

```bash
pip install pandas openpyxl
```

Process a single weekly folder:

```bash
python peer_review_processor.py ./Week_04
```

Process a parent folder containing multiple `Week_*` folders:

```bash
python peer_review_processor.py ./peer_reviews
```

Specify a custom output filename:

```bash
python peer_review_processor.py ./peer_reviews --output semester_peer_review_report.xlsx
```

---

## Excel Output

The generated workbook contains:

### Group Marks

| Week | Reviewing Group | Reviewed Group | Reviews Expected | Reviews Received | Mean /5 |
|---:|---|---|---:|---:|---:|

### Individual Marks

| Week | Student ID | Student Name | Group | Attendance | Group Mark /5 | Individual Mark /5 |
|---:|---|---|---|---|---:|---:|

### Attendance

Shows every rostered student and whether a valid review submission was received for that week.

### Individual Reviews

Contains the calculated score for every valid student review submission.

### Qualitative Feedback

Contains all detected written peer-review comments.

### Pairings

Lists the detected reviewing-group to reviewed-group relationship for each week.

### Question Detection

Shows which columns were classified as quantitative ratings and qualitative questions in each review file.

### Validation

Records issues such as:

- unknown Student ID;
- submitted group differing from roster group;
- invalid group value;
- no quantitative rating detected;
- duplicate submissions from the same student for the same pairing.

Validation records do not silently alter marks. They make data-quality issues visible.

---

## Design Principles

- **Student ID is the primary key.**
- **Roster data overrides submitted identity/group data.**
- **Groups A-H only.**
- **Different numbers of questions per week are supported.**
- **Quantitative ratings determine the group mark.**
- **Qualitative feedback never changes the mark.**
- **Attendance is derived from valid peer-review submission.**
- **Absent students receive 0/5 individually.**
- **No min, max, spread, variance, or moderation flag affects the calculation.**
- **The process is reproducible and auditable from the generated Excel workbook.**
