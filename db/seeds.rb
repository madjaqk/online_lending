first_names = ["Noah", "Liam", "Mason", "Jacob", "William", "Ethan", "Michael", "Alexander", "James", "Daniel", "Emma", "Olivia", "Sophia", "Isabella", "Ava", "Mia", "Emily", "Abigail", "Madison", "Charlotte"]
last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia", "Rodriguez", "Wilson", "Martinez", "Anderson", "Taylor", "Thomas", "Hernandez", "Moore", "Martin", "Jackson", "Thompson", "Lopez", "Lee", "Gonzalez", "Harris"]

email_patterns = ["firstlast@host.com", "first.last@host.com", "finitlast@host.com", "firstlinit@host.com", "lastfirst@host.com"]

email_hosts = ["gmail", "yahoo", "hotmail", "codingdojo"]

passwords = ["123456", "password", "12345678", "qwerty", "football", "1234567", "baseball", "welcome", "1234567890", "abc123", "111111", "1qaz2wsx", "dragon", "master", "monkey", "letmein", "princess", "qwertyuiop", "passw0rd", "starwars"]

purposes = ["green energy", "Facebook", "computers", "bicycles", "VR", "SnapChat", "Dr Pepper", "diet soft drinks", "puzzles", "breakfast", "money", "cheese", "oil", "drugs (legal)", "drugs (illegal)"]

consumer_goods = ["house", "boat", "computer", "block of solid gold"]

descriptions = ["I spent too much on a consumer_good and now need more money.", "I have a great idea for purpose.", "I like purpose.", "If I don't get purpose, I will die.", "I lost my consumer_good in the market crash.", "Help me make a better life.", "Hey, come on...you know.  I thought you were cool.", "My children deserve better.", "Getting purpose would make all of my dreams come true.", "Together we can make a better world.", "Don't judge me.", "Come on, you can trust me ;)", "It's totally not a pyramid scheme.  It's just a new way for all of us to get purpose.", "I'm trying to turn my life around and purpose will help."]

10.times do
	new_guy = {}
	@first = first_names.sample
	@last = last_names.sample
	new_guy[:first_name] = @first
	new_guy[:last_name] = @last
	host = email_hosts.sample
	format = email_patterns.sample
	new_guy[:email] = format.gsub(/first/,@first).gsub(/last/,@last).gsub(/finit/,@first[0]).gsub(/linit/,@last[0]).gsub(/host/,host)
	new_guy[:password] = passwords.sample
	new_guy[:money] = rand(1000..10000)
	lender = Lender.new(new_guy)
	lender.save if lender.valid?
end

30.times do
	new_guy = {}
	@first = first_names.sample
	@last = last_names.sample
	new_guy[:first_name] = @first
	new_guy[:last_name] = @last
	host = email_hosts.sample
	format = email_patterns.sample
	new_guy[:email] = format.gsub(/first/,@first).gsub(/last/,@last).gsub(/finit/,@first[0]).gsub(/linit/,@last[0]).gsub(/host/,host)
	new_guy[:password] = passwords.sample
	new_guy[:money] = rand(500..5000)
	@purpose = purposes.sample
	new_guy[:purpose] = @purpose.slice(0,1).capitalize + @purpose.slice(1..-1)
	@description = descriptions.sample
	new_guy[:description] = @description.gsub(/purpose/,@purpose).gsub(/consumer_good/,consumer_goods.sample)
	new_guy[:raised] = 0
	borrower = Borrower.new(new_guy)
	borrower.save if borrower.valid?
end

45.times do 
	@borrower = Borrower.all.sample
	@lender = Lender.all.sample
	@amount = rand(10..50)
	loan = History.create(borrower: @borrower, lender: @lender, amount: @amount)
	@borrower.raised += @amount
	@lender.money -= @amount
	@borrower.save
	@lender.save
end