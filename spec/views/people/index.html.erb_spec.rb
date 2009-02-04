=begin
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/people/index.html.erb" do
  include PeopleHelper
  
  before(:each) do
    assigns[:people] = [
      stub_model(Person,
        :name => "value for name"
      ),
      stub_model(Person,
        :name => "value for name"
      )
    ]
  end

  it "should render list of people" do
    render "/people/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
  end
end

=end
