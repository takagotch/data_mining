$:.unshift File.dirname(__FILE__)
require 'natto'
require 'idf_dic'

module TfIdf

  #split
  def split_words(text)
    @arr = Array.new
    nm = Natto::MeCab.new('-d /usr/local/lib/mecab/dic/mecab-ipadic-neologd')
    nm.parse(text) do |n|
      surface = n.surface
      feature = n.feature.split(',')
      #noun
      if feature.first == 'noun' && feature.last != '*'
        @arr.push(surface)
      end
    end
  end

  #TF
  def calculate_tf
	  @tr = Hash.new
	  @arr.each do |word|
		  if(@tf.key?(word))
			  @tf[word] += 1
		  else
			  @tf[word]  = 1
		  end
		  @tf.each do |key, value|
			  @tf[key] = value.to_f/@tf.size
		  end
  end

  def caluculate_tfidf
	  @tfidf = Hash.new
	  @tf.each do |key, value|
		  if #idf.has_key?(key)
			  @tfidf[key] = ($idf[key] * value).round(3)
		  end
	  end
	  puts @tfidf
  end
end

