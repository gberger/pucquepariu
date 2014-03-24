require 'spec_helper'

describe ApplicationHelper do
  describe '#facebook_url_to' do
    it "gives the URL to someone's Facebook profile" do
      helper.facebook_url_to('pucquepariu').should eq('https://facebook.com/pucquepariu')
    end
  end

  describe '#facebook_link_to' do
    it "gives the link to someone's Facebook profile" do
      helper.facebook_link_to('pucquepariu').should include('https://facebook.com/pucquepariu')
    end

    xit 'contains an anchor tag' do
      helper.facebook_link_to('pucquepariu').should have_tag('a')
    end

    xit 'contains some icons' do
      helper.facebook_link_to('pucquepariu').should have_tag('i')
    end
  end
end
