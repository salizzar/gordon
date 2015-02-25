require 'spec_helper'

describe Gordon::Cookery::Java::Common do
  describe 'default blacklist' do
    it 'maps common files' do
      expected = %w()

      expect(described_class::JAVA_BLACKLIST_FILES).to eq(expected)
    end
  end
end

