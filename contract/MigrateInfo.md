## 部署信息
- **合约部署在Ropsten测试网上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken：0xfbd55AE90159d301519e8D273Ba8818b0e8db65C
FissionReward：0x60E748D72756296261D8E96cc62911DaC19c630F
FOMOReward：0x946dEcfE63Fd0a8bc0001C23eC96319106547B93
LuckyReward：0xBE26CBE15e93aedDc1d3Df7ab4e03a87134a2633
FaithReward：0x53a73f0badf66175225aD01F3B319775f237C448
Resonance：0xE5f0fE69EFE6A05F6Ba033381B714ab9Ba1D7717
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
   > transaction hash:    0x11b37f7711c20b9302102b79240c1170e7252e194560aeab092765c9bcee9674
   > Blocks: 1            Seconds: 21
   > contract address:    0x4F674e1ea13DD803F8CD5F69C71316a3D06e6CCd
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.656315962
   > gas used:            273162
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00546324 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5652498)

   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0xfb8fbef101e763ae99b0f9e5758f8a5a9ac5adc3ad84ff25ebc7d8eafeeaac68
   > Blocks: 1            Seconds: 10
   > contract address:    0x657f53252302b1190c0f80fB0bEc5A0a71438275
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.654131002
   > gas used:            109248
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00218496 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5652501)

   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0x657f53252302b1190c0f80fB0bEc5A0a71438275)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0x657f53252302b1190c0f80fB0bEc5A0a71438275)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0xf7b587a2e5ee088235c6ed12a6b7d615bd8ff062ca2055f059f4ca505fe0de95
   > Blocks: 0            Seconds: 41
   > contract address:    0xe6fFa9D7B5140192eA3E6c36aBc4d7D62b6E99Bb
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.639204322
   > gas used:            746334
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01492668 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5652504)

   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0xe6fFa9D7B5140192eA3E6c36aBc4d7D62b6E99Bb)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0x17aff68ea2e381f573196da7b539ce0801ea9a3d07cfed10a6065ba4ba148d7b
   > Blocks: 0            Seconds: 14
   > contract address:    0xfbd55AE90159d301519e8D273Ba8818b0e8db65C
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.604134282
   > gas used:            1753502
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.03507004 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 2 (block: 5652507)

   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0xb9468f2392317dce91e97247423a5496796fbc1f156721e2f82732ff1c85cc14
   > Blocks: 2            Seconds: 25
   > contract address:    0x60E748D72756296261D8E96cc62911DaC19c630F
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.579239102
   > gas used:            1244759
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02489518 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5652512)

   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0x6ceb1f39fd49f49006ec0e0935567befc96febb506b850c2ba83d22d8552b3eb
   > Blocks: 1            Seconds: 5
   > contract address:    0x946dEcfE63Fd0a8bc0001C23eC96319106547B93
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.563261342
   > gas used:            798888
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01597776 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5652514)

   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0xa7d33bbe3b042ece1c22b9081b0b8432546f87ec3b3b1e82ebc77f01cc8d98f3
   > Blocks: 0            Seconds: 9
   > contract address:    0xBE26CBE15e93aedDc1d3Df7ab4e03a87134a2633
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.542893542
   > gas used:            1018390
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0203678 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5652516)

   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0x7c551f59e29bc262dfd6e7d1e854bcfbb196ccdd3702ccf31bb0559f32ea6cc0
   > Blocks: 1            Seconds: 21
   > contract address:    0x53a73f0badf66175225aD01F3B319775f237C448
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.527239882
   > gas used:            782683
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01565366 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5652521)

   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0xe79e953cd6172a65eaa7848b0366f7998437d1ffb8eaae56a1b5b7fb701108ca
   > Blocks: 1            Seconds: 5
   > contract address:    0xE5f0fE69EFE6A05F6Ba033381B714ab9Ba1D7717
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             6.399907722
   > gas used:            6366608
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.12733216 ETH

   Pausing for 1 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 5652523)

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.26187148 ETH


Summary
=======
> Total deployments:   9
> Final cost:          0.26187148 ETH

```