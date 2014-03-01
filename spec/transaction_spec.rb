require 'spec_helper'

describe BlockchainInfo::Transaction do

  let(:transactionA) { '683f45578328242a06bc5c54acbcbe6e70a5435b4561fc8b0570a59ab09f8bfa' }
  subject(:transaction) { described_class.find(transactionA) }

  describe '.find' do
    use_vcr_cassette

    it "returns a Transaction object" do
      expect(transaction).to be_a described_class
    end

  end

  describe '#total_output' do
    use_vcr_cassette
    it "returns the total output" do
      expect(transaction.total_output).to eq(BigDecimal("0.266304790E0"))
    end
  end

  describe '#total_input' do
    use_vcr_cassette
    it "returns the total input" do
      expect(transaction.total_input).to eq(BigDecimal("0.26630479E0"))
    end
  end
end
