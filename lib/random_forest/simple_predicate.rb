class SimplePredicate

  GREATER_THAN = 'greaterThan'
  LESS_OR_EQUAL = 'lessOrEqual'
  EQUAL = 'equal'

  attr_reader :field

  def initialize(pred_xml)
    attributes = pred_xml.attributes

    @field = attributes['field'].value.to_sym
    @operator = attributes['operator'].value
    return if @operator == 'isMissing'
    @value = @operator == EQUAL ? attributes['value'].value : Float(attributes['value'].value)
  end

  def true?(features)
    curr_value = @operator == EQUAL ? features[@field] : Float(features[@field])
    return curr_value > @value if @operator == GREATER_THAN
    curr_value < @value if @operator == LESS_OR_EQUAL
  end
end