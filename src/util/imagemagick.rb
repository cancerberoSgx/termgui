def command_error(c)
  `#{c}`
  false
rescue StandardError
  true
end

def image_magick_available
  !command_error('convert --version') && !command_error('identify --version')
end

require 'fileutils'
def app_folder(name = 'termgui')
  folder = File.join ENV['HOME'], ".#{name}"
  FileUtils.mkdir_p folder unless File.directory?(folder)
  folder
end

def convert(input, format = 'png')
  throw 'Refusing to convert : imagemagick not available' unless image_magick_available
  output = File.join(app_folder, File.basename(input, '.*') + Time.now.to_i.to_s + '.' + format)
  throw 'Refusing to convert : input file do not exists or output file exists' if !File.exist?(input) || File.exist?(output)
  `convert "#{input}" "#{output}"`
  output
end

# p convert('probes/assets/brazil.png')
