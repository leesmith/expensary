namespace :import do
  desc "Bulk load Amex credit card transactions"
  task :delta_amex, [ :filepath ] => :environment do |t, args|
    filepath = args[:filepath]
    account = Account.find_by(name: "Delta Amex")
    trans = []

    CSV.foreach(filepath, headers: true) do |row|
      # Date,Description,Card Member,Account #,Amount
      unless row[1] == "MOBILE PAYMENT - THANK YOU"
        trans << ({ account_id: account.id, tran_date: Date.strptime(row[0], "%m/%d/%Y"), description: row[1], amount: row[4].gsub("-", ""), tran_type: row[4].to_d < 0 ? "credit" : "debit" })
      end
    end

    Transaction.insert_all(trans)

    puts "::::::::: Added #{trans.size} transactions!"
  end
end
