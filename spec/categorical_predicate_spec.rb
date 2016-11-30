require 'spec_helper'

describe CategoricalPredicate do

  let (:pred_string) { '   <SimpleSetPredicate field="f36" booleanOperator="isIn">
    <Array n="6" type="string">"F"   "F1L"   "F1L1"   "FL"   "FL1"   "L"</Array>
   </SimpleSetPredicate>' }
  let (:pred_xml) { Nokogiri::XML(pred_string); }
  let (:relevant_pred_xml) {  pred_xml.xpath('*') }
  let (:categorical_predicate) { CategoricalPredicate.new(relevant_pred_xml) }


  it 'logs missing feature' do
    expect(RandomForester.logger).to receive(:error).with('Missing feature f36')
    categorical_predicate.true?({})
  end

  it 'logs nil feature' do
    expect(RandomForester.logger).to receive(:error).with('Feature f36 value is nil')
    categorical_predicate.true?({f36: nil})
  end

  it 'returns true' do
    expect(categorical_predicate.true?(f36: 'FL')).to eq true
  end

  it 'returns false' do
    expect(categorical_predicate.true?(f36: 'FF')).to eq false
  end

end