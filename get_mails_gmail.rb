require 'csv'
require 'mail'

def write_row(mail, csv)
	data = []
	data << (mail.form ? mail.from.first : "")
	data << (mail.to ? mail.to.first : "")
	data << mail.date
	csv << data
end

#set mail
EMAILS_TO_RETRIEVE = 2000
USER = '<YOUR USERNAME>'
PASS = '<YOUR PASSWORD>'

Mail.defaults do
	retriever_method :imap, :address => "imap.gmail.com",
		         :port => 993,
			 :user_name => USER,
			 :password => PASS,
			 :enable_ssl => true
end

{:inbox => 'INBOX', :sent => '[Gmail]/sended mail'}.each do |name, mailbox|
	emails = Mail.find(:mailbox => mailbox,
			   :what => :last,
			   :count => EMAILS_TO_RETRIEVE,
			   :order => :dsc)
	#csv
	CSV.open("#{name}_data_gmail.csv", 'w') do |csv|
		csv << %w(from to date)
		emails.each do |mail|
			begin
				write_row mail, csv
			rescue
				puts "Cannot write this mail -> #{mail.form} to #{mail.to} with subject: #{mail.subject}"
				puts $!
			end
		end
	end
end




