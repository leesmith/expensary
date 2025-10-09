# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Expensary is a personal finance expense tracking application built with Ruby on Rails 8.0. It uses SQLite3 for data storage, Turbo/Stimulus for frontend interactivity, and TailwindCSS for styling.

## Development Commands

### Starting the Development Server
```bash
bin/dev
```
This starts both the Rails server and TailwindCSS watch process via foreman.

### Database Commands
```bash
bin/rails db:migrate              # Run pending migrations
bin/rails db:reset                # Drop, create, migrate, and seed database
bin/rails db:seed                 # Load seed data
bin/rails RAILS_ENV=test db:reset # Reset test database
```

### Testing
```bash
bin/rake                          # Run all tests (default rake task)
bin/rails test                    # Run all tests
bin/rails test test/models/account_test.rb  # Run a single test file
bin/test                          # Reset test DB and run full suite
```

The test suite uses:
- Factory Bot for test data (factories in `test/factories/`)
- Shoulda Matchers for model validations and associations
- Minitest with parallel test execution enabled

### Code Quality
```bash
bin/rubocop                       # Run rubocop linter
bin/brakeman                      # Run security scanner
bin/bundler-audit --update        # Check for gem vulnerabilities
bin/importmap audit               # Audit importmap dependencies
bin/ci                            # Run complete CI suite (brakeman, bundler-audit, rubocop, importmap audit, tests)
```

Code follows rubocop-rails-omakase style guide with custom exclusions for Gemfile, config, db, and vendor directories.

## Core Architecture

### Data Model
The application has three main models with the following relationships:

**Account** (`app/models/account.rb`)
- Has many transactions (dependent: destroy)
- Enum: `account_type` (liability: 0, asset: 1) with `_type` suffix
- Fields: name, description, account_type, balance

**Transaction** (`app/models/transaction.rb`)
- Belongs to account
- Belongs to category (optional)
- Enum: `tran_type` (debit: 0, credit: 1)
- Fields: account_id, description, tran_date, tran_type, amount, category_id

**Category** (`app/models/category.rb`)
- Has many transactions (dependent: nullify)
- Fields: group_title, title

### Routing Structure
- Root: Dashboard (`dashboard#index`)
- Accounts: Full CRUD except destroy, nested transactions destroy route
- Transactions: Index and destroy only (top-level and nested under accounts)
- Categories: Full CRUD except show and new

### Controllers
Controllers are organized with:
- `ApplicationController` as base
- `DashboardController` for root/home page
- Resource controllers: `AccountsController`, `TransactionsController`, `CategoriesController`
- Nested controller: `Accounts::TransactionsController` for account-scoped transaction actions

### Frontend Stack
- **Turbo/Stimulus**: For dynamic interactions without page refreshes
- **TailwindCSS**: For styling (watch process runs via `bin/dev`)
- **Importmap**: For JavaScript module management
- **Pagy**: For pagination
- **Rails Heroicon**: For icon components

### Test Structure
- Tests use Factory Bot for fixtures (no YAML fixtures)
- Support files loaded from `test/support/`
- Parallel test execution enabled with `:number_of_processors`
- Shoulda Matchers configured in `test/support/shoulda_matchers.rb`

## Development Patterns

### When Adding New Features
1. Create migration if database changes needed
2. Update model with validations/associations/enums
3. Create factory in `test/factories/`
4. Write model tests using shoulda-matchers where applicable
5. Create/update controller and routes
6. Add views with Turbo Frames/Streams as needed
7. Run `bin/rubocop` before committing

### Enum Conventions
- Use integer-backed enums (e.g., `{ liability: 0, asset: 1 }`)
- Add suffixes to avoid method conflicts (e.g., `suffix: true` for `account_type`)

### Database Schema
- All decimal fields use `precision: 12, scale: 2`
- Foreign keys use `add_foreign_key` constraints
- Important indexes on type columns and dates
