#!/usr/bin/env ruby

module OS
  def OS.is_mac?
    RUBY_PLATFORM.downcase.include?("darwin")
  end

  def OS.is_windows?
    RUBY_PLATFORM.downcase.include?("mswin")
  end

  def OS.is_linux?
    RUBY_PLATFORM.downcase.include?("linux")
  end
end


