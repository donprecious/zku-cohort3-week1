#!/bin/bash

cd contracts/circuits

mkdir RangeProof

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling HelloWorld.circom..."

# compile circuit

circom RangeProof.circom --r1cs --wasm --sym -o RangeProof

# node RangeProof/LessThan10_js/generate_witness.js LessThan10/LessThan10_js/LessThan10.wasm lessThan10_input.json LessThan10/witness.wtns

# snarkjs r1cs info LessThan10/LessThan10.r1cs

# # Start a new zkey and make a contribution

# snarkjs groth16 setup LessThan10/LessThan10.r1cs powersOfTau28_hez_final_10.ptau LessThan10/LessThan10_circuit_0000.zkey
# snarkjs zkey contribute LessThan10/LessThan10_circuit_0000.zkey LessThan10/LessThan10_circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
# snarkjs zkey export verificationkey LessThan10/LessThan10_circuit_final.zkey LessThan10/verification_key.json

# # generate solidity contract
# #snarkjs zkey export solidityverifier HelloWorld/circuit_final.zkey ../HelloWorldVerifier.sol

# #generating the proof 
# snarkjs groth16 prove LessThan10/LessThan10_circuit_final.zkey LessThan10/witness.wtns LessThan10/proof.json LessThan10/public.json


cd ../..