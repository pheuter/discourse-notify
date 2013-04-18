#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'yaml'

module OS
  def OS.is_mac?
    RUBY_PLATFORM.downcase.include?("darwin")
  end

  def OS.is_linux?
    RUBY_PLATFORM.downcase.include?("linux")
  end
end

module API
  def API.getAllNotifications
    uri = URI('http://disc.crowdtwist.com/discourse/notifications.json')

    req = Net::HTTP::Get.new uri.request_uri
    req['Cookie'] = "_access=1178doit;_t=#{AUTH_COOKIE};"

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request req
    end

    unless res['Status'].match(/200/)
      throw "Could not authenticate, check _t value in config.yml!"
    else
      return JSON.parse res.body
    end
  end
end


if OS.is_linux?
  require 'gir_ffi'
  GirFFI.setup :Notify
  Notify.init("CrowdTwist Discourse")
end


AUTH_COOKIE = YAML.load_file('config.yml')['_t']

puts "Running discourse-notify..."

notifications = []
loop do
  sleep 3

  allNotifications = API.getAllNotifications
  latestNotification = allNotifications[0]

  if notifications.length > 0
    unless notifications[0] == latestNotification
      slug = latestNotification['slug']
      topicId = latestNotification['topic_id']
      postNumber = latestNotification['post_number']
      topicTitle = latestNotification['data']['topic_title']
      displayUsername = latestNotification['data']['display_username']

      title = "CrowdTwist Discourse"
      url = "http://disc.crowdtwist.com/discourse/t/#{slug}/#{topicId}/#{postNumber}"

      message = ""
      message += "New post by #{displayUsername}" if displayUsername
      message += " for topic '#{topicTitle}'" if topicTitle

      if OS.is_mac?
        `terminal-notifier -title "#{title}" -message "#{message}" -open "#{url}"`
      elsif OS.is_linux?
        linuxNotification = Notify::Notification.new(title, message, "dialog-information")
        linuxNotification.show
      end

      puts "#{title}: #{message} - #{url}"
    end
  end

  notifications = allNotifications
end