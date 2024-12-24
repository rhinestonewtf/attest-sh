# Check inputs
if [ $# -eq 0 ];
then
  echo "$0: Missing module address"
  exit 1
elif [ $# -gt 1 ];
then
  echo "$0: Too many arguments: $@"
  exit 1
fi

# Check required addresses
# Registry 
code=$(cast code 0x000000000069E2a187AEFFb852bF3cCdC95151B2 --rpc-url "$RPC_URL")
if [ "$code" == "0x" ]; then
    printf '%s\n' "Error: Registry not deployed" >&2
    exit 1
fi

# Register module 
code=$(cast call 0x000000000069E2a187AEFFb852bF3cCdC95151B2 "findModule(address)" "$1" --rpc-url "$RPC_URL")
resolverUID=$(echo "$code" | cut -c 67-130)
if [ "$resolverUID" == "0000000000000000000000000000000000000000000000000000000000000000" ]; then
    cast send 0x000000000069E2a187AEFFb852bF3cCdC95151B2 "registerModule(bytes32,address,bytes,bytes)" 0xdbca873b13c783c0c9c6ddfc4280e505580bf6cc3dac83f8a0f7b44acaafca4f "$1" 0x 0x --rpc-url "$RPC_URL" --private-key "$PRIVATE_KEY"
fi
printf '%s\n' "Module registered" >&2

