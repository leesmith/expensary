# Assigns a category to a transaction based on existing category rules.
#
# Candidate rules are those scoped to the transaction's account or with no account
# (global). Account-specific rules are evaluated before global ones so they take
# precedence. The first matching rule wins and its category is saved to the transaction.
# Returns nil when no rule matches.
#
# A rule matches when all three conditions hold:
#   - Description: rule phrase is a case-insensitive substring of the transaction description
#   - Amount:      skipped when the rule has no amount; otherwise compared with eq/gte/lte
#   - Account:     enforced at the query level — only rules for this account or with no
#                  account are considered
class TransactionCategorizerService
  def initialize(transaction)
    @transaction = transaction
  end

  def call
    rule = matching_rule
    return unless rule

    @transaction.update(category: rule.category)
  end

  private

  def matching_rule
    candidate_rules.find { |rule| matches?(rule) }
  end

  # Account-specific rules are ordered before global rules so they take precedence.
  def candidate_rules
    CategoryRule
      .where(account: [ @transaction.account_id, nil ])
      .order(Arel.sql("account_id IS NULL ASC"))
  end

  def matches?(rule)
    description_matches?(rule) && amount_matches?(rule)
  end

  def description_matches?(rule)
    @transaction.description.downcase.include?(rule.description.downcase)
  end

  def amount_matches?(rule)
    return true if rule.amount.nil?

    case rule.amount_operator
    when "eq"  then @transaction.amount == rule.amount
    when "gte" then @transaction.amount >= rule.amount
    when "lte" then @transaction.amount <= rule.amount
    end
  end
end
