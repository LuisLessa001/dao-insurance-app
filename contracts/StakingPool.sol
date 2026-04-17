// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// 1. Importando a proteção contra reentrância da OpenZeppelin
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

// 2. Avisando que o contrato herda essa proteção (is ReentrancyGuard)
contract StakingPool is ReentrancyGuard {
    
    IERC20 public tokenSeguro;
    mapping(address => uint256) public balances;

    constructor(address _enderecoDoToken) {
        tokenSeguro = IERC20(_enderecoDoToken);
    }

    function stakeTokens(uint256 amount) public {
        require(amount > 0, "O valor de deposito deve ser maior que zero");
        tokenSeguro.transferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
    }

    // 3. Adicionando a "trava" (nonReentrant) na função de saque
    function withdrawTokens(uint256 amount) public nonReentrant {
        require(balances[msg.sender] >= amount, "Saldo insuficiente para saque");
        
        balances[msg.sender] -= amount;
        tokenSeguro.transfer(msg.sender, amount);
    }
}