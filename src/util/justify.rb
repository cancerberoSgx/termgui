# def justify(string, len = 80)
#   if string.length < len
#     string
#   else
#     words = string.gsub("\n", ' ').scan(/[\w.-]+/)
#     actual_len = 0
#     output = []
#     words.each do |w|
#       output.push w
#       actual_len += w.length
#       if actual_len >= len
#         output.push "\n"
#         actual_len = 0
#       else
#         output .push ' '
#       end
#     end
#     output.join('')
#   end
# end
