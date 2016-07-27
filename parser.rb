require "csv"

i = 2

CSV.foreach('outputs/reg_cust_all.csv', headers:true) do |row|
  # puts row["zip_check"]
  if row["zip_check"].to_i == i
    puts i
    i+=1
  else
    puts "BROKEN HERE"
    break
  end
end
