module Apdex
# See http://www.apdex.org/overview.html
  class CalculateFromLog
    attr_reader :time_column

    def initialize(params={})
      @time_column = params[:time_column] || raise(ArgumentError, "You must specify a time_column")
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
      values = input.map do |line|
        `echo '#{line.strip}' | awk '{print $11}'`.strip.to_f
      end
      output = {}
      output[:satisfied] = output[:tolerating] = output[:frustrated] = 0
      values.each do |value|
        if value <= threshold
          output[:satisfied] += 1
        elsif value <= (threshold * 4)
          output[:tolerating] += 1
        else
          output[:frustrated] += 1
        end
      end
      output[:score] = ("%0.3f" % (1.0 * (output[:satisfied] + output[:tolerating] / 2) / values.size)).to_f
      output
    end
  end
end