=begin
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/people/edit.html.erb" do
  include PeopleHelper
  
  before(:each) do
    assigns[:person] = @person = stub_model(Person,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "should render edit form" do
    render "/people/edit.html.erb"
    
    response.should have_tag("form[action=#{person_path(@person)}][method=post]") do
      with_tag('input#person_name[name=?]', "person[name]")
    end
  end
end
=end


