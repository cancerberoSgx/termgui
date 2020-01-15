# will select descendants from given `root` Node that matches given string selector (like `a>.b c`).
# The semantic mapping between ' ' and '>' "operators" and Node attributes can be overriden by subclassing
module NodeSelector
  # def initialize
  #   @parser = CSSParser.new
  # end
  def css(root, selector)
    @parser |= CSSParser.new
    parsed = @parser.parse_selector(selector)
    results = []
    css_impl([root], parsed, results)
  end

  protected

  # actual recursive css() implementation. each recursion will consume the first parsed passing the rest to the next call.
  # roots will be also updated accordingly to current matches.
  # The recursion condition is meet when parsed.length==1 (the last match step) which will return total matched elements
  # flatten storing it on given imput result argument.
  def css_impl(_roots, _parsed)
    throw 'TODO'
  end
end
