module Apdex
end

dir = File.dirname(__FILE__)
require "#{dir}/apdex/calculate"
require "#{dir}/apdex/calculate_from_log"