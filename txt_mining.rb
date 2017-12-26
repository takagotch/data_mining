require 'csv'
require 'mail'
require 'nokogiri'

def write_row(mail, csv)
  data = []
  data << mail.date
  text = ""
  if mail.text_part
	  text = mail.text_part.to_s.force_encoding("utf-8")
  else
	  html = Nokogiri::Slop(mail.vody.to_s)
	  text = html.text.force_encoding("utf-8")
  end
  data << cleanup(text)
  csv << data
end

def cleanup(text)
  text = text.gsub("/", " ")
  text = text.gsub(/[^a-zA-Z@\s]/u, '')
  text.gsub(/\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/, '')
end

EMAILS_TO-RETRIEVE = 2000

USER = '<YOUR USERNAME>'
PASS = '<YOUR PASSWORD>'
Mail.defaults do
	retriever_method :imap, :address => "impa.gmail.com",
		                :port    => 993,
	                        :user_name => "USER",
				:password  => "PASS",
				:enable_ssl => true
end

{}.each do ||
	emails = Mail.find(

)

CSV.open() do |csv|
	csv << %w()
	emails.each do ||
		begin
			write row mail, csv
		rescue
			puts ""
			puts $!
		end
	end
end
end





