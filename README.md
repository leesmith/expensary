# Expensary - personal finance tracking

<img width="3552" height="1934" alt="exp-dashboard" src="https://github.com/user-attachments/assets/50a07958-5a7e-4a54-a177-883e29d49489" />

<img width="3552" height="1934" alt="exp-cashflow" src="https://github.com/user-attachments/assets/ef14af13-4299-477c-8634-42cf2dbe7861" />

<img width="3552" height="1934" alt="exp-trends1" src="https://github.com/user-attachments/assets/bbf1e125-ab29-4bf3-be4c-816dcd037477" />

<img width="3552" height="1934" alt="exp-trends2" src="https://github.com/user-attachments/assets/13e4b4d5-f918-4d95-b679-f5750f170b28" />

Expensary helps you measure and visualize your basic financial health. Categorize and track your
spending in order to calculate your monthly [cash flow](https://www.experian.com/blogs/ask-experian/what-is-cash-flow/).
Discover trends in spending to help change habits and promote higher savings.

Expensary does not connect to financial services through any APIs. It does not track net worth nor does it
track account balances. It currently does not have a budgeting system but that may change in the future.
Transactions are loaded by way of CSV files that you download from your financial institutions.

## Data model

### Categories

The `db/seeds.rb` file has some predefined categories. Edit these categories to fit your needs and also
add more as you go. Expensary requires an "Income" group to track income totals and a "Savings" group
to track savings contributions. All other category groups are free to edit.

Transactions *must* be categorized before they will apply to income or expense totals.

### Accounts

Add your liability and asset accounts. Accounts like checking and savings would be considered asset
accounts. Credit cards would be considered liability accounts.

### Transactions

Transactions belong to an account and should be assigned a category. The model consists of a transaction
date, a positive transaction amount, a description, and a transaction type which represents a debit/credit
indicator. Currently, transactions are added to the database by way of CSV importer tasks.

## Transaction import tasks

Example import tasks can be found in `lib/tasks/import`. You'll need to edit and/or add an importer
for your CSV files. You'll need to change the lookups for accounts and categories found in these example
tasks to fit your data. Note that transactions like credit card payments should be ignored since they
aren't part of your cash flow. However, a transfer to a savings account should be recorded and
categorized as a savings contribution. Negative transaction amounts should be made positive and the
`tran_type` should set as "debit".

`./bin/rake import:apple["/path/to/csv_file.csv"]`

## Running the app

Run the setup script: `./bin/setup`

Run the dev server: `./bin/dev`

Run the test suite: `./bin/test`

Run the CI suite: `./bin/ci`

Load fake data to test drive the app: `./bin/rake fake`
