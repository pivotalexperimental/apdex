require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

module Apdex
  describe CalculateFromLog do
    describe "#call" do
      it "returns the Apdex score based on the input log" do
        input = StringIO.new((<<-LOG).gsub(/^ +/, ""))
        204.16.153.246 - performatron [23/Apr/2009:16:57:27 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4282 0.100 "-" "httperf/0.9.0" "-"
        204.16.153.246 - performatron [23/Apr/2009:16:57:28 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4275 0.200 "-" "httperf/0.9.0" "-"
        204.16.153.246 - performatron [23/Apr/2009:16:57:28 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4282 0.300 "-" "httperf/0.9.0" "-"
        204.16.153.246 - performatron [23/Apr/2009:16:57:29 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4255 0.600 "-" "httperf/0.9.0" "-"
        204.16.153.246 - performatron [23/Apr/2009:16:57:30 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4275 1.000 "-" "httperf/0.9.0" "-"
        204.16.153.246 - performatron [23/Apr/2009:16:57:30 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4269 3.000 "-" "httperf/0.9.0" "-"
        LOG

        output = CalculateFromLog.new(11).call(0.5, input)
        output[:satisfied].should == 3
        output[:tolerating].should == 2
        output[:frustrated].should == 1
        output[:score].should == 0.67
      end
    end
  end
end
