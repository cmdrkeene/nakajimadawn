require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tweet do
  it "should create a new instance given valid attributes" do
    Factory(:tweet).should_not be_a_new_record
  end
end
