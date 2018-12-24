# frozen_string_literal: true

module Lamian::ActiveJobExtension
  def self.included(base)
    base.around_perform do |_job, block|
      Thread.current[:__lamian_log] = nil

      Lamian.run do
        begin
          block.call
        rescue
          # Save the log so that it can be accessed from outside the block (e.g. for Sidekiq)
          Thread.current[:__lamian_log] = Lamian.dump
          raise
        end
      end
    end
  end
end
