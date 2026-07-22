# AWK & SED CLI Reference – `blackwood_assets.csv`

```csv
AssetID,Name,Type,Value,Location
A00001,Asset-1,Server,1348.04,Berlin
A00002,Asset-2,Router,11238.22,London
A00003,Asset-3,Server,29565.58,New York
A00004,Asset-4,Laptop,4775.39,Bogotá
A00005,Asset-5,Laptop,28106.13,Toronto
A00006,Asset-6,Router,22515.53,Berlin
A00007,Asset-7,Laptop,37964.49,Tokyo
A00008,Asset-8,Phone,17078.5,Tokyo
A00009,Asset-9,Router,47864.93,Sydney
A00010,Asset-10,Server,4728.02,London
A00011,Asset-11,Printer,42389.97,Berlin
A00012,Asset-12,Laptop,36513.62,London
A00013,Asset-13,Phone,4032.13,Berlin
A00014,Asset-14,Printer,28909.87,London
A00015,Asset-15,Laptop,33097.04,Berlin
A00016,Asset-16,Server,42780.35,London
A00017,Asset-17,Phone,13970.88,Sydney
A00018,Asset-18,Monitor,18572.03,Bogotá
A00019,Asset-19,Switch,35120.83,London
A00020,Asset-20,Monitor,26753.58,Bogotá
A00021,Asset-21,Monitor,23166.78,Berlin
A00022,Asset-22,Router,34262.25,New York
A00023,Asset-23,Router,41107.95,Sydney
A00024,Asset-24,Phone,13460.27,Bogotá
A00025,Asset-25,Printer,10710.06,São Paulo
A00026,Asset-26,Phone,44245.69,São Paulo
A00027,Asset-27,Monitor,13317.52,Bogotá
A00028,Asset-28,Switch,37375.99,Toronto
A00029,Asset-29,Phone,18163.62,Tokyo
```

## CLI1 – Find Malformed CSV Records

```bash
awk -F, 'NR>1 && NF!=5 {print NR ":" $0}' blackwood_assets.csv
```

**How it works:**

* `awk` – Executes an AWK program.
* `-F,` – Sets the field separator to a comma (`,`), so each CSV column becomes a field.
* `NR>1` – Skips the header row by processing records after line 1.
* `NF!=5` – Checks whether the current record does **not** contain exactly 5 fields.
* `{print NR ":" $0}` – Prints:

  * `NR` – Current line number.
  * `":"` – A colon separator.
  * `$0` – The entire current record.
* `blackwood_assets.csv` – Input CSV file.

---

## CLI2 – Fix the Corrupt Record In-Place

```bash
sed -i '7742s/20399,12/20399.12/' blackwood_assets.csv
```

**How it works:**

* `sed` – Stream editor used to modify text.
* `-i` – Edits the file **in place**.
* `7742` – Applies the command only to line 7742.
* `s/old/new/` – Substitute command.

  * `20399,12` – Text to find.
  * `20399.12` – Replacement text.
* `blackwood_assets.csv` – File being modified.

---

## CLI3 – Display City Frequencies

```bash
awk -F, 'NR>1 {count[$5]++} END {for (city in count) print count[city], city}' blackwood_assets.csv | sort -nr
```

**How it works:**

* `-F,` – Uses comma as the field separator.
* `NR>1` – Skips the header.
* `$5` – Refers to the fifth field (City).
* `count[$5]++` – Uses an associative array named `count`:

  * `$5` becomes the array index (city name).
  * `++` increments the count for that city.
* `END` – Executes after all records have been processed.
* `for (city in count)` – Loops through every city stored in the array.
* `print count[city], city` – Prints the frequency and city name.
* `| sort -nr`

  * `-n` – Numeric sort.
  * `-r` – Reverse order (largest first).

---

## CLI4 – Display City Frequencies with a Header

```bash
(printf "%-12s %-15s\n" "Assets" "City"; \
awk -F, 'NR>1 {count[$5]++} END {for (city in count) printf "%-12d %-15s\n", count[city], city}' blackwood_assets.csv | sort -k1,1nr)
```

**How it works:**

* `(` `)` – Groups commands so they execute together.
* `printf "%-12s %-15s\n"` – Prints the column headings.

  * `%-12s` – Left-align a string in a 12-character field.
  * `%-15s` – Left-align a string in a 15-character field.
  * `\n` – New line.
* `NR>1` – Skips the header.
* `count[$5]++` – Counts assets for each city.
* `END` – Runs after reading the entire file.
* `printf "%-12d %-15s\n"` – Prints aligned numeric and text columns.
* `sort -k1,1nr`

  * `-k1,1` – Sorts using only the first column.
  * `-n` – Numeric sort.
  * `-r` – Descending order.

---

## CLI5 – List Unique Cities

```bash
awk -F, 'NR>1 {print $5}' blackwood_assets.csv | sort -u
```

**How it works:**

* `-F,` – Uses commas as field separators.
* `NR>1` – Skips the header.
* `$5` – Selects the City column.
* `print $5` – Prints each city.
* `| sort -u`

  * `sort` – Sorts alphabetically.
  * `-u` – Removes duplicate entries.

---

## CLI6 – Count Assets by Type

```bash
awk -F, 'NR>1 {count[$3]++} END {for (type in count) print count[type], type}' blackwood_assets.csv | sort -nr
```

**How it works:**

* `-F,` – Comma-separated fields.
* `NR>1` – Skips the header.
* `$3` – Refers to the Asset Type column.
* `count[$3]++` – Counts each asset type.
* `END` – Executes after processing all records.
* `for (type in count)` – Iterates through each asset type.
* `print count[type], type` – Prints the frequency and asset type.
* `sort -nr` – Sorts by frequency from highest to lowest.

---

## CLI7 – Show Assets from a Specific City

```bash
awk -F, '$5=="Sydney"' blackwood_assets.csv
```

**How it works:**

* `-F,` – Uses commas as field separators.
* `$5` – Refers to the City column.
* `=="Sydney"` – Compares the city value with `"Sydney"`.
* When the condition is true, AWK's default action is to print the entire record.
* Replace `"Sydney"` with another city name to filter different records.

---

## CLI8 – Sum of All Asset Values

```bash
awk -F, 'NR>1 {sum+=$4} END {printf "Total Asset Value: %.2f\n", sum}' blackwood_assets.csv
```

**How it works:**

* `-F,` – Uses commas as field separators.
* `NR>1` – Skips the header.
* `$4` – Refers to the Asset Value column.
* `sum += $4` – Adds the current asset value to the running total.
* `END` – Executes after all records have been processed.
* `printf`

  * `%.2f` – Displays the total as a floating-point number with two decimal places.
  * `\n` – Prints a newline after the output.
