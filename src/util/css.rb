# css like language parser
# TODO: move this to its own project

# given a string like `foo {bg: red; padding-top: 3} .bar .primary {}`
# Rules:
#  * values cannot contain any of the following chars: `:;{}`
class CSSParser
  def parse(code)
    rules = parse_rules code
    rules.map do |rule|
      properties = rule[:body].split(';').map{|s|s.strip}
      properties = properties.map{|property|
        a = property.split(':').map{|s|s.strip}
        throw "Syntax error in property '#{property}', rule: '#{rule}'" if a.length != 2
        {
          name: a[0],
          value: a[1]
        }
      }
      {
        selector: rule[:selector],
        properties: properties
      }
    end
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
end

p = CSSParser.new
p.parse('foo {bg: red; padding-top: 3} .bar .primary {border: double black}; .sidebar .container { padding: 1}')
