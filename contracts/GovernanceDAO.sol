// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importamos a interface do StakingPool para que a DAO saiba quem tem dinheiro depositado
interface IStakingPool {
    function balances(address account) external view returns (uint256);
}

contract GovernanceDAO {
    
    IStakingPool public stakingPool;

    // Estrutura que representa o pedido de indenização (Sinistro)
    struct Claim {
        uint256 policyId;       // Número da apólice do cliente
        address claimant;       // Carteira do cliente
        uint256 amountRequested;// Valor pedido na indenização
        uint256 votesFor;       // Votos a favor (Aprovar)
        uint256 votesAgainst;   // Votos contra (Rejeitar)
        bool executed;          // Se já foi pago
    }

    uint256 public claimCount;
    mapping(uint256 => Claim) public claims;
    
    // Gaveta de segurança para garantir que uma pessoa não vote duas vezes no mesmo sinistro
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    // O construtor liga a DAO ao nosso cofre (StakingPool)
    constructor(address _stakingPoolAddress) {
        stakingPool = IStakingPool(_stakingPoolAddress);
    }

    // Função para o cliente (segurado) pedir o dinheiro do seguro
    function fileClaim(uint256 _policyId, uint256 _amount) public {
        claimCount++;
        claims[claimCount] = Claim({
            policyId: _policyId,
            claimant: msg.sender,
            amountRequested: _amount,
            votesFor: 0,
            votesAgainst: 0,
            executed: false
        });
    }

    // Função para os investidores votarem (true = aprovar, false = rejeitar)
    function vote(uint256 _claimId, bool _support) public {
        require(!hasVoted[_claimId][msg.sender], "Voce ja votou neste sinistro!");
        
        // A DAO vai no StakingPool e pergunta: "Quanto dinheiro essa pessoa tem em staking?"
        uint256 voterWeight = stakingPool.balances(msg.sender);
        require(voterWeight > 0, "Apenas investidores com tokens travados podem votar!");

        // O peso do voto é igual à quantidade de tokens que a pessoa investiu
        if (_support) {
            claims[_claimId].votesFor += voterWeight;
        } else {
            claims[_claimId].votesAgainst += voterWeight;
        }

        // Registra que a pessoa já votou para bloquear fraudes
        hasVoted[_claimId][msg.sender] = true;
    }
}