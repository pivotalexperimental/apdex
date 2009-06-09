module Apdex
# See http://www.apdex.org/overview.html
  class CalculateFromLog
    attr_reader :time_column

    def initialize(params={})
      @time_column = params[:time_column]
    end

    def print(threshold, input)
      values = call(threshold, input)
      [
        "Score: #{values[:score]}",
        "Satisfied: #{values[:satisfied]}",
        "Tolerating: #{values[:tolerating]}",
        "Frustrated: #{values[:frustrated]}",
      ].join("\n")
    end

    def call(threshold, input)
      values = value_from_input(input)
      Calculate.new.call(threshold, values)
    end
    
    protected

    def value_from_input(input)
      if time_column
        input.map do |line|
          `echo '#{line.strip}' | awk '{print $11}'`.strip.to_f
        end
      else
        input.map do |line|
          line.strip.to_f
        end
      end
    end
  end
end