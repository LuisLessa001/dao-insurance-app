# DeFi Insurance Protocol

MVP de um protocolo descentralizado de seguros desenvolvido para a avaliação da Fase 2 Avançada. App de seguros DeFi com votação on-chain, NFTs de apólice e integração de oráculo. O sistema permite o fornecimento de liquidez, emissão de apólices como NFTs e governança descentralizada para aprovação de sinistros.

##  Arquitetura de Smart Contracts
- **InsuranceToken.sol (ERC-20):** Token de utilidade e governança.
- **StakingPool.sol:** Fundo de liquidez (Cofre) protegido contra reentrancy.
- **InsurancePolicy.sol (ERC-721):** Emissão das apólices de seguro como NFTs intransferíveis.
- **GovernanceDAO.sol:** Sistema de votação para aprovação ou rejeição de sinistros.
- **OracleIntegration.sol:** Integração com Chainlink para cotação em tempo real.

##  Tecnologias Utilizadas
- **Linguagem:** Solidity ^0.8.20
- **Bibliotecas:** OpenZeppelin (Ownable, ReentrancyGuard)
- **Frontend:** HTML, CSS, JavaScript (ethers.js)
- **Rede de Testes:** Sepolia Testnet