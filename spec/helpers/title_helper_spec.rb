require 'spec_helper'

describe TitleHelper do

  it 'sets and gets the title' do
    title('test').should == 'test'
  end

  it 'defaults to showing the title' do
    title('test')
    show_title?.should == true
  end

  it 'will not show the title' do
    title('test', false)
    show_title?.should == false
  end

  it 'gets the title' do
    title('test')
    get_title.should == 'test'
  end
end
