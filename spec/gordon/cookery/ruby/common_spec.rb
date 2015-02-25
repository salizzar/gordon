require 'spec_helper'

describe Gordon::Cookery::Ruby::Common do
  describe 'default blacklist' do
    it 'maps common files' do
      expected = %w(.rspec coverage log spec tmp)

      expect(described_class::RUBY_BLACKLIST_FILES).to eq(expected)
    end
  end
end

