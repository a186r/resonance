## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0xe54F0e200E30eDdD51142a61fBCa90B901DBF258
FissionReward:0x80B753E681915a2Fa21fB31F8c1846Bc180354f5
FOMOReward:0x6B1Fae33eBc05af241cFAdCEbfa64022f3624e54
LuckyReward:0xd25c003f1f38EfC17243DF6d9C7a1C2f063756f4
FaithReward:0x53411CdfEB5877B2b25b00D2924181dD7C3EAcDD
ResonanceDataManage:0x39555c8FCab5AcB9d52Aeb6e3752406c6552AF57
Resonance:0xDc0d4b9dE87389174435CDD59f863F619A853D5d
``` 

#### 部署日志：

```
# truffle migrate --reset --network geth --compile-all

Compiling your contracts...
===========================
> Compiling ./contracts/ABCToken.sol
> Compiling ./contracts/FOMOReward.sol
> Compiling ./contracts/FaithReward.sol
> Compiling ./contracts/FissionReward.sol
> Compiling ./contracts/LuckyReward.sol
> Compiling ./contracts/Migrations.sol
> Compiling ./contracts/Resonance.sol
> Compiling ./contracts/ResonanceDataManage.sol
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
> Network name:    'geth'
> Network id:      123456
> Block gas limit: 0x7a1200


1_initial_migration.js
======================

   Replacing 'Migrations'
   ----------------------
   > transaction hash:    0x685f9ba5f460f0b5fe8b8dde7bd9cf22cc587346b9a50fccf38f1688062f76e5
   > Blocks: 0            Seconds: 16
   > contract address:    0xbC13A0e84Dd4b3C17aDc2c848997f288903B8A5d
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             104890
   > gas used:            221171
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00442342 ETH


   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0x3a36fa45cb0f37f6969960da052e80b87550cac35b4837f25f51eb4547a9d2b4
   > Blocks: 1            Seconds: 4
   > contract address:    0x038Dc162A83F9d97E276a14872e814547AC110C7
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             104895
   > gas used:            102073
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00204146 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0x038Dc162A83F9d97E276a14872e814547AC110C7)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0x038Dc162A83F9d97E276a14872e814547AC110C7)

   Linking
   -------
   * Contract: ResonanceDataManage <--> Library: UintUtils (at address: 0x038Dc162A83F9d97E276a14872e814547AC110C7)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0xa019aa434fb8583a8dadd31abcd45f6d305180f6fd19fbe50eefab1d4b4f2dbe
   > Blocks: 0            Seconds: 48
   > contract address:    0xb7BEa58C5b69F5254C5821C53b93F3e37595De67
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             104900
   > gas used:            527434
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01054868 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0xb7BEa58C5b69F5254C5821C53b93F3e37595De67)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0xa973ed84ca55e65d3f36b4d6abdcd94752e6b2b18728d5405dff10efb895ab08
   > Blocks: 0            Seconds: 40
   > contract address:    0xe54F0e200E30eDdD51142a61fBCa90B901DBF258
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             104905
   > gas used:            1033122
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02066244 ETH


   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0xae3109e8ea5471daaaecfe978aa6422f6dc4124389b22a33911386bc4d9a7638
   > Blocks: 0            Seconds: 16
   > contract address:    0x80B753E681915a2Fa21fB31F8c1846Bc180354f5
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             104910
   > gas used:            871655
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0174331 ETH


   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0x7b0c4a677b002178e25f0113ec32dcd372b7885e8b280d8318e7c778a9adef22
   > Blocks: 1            Seconds: 20
   > contract address:    0x6B1Fae33eBc05af241cFAdCEbfa64022f3624e54
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             104920
   > gas used:            660149
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01320298 ETH


   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0x1bb404bee1457597cfca320d06755d8f2fed2a44338434a0b5a13a95c2d0b2fe
   > Blocks: 0            Seconds: 8
   > contract address:    0xd25c003f1f38EfC17243DF6d9C7a1C2f063756f4
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             104925
   > gas used:            800154
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01600308 ETH


   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0xe3c45ee3edc9bb13c72d571555170d55ba2d2649548c07610bfac887122d02db
   > Blocks: 0            Seconds: 12
   > contract address:    0x53411CdfEB5877B2b25b00D2924181dD7C3EAcDD
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             104930
   > gas used:            456515
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0091303 ETH


   Replacing 'ResonanceDataManage'
   -------------------------------
   > transaction hash:    0x8d3eee25dc010ba51cd63a5bd100eef03d3fa70bc3f8b5b7febc6beddc7b71d8
   > Blocks: 0            Seconds: 0
   > contract address:    0x39555c8FCab5AcB9d52Aeb6e3752406c6552AF57
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             104935
   > gas used:            2397895
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0479579 ETH


   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0xdcd132391133b0771b2d0ce673f8d4403640bbdd3934675e2737e39434959723
   > Blocks: 0            Seconds: 20
   > contract address:    0xDc0d4b9dE87389174435CDD59f863F619A853D5d
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             104940
   > gas used:            5033879
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.10067758 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.24208094 ETH


Summary
=======
> Total deployments:   10
> Final cost:          0.24208094 ETH
```