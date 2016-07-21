
# NOTE: I couldn't get symsrv to use these. It downloads them,
# but then doesn't say why.. but it refuses to use them.

def run_dir(root)
	Dir.foreach(root) { |fn|
		next if fn == "." || fn == ".."
		combined = File.join(root, fn)
		if File.directory?(combined)
			run_dir(combined)
		elsif File.file?(combined) && (fn[".dll"] || fn[".pdb"])
			fpath = combined
			fpath = fpath[2..-1] if fpath[0..1] == "./"
			fpath = fpath.gsub("/", "\\")
			print("#{fpath}\n")
			`compress -R #{fpath}`
			exit(1) if $?.exitstatus != 0
			`del #{fpath}`
		end
	}	
end

if ARGV[0]
	run_dir(ARGV[0])
else
	print("compress-all <directory>\n")
end
