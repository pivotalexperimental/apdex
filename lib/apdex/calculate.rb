module Apdex
  class Calculate
    def call(threshold, times)
      output = categorize_times(threshold, times)
      output[:score] = calculate_apdex(output)
      output
    end

    protected

    def categorize_times(threshold, times)
      output = {}
      output[:satisfied] = output[:tolerating] = output[:frustrated] = 0
      times.each do |value|
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
        (output[:satisfied] + (output[:tolerating]/2.0)) /
        (output[:satisfied] + output[:tolerating] + output[:frustrated])
      )
      ("%0.3f" % raw_score).to_f
    end
  end
end