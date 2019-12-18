# frozen_string_literal: true

require 'timeout'

def setTimeout(sec, block)
  status = Timeout.timeout(sec) do
    sleep 999_999
    # print 'takes too long'
  end
rescue StandardError => e
  block.call
  # print 'x.raise e'
else
  block.call
  # print 'x.raise exception, message'
  # x.raise exception, message
end

setTimeout(1, proc { puts 'jejejeje' })
print 'end'
