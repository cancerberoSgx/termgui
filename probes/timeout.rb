require 'timeout'

def setTimeout(sec, block)
  begin
    status = Timeout::timeout(sec) {
    sleep 999999
    # print 'takes too long'
  }
  rescue => e
    block.call
    # print 'x.raise e'
  else
    block.call
    # print 'x.raise exception, message'
  # x.raise exception, message
  end
end

setTimeout(1, Proc.new {puts 'jejejeje' })
print 'end'