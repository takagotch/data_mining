get '/csv' do
  content_type do
	  content_type 'application/csv'
	  attachment   'download.csv'

	  @data = Model.all()

	  @csv  = "date, value\n"

	  @data.each do |d|
		  @csv += .date.to_s + "," + d.value.to_s + "\n"
	  end

	  erb :csvtest, :layout => false
end

