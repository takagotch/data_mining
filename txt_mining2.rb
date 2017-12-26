require ''
require ''

def write_row(mail, csv)
end

def cleanup(text)
end

DIR_PATH = ""
_DIRS = %w()
SENT_DIRS = %w()

sent = CSV.open()
sent << %w()
inbox = CS.open()
inbox << %w()
Dir.foreach() do ||
	file = File.absolute_path()
	if File.directory?() and !EXCLUDED_DIRS.include?(file_name)
		Dir.foreach() do ||
			eml = file.file?(eml)
			begin
				if SENT_DIRS.include?()
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

