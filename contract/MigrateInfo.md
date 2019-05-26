## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0xcB75DEbe73716F6c512a90D01B42093622f3699E
FissionReward:0x172f683F020F9ea487eAbCc6ef0b034F98d40F5d
FOMOReward:0x45398972283b0309e3f9fd44c7D5eFfc7D7Ad6dd
LuckyReward:0x1b9ABec5BACAB876f211726B24A65B87ef7d1437
FaithReward:0xb4886428b786db5cc6a00F7de04a29d4bbB7e2d6
Resonance:0x0383607D453588cDB96bF4E46F93CeBf902aF2bA
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

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0x7187e639500733bc1e351ee6ffe1f9a218b3301b0b2b25c8d7e2f101b0580fa0
   > Blocks: 0            Seconds: 28
   > contract address:    0xb6Fc8858C220AdDA3635f2AD5a80aBb2707f238b
   > block number:        13517
   > block timestamp:     1558828770
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             67585
   > gas used:            273162
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00546324 ETH


   Deploying 'UintUtils'
   ---------------------
   > transaction hash:    0x94a5e25baa7e8a44d442f2ee3646de961ee696113b67b6f7f9ce7d41a5c14dbb
   > Blocks: 0            Seconds: 0
   > contract address:    0xDDD3a4433BcF9b89d4d9096f4C0A7135FF9d4f2e
   > block number:        13518
   > block timestamp:     1558828815
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             67590
   > gas used:            109248
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00218496 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0xDDD3a4433BcF9b89d4d9096f4C0A7135FF9d4f2e)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0xDDD3a4433BcF9b89d4d9096f4C0A7135FF9d4f2e)

   Deploying 'StringUtils'
   -----------------------
   > transaction hash:    0x5acca3f680519b57e5bdc16c3faa86dbb796965fc066ba4271b4847c95bcde64
   > Blocks: 0            Seconds: 4
   > contract address:    0x7BB36a8FBF95a2eFef01B4916f0D83d3c2299248
   > block number:        13519
   > block timestamp:     1558828818
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             67595
   > gas used:            746334
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01492668 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0x7BB36a8FBF95a2eFef01B4916f0D83d3c2299248)

   Deploying 'ABCToken'
   --------------------
   > transaction hash:    0x82a9b44ee97ef9eb9a0f878efd5dca3045be28103ed5f57b70b9d37f71b6adb1
   > Blocks: 1            Seconds: 4
   > contract address:    0xcB75DEbe73716F6c512a90D01B42093622f3699E
   > block number:        13521
   > block timestamp:     1558828825
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             67605
   > gas used:            1753438
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.03506876 ETH


   Deploying 'FissionReward'
   -------------------------
   > transaction hash:    0xefe570b9f419c875301bcc0bd2eccfa3a8cff71167b6596f1f963a8c8fdc8db9
   > Blocks: 0            Seconds: 0
   > contract address:    0x172f683F020F9ea487eAbCc6ef0b034F98d40F5d
   > block number:        13522
   > block timestamp:     1558828830
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             67610
   > gas used:            1244759
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02489518 ETH


   Deploying 'FOMOReward'
   ----------------------
   > transaction hash:    0x06983953905e45203761fc17c2a12cb8614d88f49f43957b6a49b0f7045ca819
   > Blocks: 0            Seconds: 4
   > contract address:    0x45398972283b0309e3f9fd44c7D5eFfc7D7Ad6dd
   > block number:        13523
   > block timestamp:     1558828834
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             67615
   > gas used:            864885
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0172977 ETH


   Deploying 'LuckyReward'
   -----------------------
   > transaction hash:    0x3975495e7eb6cd09b68c31ae1bb8e41663e30d01078d15d93ca9ebb3b8855a32
   > Blocks: 0            Seconds: 8
   > contract address:    0x1b9ABec5BACAB876f211726B24A65B87ef7d1437
   > block number:        13524
   > block timestamp:     1558828841
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             67620
   > gas used:            1018390
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0203678 ETH


   Deploying 'FaithReward'
   -----------------------
   > transaction hash:    0x08848f99c2d1e2c8b7243875185c2a49c0cde41a15c42845493f4351dc79e33c
   > Blocks: 0            Seconds: 24
   > contract address:    0xb4886428b786db5cc6a00F7de04a29d4bbB7e2d6
   > block number:        13525
   > block timestamp:     1558828852
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             67630
   > gas used:            591351
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01182702 ETH


   Deploying 'Resonance'
   ---------------------
   > transaction hash:    0x3acc46799f44a0b16203aecb6badb7243cf18a41b36c6a9a2fdde73cb0fd997f
   > Blocks: 0            Seconds: 4
   > contract address:    0x0383607D453588cDB96bF4E46F93CeBf902aF2bA
   > block number:        13527
   > block timestamp:     1558828881
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             67635
   > gas used:            6704970
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.1340994 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.26613074 ETH


Summary
=======
> Total deployments:   9
> Final cost:          0.26613074 ETH

```