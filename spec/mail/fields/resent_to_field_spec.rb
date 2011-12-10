# encoding: utf-8
require 'spec_helper'
# 
# resent-to       =       "Resent-To:" address-list CRLF

describe Mail::ResentToField do
  
  describe "initialization" do

    it "should initialize" do
      doing { Mail::ResentToField.new("ResentTo", "Mikel") }.should_not raise_error
    end

    it "should mix in the CommonAddress module" do
      Mail::ResentToField.included_modules.should include(Mail::CommonAddress) 
    end

    it "should accept a string with the field name" do
      t = Mail::ResentToField.new('Resent-To: Mikel Lindsaar <mikel@test.lindsaar.net>, "Bob Smith" <bob@me.com>')
      t.name.should eql 'Resent-To'
      t.value.should eql 'Mikel Lindsaar <mikel@test.lindsaar.net>, "Bob Smith" <bob@me.com>'
    end

    it "should accept a string without the field name" do
      t = Mail::ResentToField.new('Mikel Lindsaar <mikel@test.lindsaar.net>, "Bob Smith" <bob@me.com>')
      t.name.should eql 'Resent-To'
      t.value.should eql 'Mikel Lindsaar <mikel@test.lindsaar.net>, "Bob Smith" <bob@me.com>'
    end

  end
  
  # Actual testing of CommonAddress methods oResentTours in the address field spec file

  describe "instance methods" do
    it "should return an address" do
      t = Mail::ResentToField.new('Mikel Lindsaar <mikel@test.lindsaar.net>')
      t.formatted.should eql ['Mikel Lindsaar <mikel@test.lindsaar.net>']
    end

    it "should return two addresses" do
      t = Mail::ResentToField.new('Mikel Lindsaar <mikel@test.lindsaar.net>, Ada Lindsaar <ada@test.lindsaar.net>')
      t.formatted.first.should eql 'Mikel Lindsaar <mikel@test.lindsaar.net>'
      t.addresses.last.should eql 'ada@test.lindsaar.net'
    end

    it "should return one address and a group" do
      t = Mail::ResentToField.new('sam@me.com, my_group: mikel@me.com, bob@you.com;')
      t.addresses[0].should eql 'sam@me.com'
      t.addresses[1].should eql 'mikel@me.com'
      t.addresses[2].should eql 'bob@you.com'
    end
    
    it "should return the formatted line on to_s" do
      t = Mail::ResentToField.new('sam@me.com, my_group: mikel@me.com, bob@you.com;')
      t.value.should eql 'sam@me.com, my_group: mikel@me.com, bob@you.com;'
    end
    
    it "should return the encoded line" do
      t = Mail::ResentToField.new('sam@me.com, my_group: mikel@me.com, bob@you.com;')
      t.encoded.should eql "Resent-To: sam@me.com, \r\n\smy_group: mikel@me.com, \r\n\sbob@you.com;\r\n"
    end
    
  end
  
  
end
