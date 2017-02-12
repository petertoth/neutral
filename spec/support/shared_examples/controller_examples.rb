shared_examples "unable to change" do |action|
  context "when cannot change" do
    context "when not permitted to change" do
      before do
        Neutral.configure { |config| config.can_change = false }
        controller.stub(:current_user).and_return(vote.voter)
      end
    
      after do
        Neutral.configure { |config| config.can_change = true }
      end 

      it_should_behave_like "not performing #{action}"
    end
    
    context "when current_user is not an owner of the vote" do
      before do
        controller.stub(:current_user).and_return(voter)
      end

      it_should_behave_like "not performing #{action}"
    end
  end
end

shared_examples "not performing update" do
  it "does not update the vote" do
    update(vote)
    vote.value.should == vote.reload.value
  end

  it "renders cannot_change template" do
    expect(update(vote)).to render_template('errors/cannot_change')
  end
end

shared_examples "not performing destroy" do
  it "does not destroy the vote" do
    initial_count = Neutral::Vote.count
    destroy(vote)
    expect(Neutral::Vote.count).to eq(initial_count)
  end

  it "renders cannot_change template" do
    expect(destroy(vote)).to render_template('errors/cannot_change')
  end
end
