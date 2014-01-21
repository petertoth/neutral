describe Neutral::Icons::Set do
  let(:set) { Neutral::Icons::Set.new('my_test_icons') }
  
  describe "#name" do
    subject { set.name }
    it { should be_a(Symbol) }
  end
  
  describe "#definitions" do
    subject { set.definitions }
    it { should be_a(Hash) }
    it { should == Neutral.icons.send(Neutral.config.default_icon_set).to_h }
  end

  %w[positive negative remove].each do |definition|
    describe definition do
      let(:fa_definition) { "fa #{definition}" }

      it "adds Font Awesome definition for #{definition} icon to definitions" do
        set.send(definition, fa_definition)
        set.definitions[definition.to_sym].should == fa_definition
      end
    end
  end
end 
