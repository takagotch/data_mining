#gem RMagick, Rvideo
#gem ImageMagick, GraphicMagic
#FFmpeg
require 'csv'
require 'rmagic'
require 'active_support/all'
require 'rvideo'

vid = RVideo::inspector.new(:file => "beat.mov")
width, height = vid.width, vid.height
fps = vid.fps.to_i
duration = vid.duration/1000

if system("ffmpeg -i beat.mov -f image2 'frame%03d.png'")
	CSV.open("data.csv", "w") do |file|
		file << %w(frame intensity)
		(fps*duration).times do |n|
		  img = Magic::ImageList.new("frames/frame#{sprintf("%03d", n+1)}.png")
		  ch = img.channel(Magick::RedChannel)
		  i = 0
		  ch.each_pixel {|pix| i += pix.intensity}
		  file << [n+1, i/(height*width)]
		end
	end
end

