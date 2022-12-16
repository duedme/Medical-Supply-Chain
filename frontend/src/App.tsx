import React, { useEffect, useState } from "react";
import { Wallet } from "fuels";
import "./App.css";
// Import the contract factory -- you can find the name in index.ts.
// You can also do command + space and the compiler will suggest the correct name.
import { SupplyChainAbi } from "./contracts";
// The address of the contract deployed the Fuel testnet
const CONTRACT_ID =
  "0x3edb96c23766b8504caaff042994efa18460e7ba27f60191394a6bcf5be8d7d8";
//the private key from createWallet.js
const WALLET_SECRET =
  "0xc4a69e0cc4ce1e0b45d25899b3cedced332d193c8a5c706187ffd50aa7591ce6";
// Create a Wallet from given secretKey in this case
// The one we configured at the chainConfig.json
const wallet = Wallet.fromPrivateKey(
  WALLET_SECRET,
  "https://node-beta-2.fuel.network/graphql"
);


function App() {
  
}
export default App;