// ==========================================
// 1. ENDEREÇOS DOS CONTRATOS (Rede Sepolia)
// ==========================================
const ENDERECO_TOKEN = "0xCf9aA519189F71B7A3591DAD94AcE63be8fE318c";
const ENDERECO_STAKING = "0xc7ddd40B422bD37848D73c12584E40186e5AE938";
const ENDERECO_DAO = "0xD66df2f5234D07296BeBF95ae4fDbc95ba7A91e7";
const ENDERECO_NFT = "0x37Ea2B6D3FB7A5d795F601ba55b7A717AA437c52";
const ENDERECO_ORACULO = "0x8d5167a2210110BE9780ECf20E47F809D7F72024";

// ==========================================
// 2. ABIs (O "Manual" de cada contrato)
// Usamos o formato legível (Human-Readable ABI) do Ethers.js
// ==========================================

const ABI_TOKEN = [
    // Funções de leitura
    "function balanceOf(address account) view returns (uint256)",
    "function decimals() view returns (uint8)",
    "function symbol() view returns (string)",
    // Funções de escrita
    "function mint(address to, uint256 amount)",
    "function approve(address spender, uint256 amount) returns (bool)"
];

const ABI_STAKING = [
    // Leitura
    "function balances(address) view returns (uint256)",
    // Escrita
    "function stakeTokens(uint256 amount)",
    "function withdrawTokens(uint256 amount)"
];

const ABI_DAO = [
    // Leitura
    "function claimCount() view returns (uint256)",
    "function claims(uint256) view returns (uint256 policyId, address claimant, uint256 amountRequested, uint256 votesFor, uint256 votesAgainst, bool executed)",
    // Escrita
    "function fileClaim(uint256 _policyId, uint256 _amount)",
    "function vote(uint256 _claimId, bool _support)"
];

const ABI_NFT = [
    // Leitura
    "function balanceOf(address owner) view returns (uint256)",
    "function ownerOf(uint256 tokenId) view returns (address)",
    "function policies(uint256) view returns (uint256 coverageAmount, uint256 expirationDate, bool isActive)",
    // Escrita
    "function mintPolicy(address to, uint256 _coverageAmount, uint256 _durationInDays)"
];

const ABI_ORACULO = [
    // Leitura
    "function obterPrecoAtualETH() view returns (int256)"
];