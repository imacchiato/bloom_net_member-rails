module StellarLookoutProcessing
  class ProcessOperation

    extend LightService::Organizer

    def self.call(operation)
      if payment_for_claim?(operation)
        ProcessOperationAsPaymentForClaim.(operation)
      elsif payment_for_txn?(operation)
        ProcessOperationAsPaymentForTxn.(operation)
      end
    end

    private

    def self.payment_for_claim?(operation)
      payment_to_our_address?(operation) &&
        Claim.exists?(txn_ref_no: operation.txn.memo)
    end

    def self.payment_for_txn?(operation)
      Txn.exists?(address: operation.to, ref_no: operation.txn.memo)
    end

    def self.payment_to_our_address?(operation)
      operation.to == Settings.bloom_net_address
    end

  end
end
