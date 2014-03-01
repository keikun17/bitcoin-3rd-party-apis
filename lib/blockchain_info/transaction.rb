class BlockchainInfo::Transaction

  attr_accessor :block_height, :inputs, :out 
  def initialize(args)
    @block_height = args['block_height']
    @inputs = args['inputs']
    @out = args['out']
  end

  def self.find(transaction)
    url = "#{single_transaction_url}/#{transaction}"
    json = get_json(url)
    transaction = self.new(json)
    transaction
  end

  def total_output
    array = @out.collect{|h| h['value']}
    satoshi = array.inject{|sum, x| sum + x}
    satoshi_to_bitcoins BigDecimal(satoshi)
  end

  def total_input
    array = @inputs.collect{|x| x["prev_out"]["value"]}
    satoshi = array.inject{|sum, x| sum + x}
    satoshi_to_bitcoins BigDecimal(satoshi)
  end

  private

  def self.single_transaction_url
    "#{BlockchainInfo.domain}/rawtx"
  end

  #FIXME : not DRY, this is lifted off of BlockChainInfo::BlockChain's private
  #method
  def satoshi_to_bitcoins(satoshi)
    satoshi / (10 ** 8)
  end

  #FIXME : not DRY, this is lifted off of BlockChainInfo::BlockChain's private
  #method
  def self.get_json(url)
    JSON.parse open(url).read
  end

end
