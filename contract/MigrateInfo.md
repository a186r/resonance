## 部署信息
- **合约部署在Ropsten测试网上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken：0x7DCF798e3f21A711e266832fd3A4505172d48C38
FissionReward：0x67A4e840001D4bf5Ec2B9Bb1C5Ac1FA6cEDB98Ba
FOMOReward：0x12AE91fA8aF54305Ad814D27eD8b6c3d41551410
LuckyReward：0x4AfceA5B037C0075a36fCD3cC63160287B73Bc5d
FaithReward：0x5b9a988d4807f73c49A4E2a0019C315E81CFf8C6
Resonance：0x1F5F0eA5988aFF9703bc7B569b0Eb0343209E9f0
``` 

#### 部署日志：

```
Compiling your contracts...
===========================
> Compiling ./contracts/ABCToken.sol
> Compiling ./contracts/FOMOReward.sol
> Compiling ./contracts/FaithReward.sol
> Compiling ./contracts/FissionReward.sol
> Compiling ./contracts/LuckyReward.sol
> Compiling ./contracts/Migrations.sol
> Compiling ./contracts/Resonance.sol
> Compiling ./contracts/StringUtils.sol
> Compiling ./contracts/UintUtils.sol
> Compiling ./node_modules/openzeppelin-solidity/contracts/access/Roles.sol
> Compiling ./node_modules/openzeppelin-solidity/contracts/access/roles/MinterRole.sol
> Compiling ./node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol
> Compiling ./node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol
> Compiling ./node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol
> Compiling ./node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol
> Compiling ./node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Capped.sol
> Compiling ./node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol
> Compiling ./node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol
> Compiling ./node_modules/openzeppelin-solidity/contracts/token/ERC20/IERC20.sol
> Artifacts written to /Users/a186r/dev/sourcecode/contracts/contract/contract/build/contracts
> Compiled successfully using:
   - solc: 0.5.2+commit.1df8f40c.Emscripten.clang


Starting migrations...
======================
> Network name:    'ropsten'
> Network id:      3
> Block gas limit: 0x7a121d


1_initial_migration.js
======================

   Replacing 'Migrations'
   ----------------------
   > transaction hash:    0x59bbc98b31a3996cb340b496883f89c1a0929ba0febfaa3d3bdde074fb619da9
   > Blocks: 0            Seconds: 13
   > contract address:    0x091fB7cA63645513257E3aBEd4f23861732A9336
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.908354602
   > gas used:            273162
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00546324 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5647486)

   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0xd024d0a49bf54bba3be8338eeaf23ad5011e7450128c570dcd37d819407b5d92
   > Blocks: 1            Seconds: 9
   > contract address:    0x7556B55AaDB81fF7D6C3885c2f7549AcDb455f6D
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.906169642
   > gas used:            109248
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00218496 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5647488)

   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0x7556B55AaDB81fF7D6C3885c2f7549AcDb455f6D)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0x7556B55AaDB81fF7D6C3885c2f7549AcDb455f6D)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0x28c57322559e08d3c657bc11577de36ff11ae842345380d6779d01d29fa4baf5
   > Blocks: 2            Seconds: 13
   > contract address:    0x315d11C4197a54D01eefe7D4c686206777100C90
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.891242962
   > gas used:            746334
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01492668 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5647493)

   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0x315d11C4197a54D01eefe7D4c686206777100C90)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0x44f63bccdaf191faa2f0638d056ebfa9c512ccfdfb0eef818d842a60c4a627dd
   > Blocks: 0            Seconds: 5
   > contract address:    0x7DCF798e3f21A711e266832fd3A4505172d48C38
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.856172922
   > gas used:            1753502
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.03507004 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5647495)

   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0x8976a28c07957fa92883accc6c7d512ff26496b1c2fd34e496651378e7384651
   > Blocks: 1            Seconds: 9
   > contract address:    0x67A4e840001D4bf5Ec2B9Bb1C5Ac1FA6cEDB98Ba
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.831277742
   > gas used:            1244759
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02489518 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5647497)

   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0xac5093440555469524f2cdc5a0ec14cd8855449bcb8d09e35406aac2a29032af
   > Blocks: 1            Seconds: 14
   > contract address:    0x12AE91fA8aF54305Ad814D27eD8b6c3d41551410
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.815299982
   > gas used:            798888
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01597776 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5647499)

   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0x05647951bd42f9310c65fca34d668f12828f530109a4be79bb779cdb330098c5
   > Blocks: 1            Seconds: 17
   > contract address:    0x4AfceA5B037C0075a36fCD3cC63160287B73Bc5d
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.794932182
   > gas used:            1018390
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0203678 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5647502)

   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0xf41f84f0de130b76e664a620144e2894ed6c0845d74470a14f82a3e5da1e52b5
   > Blocks: 1            Seconds: 5
   > contract address:    0x5b9a988d4807f73c49A4E2a0019C315E81CFf8C6
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.779278522
   > gas used:            782683
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01565366 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5647508)

   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0xb2384d0a6d56e461489995f44b1cdbc4e56059582487a84157b9a9cbb661d958
   > Blocks: 1            Seconds: 29
   > contract address:    0x1F5F0eA5988aFF9703bc7B569b0Eb0343209E9f0
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.662619762
   > gas used:            5832938
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.11665876 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5647510)

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.25119808 ETH


Summary
=======
> Total deployments:   9
> Final cost:          0.25119808 ETH

```