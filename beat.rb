require 'csv'

CSV.open('beat.csv', 'w') do |csv|
	csv << %w(time ch1 ch2 combined)
	File.open('beat.csv') do |file|
		file.seek(8)
		if file.read(4) == "WAVE"
		  file.seek(36)
		    if file.read(4) == 'data'
		 	file.seek(4, IO::SEEK_CUR)
			n = 1
			while !file.eof?
		  	  ch1, ch2 = file.read(4).unpack('ss')
			  csv << [n, ch1, ch2, ch1.to_i+ch2.to_i]
			  n += 1
			end
		    end
		end
	end
end

