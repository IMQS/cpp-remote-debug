# This can be used to fetch all the build output for one day,
# or fetch just one build exe/dll/pdb file, from the hash.

require 'fileutils'

SrcDir = "O:/Development/DebugSymbols"

def scan(srcdir, date, stub, hash, target)
	Dir.foreach(srcdir) { |fn|
		next if fn == "." || fn == ".." || fn == "000Admin"
		next if stub != "" && (fn[".dll"] || fn[".exe"] || fn[".pdb"]) && !fn[stub]
		combined = File.join(srcdir, fn)
		parts = combined.split("/")
		if File.directory?(combined)
			scan(combined, date, stub, hash, target)
		else
			match = false
			if date != ""
				match = File.stat(combined).ctime.strftime("%Y-%m-%d") == date
			else
				match = parts[-2] == hash
			end
			if match
				parts = parts[parts.length - 3 .. -1]
				target_dir = File.join(target, parts[0..-2].join("/"))
				target_fn = File.join(target, parts.join("/"))
				#print("#{target_dir} -- #{target_fn}\n")
				print("#{combined}\n")
				next if File.exists?(target_fn)
				FileUtils.mkdir_p(target_dir)
				FileUtils.cp(combined, target_fn)
			end
		end
	}
end

if ARGV.length < 2
	print("fetch-build YYYY-MM-DD target_dir      (eg fetch-build 2017-07-20 .)\n") 
	print("fetch-build filename HASH target_dir   (eg fetch-build panacea 578E12FC45b000 .)\n") 
end

hash = ""
date = ""
if ARGV[0] =~ /(\d\d\d\d)-(\d\d)-(\d\d)/
	date = ARGV[0]
	print("Scanning for date #{date}\n")
else
	raise "Too few arguments" if ARGV.length != 3
	stub = ARGV[0]
	hash = ARGV[1]
	print("Scanning for #{stub} with hash #{hash}\n")
end
target = File.expand_path(ARGV[1])
scan(SrcDir, date, stub, hash, target)
