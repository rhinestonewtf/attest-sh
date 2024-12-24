# Check inputs
if [ $# -eq 0 ];
then
  echo "$0: Missing module address and module type ids"
  exit 1
elif [ $# -eq 1 ];
then
  echo "$0: Missing module address or module type ids"
  exit 1
fi

# Register module
./register.sh "$1"

# Check required addresses
# Mock Attester 
code=$(cast code 0xA4C777199658a41688E9488c4EcbD7a2925Cc23A --rpc-url "$RPC_URL")
if [ "$code" == "0x" ]; then
    printf '%s\n' "Error: Mock Attester not deployed" >&2
    exit 1
fi


# Attest module 
code=$(cast call 0x000000000069E2a187AEFFb852bF3cCdC95151B2 "findAttestation(address,address)" "$1" 0xA4C777199658a41688E9488c4EcbD7a2925Cc23A --rpc-url "$RPC_URL")
attestationTime=$(echo "$code" | cut -c 3-66)
if [ "$attestationTime" == "0000000000000000000000000000000000000000000000000000000000000000" ]; then
    cast send 0xA4C777199658a41688E9488c4EcbD7a2925Cc23A "attest(address,bytes32,(address,uint48,bytes,uint256[]))" 0x000000000069E2a187AEFFb852bF3cCdC95151B2 0x93d46fcca4ef7d66a413c7bde08bb1ff14bacbd04c4069bb24cd7c21729d7bf1 "($1, 0, 0x41414141414141, $2)" --rpc-url "$RPC_URL" --private-key "$PRIVATE_KEY"
fi
printf '%s\n' "Module registered" >&2

