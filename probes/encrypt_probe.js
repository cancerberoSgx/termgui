function encrypt(s, plus=1, ignore_spaces=true, ignore_chars=['_', '-', ':', ';', ',', '(', ')', '@', '=', '=', '?', '!', '&', '|', '<', '>']) {
  return s
    .split('')
    .map(c => {
      if(ignore_spaces && c.match(/\s+/im))      {
        return c
      } 
      else if(ignore_chars.includes(c))      {
        return c
      }
      else{
        code = c.charCodeAt(0) + plus
        return String.fromCharCode(code)
      }
    })
    .join('')
}

s = `
class ApplicationController < ActionController::Base
  before_action :set_friends

  private

  def set_friend
    @friends = wye_friends
  end
end
`
console.log(encrypt(s, 1));
