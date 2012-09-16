#coding:utf-8

When /^远程启动一个firefox实例(.*)$/ do |profile_name|
  @driver = Mgl::Test::Helper.setup_selenium profile_name
end

When /^远程启动一个firefox,传递一个profile$/ do
  profile_settings = lambda{|profile| return profile['intl.charset.default']='GBK2312'}

  @driver = Mgl::Test::Helper.setup_selenium &profile_settings
end

Then /^关闭firefox$/ do
  @driver.quit
end


