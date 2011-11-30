$:.unshift "../lib"
require 'rubygems'
require 'getoptlong'
require 'rdf2gv'

def usage
  puts "usage: rdf2gv [-Tformat] [-ofile] [-h] rdfFile"
  puts "-F, --input-format  format    Input format (default: Turtle)"
  puts "-T, --output-format format    Output format (default: DOT)"
  puts "-o, --output-file file        Output file (default: STDOUT)"
  puts "-p, --path                    Graphviz path"
  puts "-h, --help                    Show this usage message"
  puts "-------------------------------------------------------------"
  puts "Available input formats: Turtle, RDF/XML, N-Triples"
end

out_file = String
in_format = "TURTLE"
out_format = :dot
gv_path = ""

oOpt = GetoptLong.new(
  ['--output-file',   '-o', GetoptLong::REQUIRED_ARGUMENT],
  ['--input-format',  '-F', GetoptLong::REQUIRED_ARGUMENT],
  ['--output-format', '-T', GetoptLong::REQUIRED_ARGUMENT],
  ['--path',          '-p', GetoptLong::REQUIRED_ARGUMENT],
  ['--help',          '-h', GetoptLong::NO_ARGUMENT]
)

begin
  oOpt.each_option do |option, value|
    case option
      when '--input-format'
        in_format = value
      when '--output-file'
        out_file = value
      when '--output-format'
        out_format = value.to_sym
      when '--path'
        gv_path = value
      when '--help'
        usage
        exit
    end 
  end 
rescue GetoptLong::InvalidOption => e
  usage
  exit
end

build_file=ARGV[0]
if build_file.nil? 
 usage
 exit
end
out = RDF2Gv.new(build_file, gv_path, in_format).save(out_format, out_file)
print out unless out.nil?