require 'csv'
require 'mail'

def write_row(mail, csv)
  data = []
  data << (mail.from ? mail.form.first : "")
  data << (mail.to ? mail.to.first : "")
  data << mail.data
  csv << data
end

DIR_PATH = ""
EXCLUDED_DIRS = %w()
EXCLUDED_DIRS = %w()
SENT_DIRS = %W()

sent = CSV.open()
sent << %w()
inbox = CSV.open()
inbox << %w()

Dir.foreach() do |file_name|
	file = File.absolute_path()
	if File.directory?() and !EXCLUDED_DIRS.include?(file_name)
		Dir.foreach() do ||
			eml = File.absolute_path()
			if File.file?(eml)
				mail = Mail.read eml
				begin
					if SENT_DIRS.include?(file_name)
						write_row mail, sent
					else
						write_row mail, inbox
					end
				rescue
					puts ""
					puts $!
				end
			end
		end
	end
end

inbox.close
sent.close

exit


