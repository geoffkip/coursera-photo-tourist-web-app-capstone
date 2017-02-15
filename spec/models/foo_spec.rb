require 'rails_helper'

describe Foo, type: :model do
  include_context "db_cleanup", :transaction
  before(:all) do
    @foo_worker = (0..9).each {|idx| @foo =  FactoryGirl.create(:foo, :name=>"name#{idx}")}
    if @foo_worker.count > 9
       puts @foo
       @foo.name='name0'
    end  
  end
  let(:foo) { Foo.find(@foo.id) }

  context "created Foo (let)" do
    it { expect(@foo).to be_persisted }
    it { expect(@foo.name).to eq("name0") }
    it { expect(Foo.find(foo.id)).to_not be_nil }
  end

  context "created Foo (subject)" do
    subject { @foo }

    it { is_expected.to be_persisted }
    it { expect(subject.name).to eq("name0") }
    it { expect(Foo.find(subject.id)).to_not be_nil }
  end
end
