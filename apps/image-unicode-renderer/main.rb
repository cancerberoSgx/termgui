require_relative '../../src/widget/modal'
require_relative '../../src/termgui'
require_relative '../../src/util/unicode-categories'
require_relative 'app_handlers'
require_relative 'app'

app = App.new(Screen.new, '/Users/wyeworks/Documents/assets/*.png')
app.start


