# frozen_string_literal: true

class Lamian::SidekiqMiddleware
  def call(*)
    Lamian.run do
      begin
        yield
      rescue
        Raven.extra_context(lamian_log: Lamian.dump(format: :txt))
        raise
      end
    end
  end
end
