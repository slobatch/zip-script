require "stripe"
require "csv"
Stripe.api_key = "sk_live_xxxxxxxxxxxxxxxxxxxxxxxx"

## csv format:
## "id","stripe_customer_id","stripe_card_id","zip_check"

low = ARGV[0].to_i
low_s = ARGV[0]
high = ARGV[1].to_i
high_s = ARGV[1]

File.open("outputs/abuse_cust#{low_s}-#{high_s}.csv.tmp", 'w') do |file|
  CSV.foreach('inputs/abuse_cust.csv', headers:true) do |row|
  # CSV.foreach('inputs/abuse_cust.csv') do |row|
    if $. >= low && $. <= high
      begin
        customer = Stripe::Customer.retrieve(row['stripe_customer_id'])
        cus_id = customer.id
        card = customer.sources.retrieve(row['stripe_card_id'])
        zip_status = card.address_zip_check
        if zip_status
          puts "Abuse #{$.} Zip Status: #{zip_status}"
          row["zip_check"]="#{zip_status}"
          file.write(row)
        else
          puts "Abuse #{$.} Zip Status: null"
          row["zip_check"]="null"
          file.write(row)
        end
        # sleep(0.015)
      rescue
        puts "Abuse #{$.} Zip Status: N/A"
        row["zip_check"]="#{row['id']}: N/A"
        file.write(row)
      end
    end
  end
end
