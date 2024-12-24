# attest.sh

Simple shell scripts to interact with the Rhinestone Registry.

- `register.sh`: registers a module on the Registry
- `attest.sh`: mock attests to a module (note that this only works on testnets)

## Usage

1. Add a `.env` file based on `.env.example`
2. Run `source .env` to set the env variables (note that the `export` command in the env is required so the env variables should be `export ENV=ENV_VALUE`)
3. Run `chmod +x ./attest.sh` or for the relevant script
4. Run `./attest.sh` or for the relevant script

## Inputs

### `register.sh`

Expects one input, the module address. This should be passed like so:

```sh
./register.sh 0x730DA93267E7E513e932301B47F2ac7D062abC83
```

### `attest.sh`

Expects two inputs, the module address and the array of module type ids. These should be passed like so:

```sh
./attest.sh 0x036CbD53842c5426634e7929541eC2318f3dCF7e '[1,2,3]'
```
