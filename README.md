# Expensary - personal finance tracking

Expensary helps you measure and visualize your basic financial health. Track and categorize your
spending in order to calculate your monthly [cash flow](https://www.experian.com/blogs/ask-experian/what-is-cash-flow/).
Discover trends in spending to help change habits and promote higher savings and/or investing.

Expensary does not connect to financial services through any APIs. It does not track net worth nor does it
have a budgeting system (not yet?). You add your liability and asset accounts and then load your
transactions via simple CSV files.

## Setup

The `db/seeds.rb` file has some predefined categories. Edit these categories to fit your needs. Expensary
depends on having an "Income" group, a "Savings" group, and then all the other expense groups.
The "Income" and "Savings" groups are required in order to track income and savings transactions so
don't change those `group_title` values. You are free to change all the other expense `group_title` values.

The next step is to add your liability and asset accounts. Accounts like checking and savings would
be considered asset accounts. Credit cards would be considered liability accounts.

Transactions must be categorized before they will apply to income or expense totals.

Charts powered by [ECharts](https://echarts.apache.org/examples/en/index.html) via the [Rails Charts](https://github.com/railsjazz/rails_charts) gem.
