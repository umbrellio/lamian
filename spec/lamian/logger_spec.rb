# frozen_string_literal: true
describe Lamian::Logger, :cool_loggers do
  specify '#run' do
    Lamian.run do
      generic_logger.info "it's alive"
      expect(Lamian.dump).to eq "it's alive\n"
    end
  end
end
