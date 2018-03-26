namespace :db do
  namespace :seed do
    desc "Seed Users from /db/seeds/currency_amount.yml"
    task :currency_amount => :environment do
      db_seed_currency_amounts
    end
  end
end

def db_seed_currency_amounts
  path = Rails.root.join('db','seeds','currency_amount.yml')
  puts "Seeding file #{path}"
  File.open(path) do |file|
    YAML.load_stream(file) do |doc|
      doc.keys.sort.each do |key|
        puts "Seeding key #{key}"
        attributes = doc[key]
        db_seed_currency_amount(attributes)
      end
    end
  end
end

def db_seed_currency_amount(attributes)
    name= attributes[:name]
    if name
      puts "This email address exists: #{name}"
    else
      CurrencyAmount.create(attributes)
    end
end