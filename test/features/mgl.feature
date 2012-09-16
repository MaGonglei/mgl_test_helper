#coding:utf-8

Feature: SouFun Test Framework Library

  Scenario Outline: 启动Webdriver
    When 远程启动一个firefox实例<profile>
    Then 关闭firefox

  Examples:
    |profile|
    |''|
    |'webdriver'|
    |'nothing'|

  Scenario: Firefox动态设置profile
    When 远程启动一个firefox,传递一个profile
    Then 关闭firefox


