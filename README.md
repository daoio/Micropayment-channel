# Micropayment-channel
Unidirectional micropayment channel for sending transactions off-chain and subsequent confirmation of final tx on-chain

# Execution
After the contract is deployed, it sets the addresses of the owner and recipient and the time of execution of the contract, then the owner deposits funds into the contract, makes off-chain transactions and signs them, sending the recipient his digital signature and the hash of the message signed by him.
As soon as all transactions are completed and the time for their execution has expired, the recipient can take his funds by providing the signature and hash received by him. The claimPayment() function verifies the authenticity of the data provided and if everything turns out to be correct, the contract makes the final transaction in favor of the recipient
