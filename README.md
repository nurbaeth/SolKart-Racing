# 🏎️ SolKart Racing

**SolKart Racing** is a fully on-chain kart racing game written in Solidity. Players join the race, choose their karts, and compete in randomized races — all happening on the Ethereum Virtual Machine.

> No tokens. No gambling. Just pure fun and fair racing, powered by smart contracts.

---

## 🚀 Features

- ✅ Player registration
- 🏁 Kart selection
- 🎲 On-chain race simulation with pseudo-random outcomes
- 🏆 Leaderboard tracking wins
- 🔐 Fully transparent, decentralized gameplay

---

## 🧠 How It Works

1. Up to 5 players join a race by choosing a kart.
2. Once the race is full, it starts automatically.
3. Each player is assigned a random "speed".
4. The player with the highest speed wins.
5. A new race starts automatically.

---

## ⚙️ Smart Contract

- Language: **Solidity**
- Version: `^0.8.24`
- Deployed to: *Any EVM-compatible testnet/mainnet*
- No external dependencies

---

## 🛠️ Example Usage (with Hardhat)

```bash
git clone https://github.com/your-username/solkart-racing.git
cd solkart-racing
npm install
npx hardhat test
