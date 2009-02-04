=begin
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/people/show.html.erb" do
  include PeopleHelper
  
  before(:each) do
    assigns[:person] = @person = stub_model(Person,
      :name => "value for name"
    )
  end

  it "should render attributes in <p>" do
    render "/people/show.html.erb"
    response.should have_text(/value\ for\ name/)
  end
end

=end
