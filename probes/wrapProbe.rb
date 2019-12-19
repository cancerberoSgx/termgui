require_relative '../src/util/wrap'

w = Wrapper.new('some long long long tyext text', 13)
p w.wrap
p w.fit