module API
  module ErrorFormatter
    def self.call message, backtrace, options, env, original_exception
      {status: "error", response: message}.to_json
    end
  end
end
