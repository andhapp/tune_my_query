$: << File.join(File.dirname(__FILE__), "..", "lib")

require "tune_my_query/tune_my_query"
Dir.glob("#{File.dirname(__FILE__)}/tune_my_query/commands/*.*").each{|file| require file}

ActiveRecord::Base.send(:include, TuneMyQuery)