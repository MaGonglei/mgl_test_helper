#coding:utf-8
require 'rake'

task :setup do
  puts "准备测试环境"
  puts "更新Gemfile.lock文件"
  system "bundle update"
  puts "建立相关的文件夹"
  $report_dir = File.join "..","Reports",ENV['BUILD_NUMBER']
  $screenshot_dir = File.join $report_dir,"screenshot"
  $tmp_dir = File.join $report_dir,"tmp"
  FileUtils.mkdir_p $screenshot_dir
  FileUtils.mkdir_p $tmp_dir

  #cucumber 相关的profile
  $default_profile = "-f pretty -f junit -o #{$tmp_dir} -f html -o #{$report_dir}/result.html -f rerun -o rerun.txt"
  $rerun_profule = "@rerun.txt -f pretty -f html -o #{$report_dir}/rerun.html"
end


task :all => :setup do
  puts "执行全部测试"
  system "cucumber features #{$default_profile}"
end

task :default => :all


# top_level_tasks is't writable so we need to do this ugly
# instance_variable_set hack...
current_tasks =  Rake.application.top_level_tasks
current_tasks << :rerun
current_tasks << :delete_url_txt
Rake.application.instance_variable_set(:@top_level_tasks, current_tasks)


task :rerun do
  if File.size('rerun.txt') != 0
    puts "重新执行错误的用例"
    system "cucumber " + $rerun_profule
  end
end


desc "删除每次上传的url.txt"
task :delete_url_txt do
  File.delete 'url.txt' if File.exist? 'url.txt'
end
