// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract InsurancePolicy is ERC721, Ownable {
    
    // Contador para dar um ID único para cada apólice (NFT) criada
    uint256 private _nextTokenId;

    // Estrutura de dados que guarda as regras do seguro direto na blockchain
    struct Policy {
        uint256 coverageAmount; // Valor da cobertura (ex: 5000 dólares)
        uint256 expirationDate; // Data de validade
        bool isActive;          // Se o seguro está ativo ou se já foi pago/cancelado
    }

    // "Gaveta" que liga o número do NFT aos dados da apólice
    mapping(uint256 => Policy) public policies;

    // O construtor define o nome e o símbolo do nosso NFT
    constructor() ERC721("Apolice Seguradora", "APOLICE") Ownable(msg.sender) {}

    // Função que "vende" o seguro, criando o NFT e salvando as regras
    function mintPolicy(address to, uint256 _coverageAmount, uint256 _durationInDays) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        
        // Registra as regras matemáticas desta apólice específica
        policies[tokenId] = Policy({
            coverageAmount: _coverageAmount,
            // block.timestamp pega o horário exato da rede e soma os dias de validade
            expirationDate: block.timestamp + (_durationInDays * 1 days),
            isActive: true
        });

        // Fabrica o NFT e envia para a carteira do cliente ('to')
        _safeMint(to, tokenId);
    }
}