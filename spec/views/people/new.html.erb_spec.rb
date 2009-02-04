=begin
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/people/new.html.erb" do
  include PeopleHelper
  
  before(:each) do
    assigns[:person] = stub_model(Person,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "should render new form" do
    render "/people/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", people_path) do
      with_tag("input#person_name[name=?]", "person[name]")
    end
  end
end


=end
