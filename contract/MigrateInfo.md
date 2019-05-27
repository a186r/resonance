## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0xF50F19103C815Dc4ED50bE092f0B74E344883966
FissionReward:0x5Da9BD563AeCA41Ae48FFb9F26F814a81516052F
FOMOReward:0xc64fe53328d019A57adeA2758145b01a8F3FeF7E
LuckyReward:0x28e1633801d413a64Fa1405fe16167321717B8F5
FaithReward:0x0e884bdBd3a0a607960Ea82f198b97b32889aff2
ResonanceDataManage:0x3d41941Fa8f5028B3ABd54fD8159227C2129EAfe
Resonance:0xBf7Df159A979F332e7ABb271BfDA347D201F89e1
``` 

#### 部署日志：

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
   > transaction hash:    0x9c2e0bab1f47d09e126d6031c21457c146e2c72ffd74f39aac969b01672299bd
   > Blocks: 0            Seconds: 0
   > contract address:    0xe5Ad1a47E11A1B3942a9D56749149F0e29e1D25f
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             108120
   > gas used:            221171
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00442342 ETH


   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0xed0313d43789f8d5b717f25d5aa99b07100abb723917195e1d476f2e031491d5
   > Blocks: 1            Seconds: 36
   > contract address:    0xC0cfaf55a6B94516C40c82AD0daDEABC64a7886D
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             108130
   > gas used:            102073
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00204146 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0xC0cfaf55a6B94516C40c82AD0daDEABC64a7886D)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0xC0cfaf55a6B94516C40c82AD0daDEABC64a7886D)

   Linking
   -------
   * Contract: ResonanceDataManage <--> Library: UintUtils (at address: 0xC0cfaf55a6B94516C40c82AD0daDEABC64a7886D)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0x93d3e6924660cd696f049e9c2553e8964b4e8d9d8d6a999548469bb364077e58
   > Blocks: 1            Seconds: 72
   > contract address:    0xdBE9E5eE681660098E3004e4a9a6de193642F779
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             108135
   > gas used:            527434
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01054868 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0xdBE9E5eE681660098E3004e4a9a6de193642F779)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0x2d6369e84f943ee41ff242406201e9f50cab229c6a898ba652645ee2673c7eea
   > Blocks: 1            Seconds: 8
   > contract address:    0xF50F19103C815Dc4ED50bE092f0B74E344883966
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             108140
   > gas used:            1033122
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02066244 ETH


   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0xd4f524ea9c257bc58f5c6cb83854c06b561c9ff09b846b39566075e3db1796aa
   > Blocks: 0            Seconds: 12
   > contract address:    0x5Da9BD563AeCA41Ae48FFb9F26F814a81516052F
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             108145
   > gas used:            871655
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0174331 ETH


   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0xf4dfe58e91f01960ac2c0b5745f35e34622607d6d4a0cb5a7cd93ab68078dab0
   > Blocks: 0            Seconds: 4
   > contract address:    0xc64fe53328d019A57adeA2758145b01a8F3FeF7E
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             108150
   > gas used:            660149
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01320298 ETH


   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0x1b14425127f2149eac6ec813e47160730386c1867750e069647d54494d985750
   > Blocks: 1            Seconds: 32
   > contract address:    0x28e1633801d413a64Fa1405fe16167321717B8F5
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             108160
   > gas used:            800154
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01600308 ETH


   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0xe58b66e6687317ba266d0e9ce96e9e87eb2ed3e61df3ecfef300c4f3444c7d90
   > Blocks: 1            Seconds: 24
   > contract address:    0x0e884bdBd3a0a607960Ea82f198b97b32889aff2
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             108165
   > gas used:            456515
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0091303 ETH


   Replacing 'ResonanceDataManage'
   -------------------------------
   > transaction hash:    0xd6bee8255cd580a3e13ad8c1ae8cd299af3b5ebb3d29c7115f81e9c451f68de7
   > Blocks: 0            Seconds: 0
   > contract address:    0x3d41941Fa8f5028B3ABd54fD8159227C2129EAfe
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             108170
   > gas used:            2246505
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0449301 ETH


   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0xf22e9a0434010d58b72889c866714729084847184cb2af659525d875c833a0ad
   > Blocks: 0            Seconds: 52
   > contract address:    0xBf7Df159A979F332e7ABb271BfDA347D201F89e1
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             108175
   > gas used:            4919561
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.09839122 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.23676678 ETH


Summary
=======
> Total deployments:   10
> Final cost:          0.23676678 ETH

```