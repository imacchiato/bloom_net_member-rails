module Txns
  module Operation
    class Create < ApplicationOperation

      include Model
      model Txn, :create

      contract Contract::Create

      include Dispatch
      callback(:after_create) { on_change(:after_create) }

      def process(params)
        validate(params[:txn]) do |f|
          f.save
        end
      end

      def after_create(form, **)
        ActiveRecord::Base.after_transaction do
          Txns::Callback::AfterCreateJob.perform_later(txn)
        end
      end

    end
  end
end