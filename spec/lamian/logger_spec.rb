# frozen_string_literal: true
describe Lamian::Logger, :cool_loggers do
  specify '#run' do
    Lamian.run do
      generic_logger.info "it's alive"
      expect(Lamian.dump).to eq "it's alive\n"
    end
  end

  describe '#dump' do
    specify 'with #run' do
      Lamian.run do
        generic_logger.info "it's alive"
        expect(Lamian.dump).to eq "it's alive\n"
        expect(Lamian.dump).to eq "it's alive\n"
      end
    end

    specify 'without #run' do
      generic_logger.info "it's alive"
      expect { Lamian.dump }.not_to raise_error
      expect(Lamian.dump).to be_nil
    end
  end
end
