module Helpers
  module Servers
    class SimpleServer
      OUT_FILE  = 'tmp/listener.log'

      attr_reader :path

      def initialize
        @path = 'http://localhost:8000/'
      end

      def run
        cmd = "python -m SimpleHTTPServer &> #{OUT_FILE}"
        @pid = Process.spawn(cmd)
      end

      def terminate
        Process.kill(:SIGINT, @pid)
        Process.kill(:SIGINT, @pid + 1)
        clean_up
      end

      def read_logs
        CGI.unescape(File.read(OUT_FILE))
      end

      private

      def clean_up
        @pid = nil
        File.delete(OUT_FILE)
      end
    end
  end
end