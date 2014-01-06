class App.PendingTransactionsView extends App.MasterView

  tpl: "pending-transaction-tpl"

  collection: null

  payments: null

  initialize: (options = {})->
    $.subscribe "new-balance", @onNewBalance
    @payments = options.payments

  render: ()->
    @collection.fetch
      success: ()=>
        @collection.each (transaction)=>
          @$el.append @template
            transaction: transaction
    @payments.fetch
      success: ()=>
        @payments.each (payment)=>
          @$el.append @template
            payment: payment

  onNewBalance: (ev, data)=>
    #TODO: Implement
