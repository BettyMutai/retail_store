require 'csv'

class Sales


	def initialize()
		@allsales=[]
		@searcharray=[]
	end

	#create array from all the file rows
	def get_allsales()
		CSV.foreach('sales.csv') do |row|
			@allsales.push(row)
		end
	end
	#search through all sales to get row with the sku
	def search(sku)
		@allsales.each() do |row|
			#row=["Nairobi", DM1759, "6900 KSH"]
			if row[1].eql?(sku)
				@searcharray.push(row)
			end
		end
	end
	#get total sales of a single sku
	def getFinalResults(sku)
		get_allsales()
		search(sku)
		@totalsales=0
		@highestvalue=0
		@highsellingstore=""
		@highestsale=0
		@searcharray.each() do |storesale|
			#storesale=["Nairobi", "DM1000","70000      KSH"]
			#sub any extra space
			salevalue=(storesale[2].gsub(/\s+/, " ").split(" "))[0].to_i
			@totalsales+=salevalue
			#get highest selling store
			if salevalue>@highestvalue
				@highestvalue=salevalue
				@highsellingstore=storesale[0]
				@highestsale=storesale[2]
			end
		end
		#to return value in hash
		saleshash=Hash.new()
		saleshash.store("total_KSH", @totalsales)

		#highest selling store and selling value
		secondhash=Hash.new()
		secondhash.store("topstore",@highsellingstore)

		finalhash=Hash.new()
		finalhash.store("firsthash",saleshash)
		finalhash.store("secondhash",secondhash)
		finalhash.store("highestsale",@highestsale)
		finalhash
	end
end
