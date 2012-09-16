#coding:utf-8
require 'selenium-webdriver'
require 'cucumber/rb_support/rb_dsl'

module Mgl
  module Test
    module Helper

      # 启动Webdriver
      # @return driver
      def self.setup_selenium profile_name='',url = 'http://localhost:4444/wd/hub',timeouts = 5,&profile_settings
        profile = Selenium::WebDriver::Firefox::Profile.from_name profile_name
        profile = Selenium::WebDriver::Firefox::Profile.new  if profile.nil?
        profile["intl.accept_languages"] = "zh-cn,zh"
        profile_settings.call(profile) unless profile_settings.nil?
        caps = Selenium::WebDriver::Remote::Capabilities.firefox(:firefox_profile => profile)

        client = Selenium::WebDriver::Remote::Http::Default.new
        client.timeout = 180 # seconds
        driver = Selenium::WebDriver.for(:remote,:url => url,:http_client => client,:desired_capabilities => caps)
        driver.manage.timeouts.implicit_wait = timeouts

        return driver
      end

      #场景失败就截图保存下来
      def self.screenshot_for_failed scenario,driver
        if scenario.failed?
          url = driver.current_url
          unless url.empty?
            puts "错误的截图的url = #{url}" #打印出url，便于复查
            screenshot_name = url.gsub(/[\.\/:,?|]/,'_') + '.png' #去除特殊符号，用_代替
            filePath = File.join("..","Reports",ENV['BUILD_NUMBER'],"screenshot",screenshot_name) #注意:截图路径与rake_helper.rb同步修改
            driver.save_screenshot(filePath)
          end
        end
      end

      #关闭测试中打开的窗口，回到主窗口
      def self.back_mainwindow driver,main_handle
        for handle in driver.window_handles
          driver.switch_to.window handle
          if handle != main_handle
            driver.close
          end
        end

        driver.switch_to.window main_handle
        return driver
      end

      #检查url是否需要测试
      def self.valid_url url,all_test_urls,step
        @url_valid = false
        all_test_urls.each do |oneline|
          @url_valid = true if oneline.include? url
        end

        step.pending "#{url}不在测试范围" unless @url_valid
      end

    end # Helper
  end # Test
end # Mgl


