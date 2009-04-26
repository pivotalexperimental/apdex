require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

module Apdex
  describe CalculateFromLog do
    attr_reader :input, :command

    def use_single_column_input
      @input = StringIO.new((<<-LOG).gsub(/^ +/, ""))
        0.100
        0.200
        0.300
        0.600
        1.000
        3.000
      LOG
    end

    def use_log_input
      @input = StringIO.new((<<-LOG).gsub(/^ +/, ""))
        204.16.153.246 - performatron [23/Apr/2009:16:57:27 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4282 0.100 "-" "httperf/0.9.0" "-"
        204.16.153.246 - performatron [23/Apr/2009:16:57:28 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4275 0.200 "-" "httperf/0.9.0" "-"
        204.16.153.246 - performatron [23/Apr/2009:16:57:28 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4282 0.300 "-" "httperf/0.9.0" "-"
        204.16.153.246 - performatron [23/Apr/2009:16:57:29 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4255 0.600 "-" "httperf/0.9.0" "-"
        204.16.153.246 - performatron [23/Apr/2009:16:57:30 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4275 1.000 "-" "httperf/0.9.0" "-"
        204.16.153.246 - performatron [23/Apr/2009:16:57:30 -0700] "GET /myspace/compatibility/friend_model_matchings/new?model_id=17702&myspace_id=454017886 HTTP/1.1" 200 4269 3.000 "-" "httperf/0.9.0" "-"
      LOG
    end

    describe "#print" do
      before do
        use_log_input
        @command = CalculateFromLog.new(:time_column => 11)
      end
      
      it "returns the Apdex output in a formatted string" do
        command.print(0.5, input).should == (<<-OUT).gsub(/^ +/, "").strip
        Score: 0.667
        Satisfied: 3
        Tolerating: 2
        Frustrated: 1
        OUT
      end
    end

    describe "#call" do
      context "when the time column is not set" do
        before do
          use_single_column_input
          @command = CalculateFromLog.new
        end

        it "returns the Apdex score based on the input" do
          output = command.call(0.5, input)
          output[:satisfied].should == 3
          output[:tolerating].should == 2
          output[:frustrated].should == 1
          output[:score].should == 0.667
        end
      end

      context "when the time column is set" do
        before do
          use_log_input
          @command = CalculateFromLog.new(:time_column => 11)
        end

        it "returns the Apdex score based on the passed-in column in the input log" do
          output = command.call(0.5, input)
          output[:satisfied].should == 3
          output[:tolerating].should == 2
          output[:frustrated].should == 1
          output[:score].should == 0.667
        end
      end
    end
  end
end
