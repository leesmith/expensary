namespace :import do
  desc "Bulk load Apple savings transactions"
  task :apple_savings, [ :filepath ] => :environment do |t, args|
    filepath = args[:filepath]
    account = Account.find_by(name: "Apple Savings")
    trans = []

    CSV.foreach(filepath, headers: true) do |row|
      # Transaction Date,Posted Date,Activity Type,Transaction Type,Description,Currency Code,Amount
      # 10/31/2025,11/01/2025,"Interest","Credit","Interest Paid","USD","37.25"

      if row[2] != "ACH"
        category_id = Category.find_by(title: "Interest & Rewards").id

        trans << ({
          account_id: account.id,
          category_id: category_id,
          tran_date: Date.strptime(row[0], "%m/%d/%Y"),
          description: row[4],
          amount: row[6],
          tran_type: row[3].downcase
        })
      end
    end

    Transaction.insert_all(trans)
    puts "::::::::: Added #{trans.size} transactions!"
  end

  desc "Bulk load Apple credit card transactions"
  task :apple, [ :filepath ] => :environment do |t, args|
    filepath = args[:filepath]
    account = Account.find_by(name: "Apple Card")
    trans = []

    CSV.foreach(filepath, headers: true) do |row|
      # Transaction Date,Clearing Date,Description,Merchant,Category,Type,Amount (USD),Purchased By
      # 04/08/2024,04/08/2024,"PUBLIX #842","Publix","Grocery","Purchase","39.34","Jeremy Smith"

      unless row[4] == "Payment" && row[5] == "Payment"
        tran_type = row[5].downcase
        tran_type = "debit" if row[5] == "Purchase"

        trans << ({
          account_id: account.id,
          tran_date: Date.strptime(row[0], "%m/%d/%Y"),
          description: row[3],
          amount: row[6].gsub("-", ""),
          tran_type: tran_type
        })
      end
    end

    Transaction.insert_all(trans)
    puts "::::::::: Added #{trans.size} transactions!"
  end

  desc "Bulk load Amex credit card transactions"
  task :delta_amex, [ :filepath ] => :environment do |t, args|
    filepath = args[:filepath]
    account = Account.find_by(name: "Delta Amex")
    trans = []

    CSV.foreach(filepath, headers: true) do |row|
      # Date,Description,Card Member,Account #,Amount
      # 07/02/2025,WAL-MART,JEREMY LEE SMITH,-01002,30.45
      unless row[1] == "MOBILE PAYMENT - THANK YOU"
        trans << ({
          account_id: account.id,
          tran_date: Date.strptime(row[0], "%m/%d/%Y"),
          description: row[1],
          amount: row[4].gsub("-", ""),
          tran_type: row[4].to_d < 0 ? "credit" : "debit"
        })
      end
    end

    Transaction.insert_all(trans)
    puts "::::::::: Added #{trans.size} transactions!"
  end

  desc "Bulk load Chase Visa credit card transactions"
  task :chase_visa, [ :filepath ] => :environment do |t, args|
    filepath = args[:filepath]
    account = Account.find_by(name: "Chase Visa")
    trans = []

    CSV.foreach(filepath, headers: true) do |row|
      # Transaction Date,Post Date,Description,Category,Type,Amount,Memo
      # 08/24/2023,08/25/2023,MOUNTAIN BROOK HIGH SC,Education,Sale,-13.00,

      unless row[4] == "Payment"
        trans << ({
          account_id: account.id,
          tran_date: Date.strptime(row[0], "%m/%d/%Y"),
          description: row[2],
          amount: row[5].gsub("-", ""),
          tran_type: row[5].to_d < 0 ? "debit" : "credit"
        })
      end
    end

    Transaction.insert_all(trans)
    puts "::::::::: Added #{trans.size} transactions!"
  end

  desc "Bulk load Regions Visa credit card transactions"
  task :regions_visa, [ :filepath ] => :environment do |t, args|
    filepath = args[:filepath]
    account = Account.find_by(name: "Regions Visa")
    trans = []

    CSV.foreach(filepath, headers: true) do |row|
      # "Account","Transaction Date","Posted Date","No.","Description","Debit","Credit","Long Description"
      # "CASH REWARDS VISA SIGNATURE * 6819","08/15/2024","08/19/2024","*6819","Southwest Airlines","-554.9300","","SOUTHWES xxxxxxxx62291"

      unless row[7] == "PAYMENT - THANK YOU"
        if row[5].present?
          amount = row[5].gsub("-", "")
          tran_type = "debit"
        else
          amount = row[6]
          tran_type = "credit"
        end

        trans << ({
          account_id: account.id,
          tran_date: Date.strptime(row[1], "%m/%d/%Y"),
          description: row[4],
          amount: amount,
          tran_type: tran_type
        })
      end
    end

    Transaction.insert_all(trans)
    puts "::::::::: Added #{trans.size} transactions!"
  end

  desc "Bulk load Regions checking transactions"
  task :regions_checking, [ :filepath ] => :environment do |t, args|
    filepath = args[:filepath]
    account = Account.find_by(name: "Regions Checking")
    trans = []

    CSV.foreach(filepath, headers: true) do |row|
      # "Account","Transaction Date","Posted Date","No.","Description","Debit","Credit","Long Description"
      # "CHECKING * 6861","08/16/2024","08/16/2024","","EB To Savings 9792","-20.0000","","EB TO SAVINGS # xxxxxx9792 REF# 000000 8643451"

      if row[5].present?
        amount = row[5].gsub("-", "")
        tran_type = "debit"
      else
        amount = row[6]
        tran_type = "credit"
      end

      trans << ({
        account_id: account.id,
        tran_date: Date.strptime(row[1], "%m/%d/%Y"),
        description: row[4],
        amount: amount,
        tran_type: tran_type
      })
    end

    Transaction.insert_all(trans)
    puts "::::::::: Added #{trans.size} transactions!"
  end
end
