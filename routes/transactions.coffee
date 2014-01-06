Payment = require "../models/payment"
Transaction = require "../models/transaction"
JsonRenderer = require "../lib/json_renderer"

module.exports = (app)->

  app.get "/transactions/pending/:wallet_id", (req, res)->
    walletId = req.params.wallet_id
    if req.user
      Transaction.findPendingByUserAndWallet req.user.id, walletId, (err, transactions)->
        console.error err  if err
        return JsonRenderer.error "Sorry, could not get pending transactions...", res  if err
        res.json JsonRenderer.transactions transactions
    else
      JsonRenderer.error "Please auth.", res

  app.get "/transactions/processed/:wallet_id", (req, res)->
    walletId = req.params.wallet_id
    if req.user
      Transaction.findProcessedByUserAndWallet req.user.id, walletId, (err, transactions)->
        console.error err  if err
        return JsonRenderer.error "Sorry, could not get processed transactions...", res  if err
        res.json JsonRenderer.transactions transactions
    else
      JsonRenderer.error "Please auth.", res

  app.get "/transactions/:id", (req, res)->
    id = req.params.id
    if req.user
      Transaction.findOne {_id: id}, (err, transaction)->
        console.error err  if err
        return JsonRenderer.error "Sorry, could not find transaction...", res  if err
        res.json JsonRenderer.transaction transaction
    else
      JsonRenderer.error "Please auth.", res