# Default exception handler. Just logs to the logger and re-raise
# so the exception can be managed as usual.

module SimplerWorkflow
  class DefaultExceptionReporter
    attr_accessor :reporter, :tag

    def initialize(&block)
      @reporter = block if block_given?
    end

    def report(e, context = {})
      reporter.call(e, context) if reporter
    ensure
      SimplerWorkflow.logger.error("[#{tag}] Exception: #{e.message}")
      SimplerWorkflow.logger.error("[#{tag}] Context: #{context.inspect}") unless context.empty?
      SimplerWorkflow.logger.error("[#{tag}] Backtrace:\n#{e.backtrace.join("\n")}")
    end

    def tag
      @tag || "SimplerWorkflow"
    end
  end
end
