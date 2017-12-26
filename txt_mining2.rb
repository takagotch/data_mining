require 'csv'
require 'mail'

def write_row(mail, csv)
  data = []
  data << mail.date
  text = mail.body ? mail.body.to_s.force_encodeing("utf-8"): ""
  data << cleanup(text)
  csv << data
end

def cleanup(text)
  text text.gsib("/", " ")
  text << mail.date
  text.gsub(/\b[a-zA-z0-9._%+-]+@[a-zA-Z0-9.-_]+\b/, '')
end

DIR_PATH = "/Users/sausheong/Downloads/taka_mail_20171227/maildir/kean-s"
EXCLUDED_DIRS = %w(. .. deleted_items all_documents archibing calendar discssion_threads)
SENT_DIRS = %w(sent sent_items)

sent = CSV.open("sent-txt_data_taka.csv", 'w')
sent << %w(date body)
inbox = CSV.open("inbox_txt_data_taka.csv", 'w')
inbox << %w(data body)
Dir.foreach(DIR_PATH) do |file_name|
	file = File.absolute_path(file_name, DIR_PATH)
	if File.directory?(file) and !EXCLUDED_DIRS.include?(file_name)
		Dir.foreach(file) do |mail_file|
			eml = File.absolute_path(mail_file, file)
			if File.file?(eml)
				mail = Mail.read eml
				begin
				  if SENT_DIRS.include?(file_name)
				    write_row mail, sent
				  else
				    write_row mail, inbox
				end
			rescue
				puts "Cannot write this mail -> #{mail.from} to #{mail.to} with subject: #{mail.subject}"
				puts $!
			end
		end
	end
end
end

inbox.close
sent.close

exit

