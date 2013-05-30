require "csv"
require "kconv"

# please set defaults language folder
localizedFolderName = "ja.lproj"
File::open(localizedFolderName + "/Localizable.strings") do |f|
	CSV.open("localizable.txt","w") do |csv|
		csv << ["ViewController","LineComment","key","ja","en","for system",'=IF(ISBLANK($C1),$A1,""""&$C1&""""&"="&""""&D1&""";"&$B1)']
		keyAry = []
		f.each do |line|
      if /^\/\// =~ line # this line is comment
        cell = []
        csv << cell
        cell << line
        csv << cell
      end
			if /^"/ =~ line # this line is localizable string
				lineAry = line.split(/\"/)
				splitFlag = 0
				keysStr = ""
				wordsStr = ""
        commentStr = ""
				lineAry.each do |word|
					if splitFlag == 0 
						if /=/ =~ word
							splitFlag = 1
						else
							keysStr += word
						end
          else 
						if /;/ =~ word
              commentStr += word.delete(";")
						else
						  wordsStr += word
            end
					end
				end
				cell = []
        cell << ""
        cell << commentStr
				cell << keysStr
				cell << wordsStr
				csv << cell
			end 
		end
	end	
end
