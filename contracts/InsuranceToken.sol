// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importando os contratos seguros da OpenZeppelin diretamente do GitHub
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract InsuranceToken is ERC20, Ownable {
    
    // O construtor é executado apenas uma vez, no momento do Deploy
    constructor() ERC20("SeguroToken", "SEGURO") Ownable(msg.sender) {
        // Vamos cunhar (mintar) 1.000.000 de tokens iniciais para a sua carteira
        // O "10 ** decimals()" garante que as casas decimais fiquem corretas (padrão é 18)
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    // Função de segurança que permite apenas ao dono (ou ao contrato de Staking no futuro) criar mais moedas
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}