# css like language parser
# TODO: move this to its own project

module TermGui
# given a string like `foo {bg: red; padding-top: 3} .bar .primary {}`
# Rules:
#  * values cannot contain any of the following chars: `:;{}`
#  * No inmediate children ('>') supported. Example, `a b` is supported. `a>b` is not supported.
class CSSParser
  def parse(code)
    rules = parse_rules code
    rules = parse_rules_properties rules
    rules = parse_rules_selectors rules
    rules
  end

  def parse_rules(code)
    code.split('}').map do |rule|
      a = rule.split('{')
      throw "Syntax error in rule '#{rule}'" if a.length != 2
      {
        selector: a[0].strip,
        body: a[1].strip
      }
    end
  end

  # given rules are the output of `parse_rules`. It will return a similar object but for each rule, instead `body` string have name-value `properies`
  def parse_rules_properties(rules)
    rules.map do |rule|
      properties = rule[:body].split(';').map(&:strip)
      properties = properties.map do |property|
        a = property.split(':').map(&:strip)
        throw "Syntax error in property '#{property}', rule: '#{rule}'" if a.length != 2
        {
          name: a[0],
          value: a[1]
        }
      end
      {
        selector: rule[:selector],
        properties: properties
      }
    end
  end

  # given rules are the output of `parse_rules_properties`, it returns a similar object but for each rule, instead `selector` string have
  # a parsed selector object: `Array<Array<{name: string, operator: nil|'>'|' '}>>`
  def parse_rules_selectors(rules)
    rules.map do |rule|
      selectors = rule[:selector].split(',').map(&:strip)
      selectors = selectors.map do |s|
        parse_selector s
      end
      {
        selectors: selectors,
        properies: rule[:properties]
      }
    end
  end

  # independent method to parse string selectors like 'a>b c' to `Array<{name: string, operator: nil|'>'|' '}>`
  def parse_selector(s)
    a = s.split(/([\s>])/)
    i = 0
    results = []
    while i < a.length
      results.push(name: a[i], operator: a[i + 1])
      i += 2
    end
    results = results.reject { |result| result[:name].strip == '' }
    results
  end
end
end

CSSParser = TermGui::CSSParser

# p = CSSParser.new
# # p.parse('foo {bg: red; padding-top: 3} .bar .primary {border: double black}; .sidebar .container { padding: 1}')
# s = 'a>  b c>d f'
# p CSSParser.new.parse_selector 'a>  b c>d f'
# a = s.split(/([\s>])/) # .select{|s|s.strip!=''}
# p a
# i = 0
# results = []
# while i < a.length
#   results.push(name: a[i], operator: a[i + 1])
#   i += 2
# end
# results = results.reject { |result| result[:name].strip == '' }
# p results

# parser = CSSParser.new
# expected = '[{:selector=>"foo", :properties=>[{:name=>"bg", :value=>"red"}, {:name=>"padding-top", :value=>"3"}]}, {:selector=>".bar .primary", :properties=>[{:name=>"border", :value=>"double black"}]}, {:selector=>"; .sidebar .container", :properties=>[{:name=>"padding", :value=>"1"}]}]'
# rules = parser.parse_rules_properties(parser.parse_rules('foo {bg: red; padding-top: 3} .bar .primary {border: double black}; .sidebar .container { padding: 1}'))
# actual = parser.parse_rules_selectors(rules)
# p actual

