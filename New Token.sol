// SPDX-License-Identifier: MIT
// Declaração da licença do código, especificando que o código está licenciado sob a licença MIT.
pragma solidity ^0.8.26;
// Define a versão do Solidity a ser utilizada para compilar o contrato. O símbolo ^ indica que qualquer versão compatível com 0.8.26 pode ser usada.

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// Importa o contrato ERC20 da biblioteca OpenZeppelin. Este contrato fornece funcionalidades padrão para tokens ERC20, como transferência e saldo de tokens.

import "@openzeppelin/contracts/access/Ownable.sol";
// Importa o contrato Ownable da biblioteca OpenZeppelin. Este contrato permite que o contrato tenha um único proprietário e fornece funções para transferir a propriedade.

contract NewToken is ERC20, Ownable {
// Define o contrato `NewToken`, que herda as funcionalidades dos contratos ERC20 e Ownable.
    uint256 public constant MAX_SUPPLY = 1000000 * 10 ** 18;
    // Define uma constante pública `MAX_SUPPLY` que especifica o fornecimento máximo de tokens (1 milhão de tokens, ajustado para 18 casas decimais).

    constructor(address initialOwner) ERC20("NewToken", "NTK") Ownable() {
    // Construtor do contrato. É chamado quando o contrato é implantado.
    // Recebe um argumento `initialOwner`, que será definido como o proprietário do contrato.
    // Inicializa o contrato ERC20 com o nome "NewToken" e o símbolo "NTK".
    // Inicializa o contrato Ownable, definindo o criador do contrato como o proprietário inicial.
        _mint(msg.sender, MAX_SUPPLY);
        // Cria a quantidade total de tokens permitidos (`MAX_SUPPLY`) e os atribui ao endereço do criador do contrato (`msg.sender`).
        transferOwnership(initialOwner);
        // Transfere a propriedade do contrato para o endereço `initialOwner`, definido no construtor.
    }

    function mint(address to, uint256 amount) public onlyOwner {
    // Define uma função pública `mint` que só pode ser chamada pelo proprietário do contrato (`onlyOwner`).
    // Permite ao proprietário criar novos tokens e enviá-los para o endereço `to`.
        require(totalSupply() + amount <= MAX_SUPPLY, "Minting would exceed max supply");
        // Verifica se a criação de novos tokens (`amount`) não fará com que o total supply exceda o limite máximo (`MAX_SUPPLY`).
        _mint(to, amount);
        // Cria os tokens e os envia para o endereço `to`.
    }

    function burn(uint256 amount) public onlyOwner {
    // Define uma função pública `burn` que só pode ser chamada pelo proprietário do contrato (`onlyOwner`).
    // Permite ao proprietário destruir (queimar) tokens do próprio saldo.
        _burn(msg.sender, amount);
        // Remove `amount` de tokens do saldo do proprietário (`msg.sender`) e reduz o total supply.
    }
}
