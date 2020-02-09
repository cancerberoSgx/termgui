def command_error(c)
  `#{c}`
  false
  rescue
    true
end

def image_magick_available
  !command_error("convert --version") && !command_error("identify --version")
end
p command_error("non_existent_cmd")
p command_error("ls")
p image_magick_available