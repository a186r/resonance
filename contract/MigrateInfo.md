## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0x5AA434CEDca3C7e56a3DaDFEe82BcE76AD295C88
FissionReward:0x980CeC5d6132fc1dE8A9f36609C0703DD1A6F5F2
FOMOReward:0x60BECE43266A24298dd3902Abf2aCe74C7c77495
LuckyReward:0x008F09e76180a55Bd0f546996187827c288422E6
FaithReward:0x404392F8F927eeEe1ec26F2736503F7eC5AcBffA
Resonance:0x383a284f2D67c154bfe2e1CE6eD1c18Dd64ef5F2
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
> Artifacts written to /Users/a186r/dev/contracts/contract/contract/build/contracts
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
   > transaction hash:    0x5beb0e13ea1693b02fee4941174b9be2c303ef57e271d451ea0a5c2159403e05
   > Blocks: 0            Seconds: 0
   > contract address:    0xC9078E6E10D5dC2D66083c7B64350AdE70eba553
   > block number:        4664
   > block timestamp:     1558712693
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             23320
   > gas used:            273162
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00546324 ETH


   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0x70c63a540781bda7824dbad2494a83743331fbc26f17e5ef70d736bdd630beaa
   > Blocks: 0            Seconds: 4
   > contract address:    0xA61f9c8d65276Fc7FA95D43a764719a9525C0325
   > block number:        4665
   > block timestamp:     1558712698
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             23325
   > gas used:            109248
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00218496 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0xA61f9c8d65276Fc7FA95D43a764719a9525C0325)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0xA61f9c8d65276Fc7FA95D43a764719a9525C0325)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0x4dffc0b83108160292c14f36be83b04ca56e4e0538985c699b2ea92474c88fa8
   > Blocks: 1            Seconds: 4
   > contract address:    0xb5bB095807AfE069Ad115d510114bb9cBAFeCD3b
   > block number:        4666
   > block timestamp:     1558712704
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             23335
   > gas used:            746334
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01492668 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0xb5bB095807AfE069Ad115d510114bb9cBAFeCD3b)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0x0de00ca5a883396f076f2a7c5e8bbffe7e75b5297c24d2c515c152e82c11e10b
   > Blocks: 0            Seconds: 16
   > contract address:    0x77B2bc2cBE3B51A34832e2830fB0616736Fa72a8
   > block number:        4668
   > block timestamp:     1558712710
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             23340
   > gas used:            1753438
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.03506876 ETH


   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0xafa28788c4a901bf407ebd925467d78a4c1b0523e42149b6dfe41162eb5167b8
   > Blocks: 1            Seconds: 20
   > contract address:    0x3D741daC42a7F6669b855f93cD7952177BA3F53A
   > block number:        4669
   > block timestamp:     1558712727
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             23345
   > gas used:            1244759
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02489518 ETH


   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0xb6142211edb49f4bb168cac61d62618ab9be8374dbef1d039af539ef938fc714
   > Blocks: 1            Seconds: 16
   > contract address:    0x9eFFcD227D30FDb8531920e3fe495E4b8Fbacf83
   > block number:        4671
   > block timestamp:     1558712751
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             23355
   > gas used:            864885
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0172977 ETH


   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0x30e76c407c19364b7a1b3622e84ed9f906d612678e80ca2a31db09f312aae5c0
   > Blocks: 1            Seconds: 8
   > contract address:    0x533A448aDc25396a66eA1B4bA234aa0d7A3CC356
   > block number:        4672
   > block timestamp:     1558712768
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             23360
   > gas used:            1018390
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0203678 ETH


   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0x07dfed87bd33a348bc46a911f4353fb413cd53c5e1b08481bcc68c56ccbbba32
   > Blocks: 0            Seconds: 8
   > contract address:    0x9a04ef7144e8f666f12662B1609c32cD2a4628ec
   > block number:        4673
   > block timestamp:     1558712777
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             23365
   > gas used:            591351
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01182702 ETH


   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0xe03c93b5baeb12677be3188cb814feed4b9e737efc684558c831e30022d07b89
   > Blocks: 1            Seconds: 4
   > contract address:    0x6e6C33B727B76063426ea23797A10f40Ceac6076
   > block number:        4674
   > block timestamp:     1558712787
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             23370
   > gas used:            6667326
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.13334652 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.26537786 ETH


Summary
=======
> Total deployments:   9
> Final cost:          0.26537786 ETH

```