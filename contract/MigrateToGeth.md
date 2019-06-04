## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0x3Ad1D0310b7FAD74675c336589b1230cE0602f16
FissionReward:0xbD2786C33F940509d21b3fbA6C39b3D21b60f9D1
FOMOReward:0x6A988829DBc1af38B702A63D41D506bDFffb99f1
LuckyReward:0x391c11B84fcAA1Abce25893D043d7F3dD85a440d
FaithReward:0xdd21a4c02c9625Bc67f8EF7cD1AC62ffab92BC72
ResonanceDataManage:0x638eb0917c35f38e23129bf8073e86E3552c2236
Resonance:0x890cB5107cE22adb397C20EEB457413Ae9a9C490
``` 

#### 部署日志：
```
Compiling your contracts...
===========================
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
> Artifacts written to /Users/a186r/dev/sourcecode/contract/contract/build/contracts
> Compiled successfully using:
   - solc: 0.5.2+commit.1df8f40c.Emscripten.clang


Starting migrations...
======================
> Network name:    'geth'
> Network id:      123456
> Block gas limit: 0x7a1200


1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0x863e10a7b72e60644fab0b1a2dd4d150720487bcb8ae5d0a7e4ce3c41285b0f1
   > Blocks: 0            Seconds: 4
   > contract address:    0xB4B0bBa1001F51D2eaB5c9B030bDBf68d03Dc2A6
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             44685
   > gas used:            221171
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00442342 ETH


   Deploying 'UintUtils'
   ---------------------
   > transaction hash:    0x46dd61f7f3a8ed3090d42b4cff586f1dd73195fb0ab037941ca9aa9b3f44afab
   > Blocks: 0            Seconds: 8
   > contract address:    0xc2356f59b5c50CFB91d9681aC5e81a5487C8218E
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             44690
   > gas used:            102073
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00204146 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0xc2356f59b5c50CFB91d9681aC5e81a5487C8218E)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0xc2356f59b5c50CFB91d9681aC5e81a5487C8218E)

   Linking
   -------
   * Contract: ResonanceDataManage <--> Library: UintUtils (at address: 0xc2356f59b5c50CFB91d9681aC5e81a5487C8218E)

   Deploying 'StringUtils'
   -----------------------
   > transaction hash:    0xc1749a301b9d5b5a466e18cc2786a96945dbd5a0ec3f9374ce81b765d28cf968
   > Blocks: 0            Seconds: 12
   > contract address:    0x4EA111a37BAA53fc5FD2B53e97D88cDE6853F3aF
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             44695
   > gas used:            527498
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01054996 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0x4EA111a37BAA53fc5FD2B53e97D88cDE6853F3aF)

   Deploying 'ABCToken'
   --------------------
   > transaction hash:    0xeef61f778d925ad14224888aa91c64a0023e780729416b26b569b37181bb1a9c
   > Blocks: 0            Seconds: 4
   > contract address:    0x3Ad1D0310b7FAD74675c336589b1230cE0602f16
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             44700
   > gas used:            787882
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01575764 ETH


   Deploying 'FissionReward'
   -------------------------
   > transaction hash:    0x5f954e4437e0d8e246d934142716e9122773eb9a99aa5c1f36f098c28f473f77
   > Blocks: 0            Seconds: 32
   > contract address:    0xbD2786C33F940509d21b3fbA6C39b3D21b60f9D1
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             44705
   > gas used:            871655
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0174331 ETH


   Deploying 'FOMOReward'
   ----------------------
   > transaction hash:    0x519de075cbd0e5254d8cff25e8df56d8fa03630d4abe2ac00e64aa94a9988f9a
   > Blocks: 0            Seconds: 8
   > contract address:    0x6A988829DBc1af38B702A63D41D506bDFffb99f1
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             44710
   > gas used:            660085
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0132017 ETH


   Deploying 'LuckyReward'
   -----------------------
   > transaction hash:    0x7ce3dab708b3d77d7a0fb19207a45ab365cc910d5cf9db094a961821a2d32f14
   > Blocks: 0            Seconds: 36
   > contract address:    0x391c11B84fcAA1Abce25893D043d7F3dD85a440d
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             44715
   > gas used:            800154
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01600308 ETH


   Deploying 'FaithReward'
   -----------------------
   > transaction hash:    0x4aa249a04bb635b82cd0b6709f06dc44c1478a40700f75c7d3380468baf461cb
   > Blocks: 0            Seconds: 4
   > contract address:    0xdd21a4c02c9625Bc67f8EF7cD1AC62ffab92BC72
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             44720
   > gas used:            456515
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0091303 ETH


   Deploying 'ResonanceDataManage'
   -------------------------------
   > transaction hash:    0x9d4af2954c90ae190cf12d0f8daa894c4ee632e4fd0bf9b11baf1f9e954dd4a8
   > Blocks: 0            Seconds: 8
   > contract address:    0x638eb0917c35f38e23129bf8073e86E3552c2236
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             44725
   > gas used:            2344837
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.04689674 ETH


   Deploying 'Resonance'
   ---------------------
   > transaction hash:    0xd195889bcdf02bd364821ca6e2655f656f60bfd86306df42185124db235b09f6
   > Blocks: 0            Seconds: 16
   > contract address:    0x890cB5107cE22adb397C20EEB457413Ae9a9C490
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             44730
   > gas used:            5721653
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.11443306 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.24987046 ETH


Summary
=======
> Total deployments:   10
> Final cost:          0.24987046 ETH
```