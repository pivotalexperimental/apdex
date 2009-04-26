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
      output = categorize_values(values, threshold)
      output[:score] = calculate_apdex(output)
      output
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

    def categorize_values(values, threshold)
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
      output
    end

    def calculate_apdex(output)
      raw_score = (1.0 *
        (output[:satisfied] + (output[:tolerating]/2)) /
        (output[:satisfied] + output[:tolerating] + output[:frustrated])
      )
      ("%0.3f" % raw_score).to_f
    end
  end
end