require "csv"
require "nkf"

# please set defaults language folder
localizedFolderName = "ja.lproj"
s = ""
File::open(localizedFolderName + "/Localizable.strings" ,"rb:UTF-16LE") do |f|
  s = f.read
end
s = s.encode("UTF-8")
CSV.open("localizable.txt","w") do |csv|
  csv << ["key","ja","en","for system",'=""""&$A1&""""&"="&""""&B1&""";"']
  keyAry = []
  s.each_line do |line|
    if /^"/ =~ line
      lineAry = line.split(/\"/)
      splitFlag = 0
      keysStr = ""
      wordsStr= ""
      lineAry.each do |word|
        if splitFlag == 0 
          if /=/ =~ word
            splitFlag = 1
          else
            keysStr += word
          end
        else
          if /;/ =~ word
            break
          end
          wordsStr += word
        end
      end
      cell = []
      cell << keysStr
      cell << wordsStr
      csv << cell
    end 
  end
end	
