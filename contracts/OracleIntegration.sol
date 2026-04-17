// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importa a interface oficial da Chainlink para buscar dados de preço
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract OracleIntegration {
    
    AggregatorV3Interface internal priceFeed;

    // O construtor configura o endereço oficial do "mensageiro" da Chainlink na rede Sepolia
    constructor() {
        // Este é o endereço real do contrato da Chainlink que fornece o preço ETH/USD na testnet Sepolia
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    // Função que a nossa DAO vai chamar para saber o preço atualizado do Ethereum em dólares
    function obterPrecoAtualETH() public view returns (int) {
        (
            /* uint80 roundID */,
            int price,
            /* uint startedAt */,
            /* uint timeStamp */,
            /* uint80 answeredInRound */
        ) = priceFeed.latestRoundData();
        
        // Retorna o preço do ETH em USD (vem com 8 casas decimais por padrão na Chainlink)
        return price;
    }
}