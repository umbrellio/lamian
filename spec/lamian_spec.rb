# frozen_string_literal: true
describe Lamian do
  it 'has a version number' do
    expect(Lamian::VERSION).not_to be nil
  end

  specify '.dump', :cool_loggers do
    Lamian.run do
      generic_logger.info '[23mNice, lol[0m'
      expect(Lamian.dump).to eq "[23mNice, lol[0m\n"
      expect(Lamian.dump(format: :text)).to eq "Nice, lol\n"
    end
  end
end
