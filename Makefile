-include .env
deployAndVerify:
	@forge create --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --constructor-args 10 --etherscan-api-key $(ETHERSCAN_API_KEY) --verify src/Whitelist.sol:Whitelist

verify:
	@forge verify-contract 0xDE5264Da32661A72398b36c620F77D30A192F345 Whitelist --chain-id 11155111 --etherscan-api-key $(ETHERSCAN_API_KEY)