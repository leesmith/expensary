# Expensary - personal finance tracking

<img width="2850" height="1590" alt="expensary" src="https://github.com/user-attachments/assets/b58f746d-15ef-47fe-88f1-67be14d409a2" />

Expensary helps you measure and visualize your basic financial health. Track and categorize your
spending in order to calculate your monthly [cash flow](https://www.experian.com/blogs/ask-experian/what-is-cash-flow/).
Discover trends in spending to help change habits and promote higher savings.

Expensary does not connect to financial services through any APIs. It does not track net worth nor does it
track account balances. It currently does not have a budgeting system but that may change in the future. Add
your liability and asset accounts and then load your transactions via simple CSV files.

## Data model

### Categories

The `db/seeds.rb` file has some predefined categories. Edit these categories to fit your needs and then
add more as you go. Expensary depends on having an "Income" group, a "Savings" group, and then all the
other expense groups. The "Income" and "Savings" groups are required in order to track income and savings
transactions so don't change those `group_title` values. You are free to change all the other expense
`group_title` values.

Transactions *must* be categorized before they will apply to income or expense totals.

### Accounts

The next step is to add your liability and asset accounts. Accounts like checking and savings would
be considered asset accounts. Credit cards would be considered liability accounts.

### Transactions

Transactions belong to an account and should be assigned a category. The model consists of a transaction
date, a positive transaction amount, a description, and a transaction type which represents a debit/credit
indicator. Currently, transactions are added to the database by way of csv importer tasks. You'll need to
edit and/or add an importer if your csv files are different. Note that transactions like transfers (maybe
a payment to a credit card) should be ignored since they aren't part of your cash flow. However, a
transfer to a savings account should be recorded and categorized as a savings contribution.

## Running the app

Run the setup script: `./bin/setup`

Run the dev server: `./bin/dev`

Run the test suite: `./bin/test`

Run the CI suite: `./bin/ci`
