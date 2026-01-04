require "test_helper"

class FactoriesTest < ActiveSupport::TestCase
  test "all factories are valid" do
    assert_nothing_raised { FactoryBot.lint(traits: true, verbose: true) }
  end
end
