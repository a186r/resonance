## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0xbdBC3fB3a4791C07A46629beD7Fbe405Faa97b76
FissionReward:0x65e7CEf130aF1F33657C4331B27BF783C1b45E36
FOMOReward:0x1E24E6F76e11DE6dE8B6926aFA31205e66DD9766
LuckyReward:0x57f47CEa7445EC30f2D4aDC4aa8fa30A1fBfE8Bb
FaithReward:0xB3133D624562976eeF4a6ba0422E6Bb42a6003e8
ResonanceDataManage:0xeCb634F1e57F52a7B1E6b80685B6a389910c3115
Resonance:0x93a4dc59A27Cb08A751d303D588dDe12dA4d3699
``` 

#### 部署日志：

```
$ truffle migrate --reset --network geth --compile-all           

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
   > transaction hash:    0x21814847426d749ab81b8880a12b2b0e32249512af93d9c4dbdd73480000a10a
   > Blocks: 0            Seconds: 12
   > contract address:    0x9A779B4acb71972adF279a51f322e7AB4549a5f2
   > block number:        17653
   > block timestamp:     1558887004
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             88265
   > gas used:            221171
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00442342 ETH


   Deploying 'UintUtils'
   ---------------------
   > transaction hash:    0x908bdfd05de5d7cd2abc7f6ec99748c303249d359df3c66cac784e1904b78973
   > Blocks: 0            Seconds: 4
   > contract address:    0xdA28EA29794EE00bE9Edb92f237aA74e400ddb08
   > block number:        17654
   > block timestamp:     1558887022
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             88270
   > gas used:            102073
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00204146 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0xdA28EA29794EE00bE9Edb92f237aA74e400ddb08)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0xdA28EA29794EE00bE9Edb92f237aA74e400ddb08)

   Linking
   -------
   * Contract: ResonanceDataManage <--> Library: UintUtils (at address: 0xdA28EA29794EE00bE9Edb92f237aA74e400ddb08)

   Deploying 'StringUtils'
   -----------------------
   > transaction hash:    0x7b77f0ab93bbf1e07e76bf3381b4054864b178496128c060051db6422bca21bd
   > Blocks: 0            Seconds: 28
   > contract address:    0x4ECdFe9f7cc489Cd9b73BEB759579B6502BACEf0
   > block number:        17655
   > block timestamp:     1558887031
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             88275
   > gas used:            527498
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01054996 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0x4ECdFe9f7cc489Cd9b73BEB759579B6502BACEf0)

   Deploying 'ABCToken'
   --------------------
   > transaction hash:    0x5aec9862c2d5e12685c9dc6fa4109e1976f64af4ba9314df9c2cf1d0e582821c
   > Blocks: 0            Seconds: 16
   > contract address:    0xbdBC3fB3a4791C07A46629beD7Fbe405Faa97b76
   > block number:        17656
   > block timestamp:     1558887061
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             88280
   > gas used:            1033122
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02066244 ETH


   Deploying 'FissionReward'
   -------------------------
   > transaction hash:    0x5ac987c586af4fb1ea4c685b0aa2969e347c4f31fd4b810926be28d209a37f44
   > Blocks: 0            Seconds: 4
   > contract address:    0x65e7CEf130aF1F33657C4331B27BF783C1b45E36
   > block number:        17657
   > block timestamp:     1558887080
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             88285
   > gas used:            927060
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0185412 ETH


   Deploying 'FOMOReward'
   ----------------------
   > transaction hash:    0x38b22924e8b9d432b225555ce62e88abf06f1b6e057d774901c3fdd21cc7f9af
   > Blocks: 0            Seconds: 0
   > contract address:    0x1E24E6F76e11DE6dE8B6926aFA31205e66DD9766
   > block number:        17658
   > block timestamp:     1558887086
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             88290
   > gas used:            658745
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0131749 ETH


   Deploying 'LuckyReward'
   -----------------------
   > transaction hash:    0x0b0efff1c00cfd8cadae5ede2ff5937407dd668ea4f8a3de5c6401beb5c81412
   > Blocks: 0            Seconds: 8
   > contract address:    0x57f47CEa7445EC30f2D4aDC4aa8fa30A1fBfE8Bb
   > block number:        17659
   > block timestamp:     1558887089
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             88295
   > gas used:            832211
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01664422 ETH


   Deploying 'FaithReward'
   -----------------------
   > transaction hash:    0x849ee20d8fc8f37bd8753d7fda683ce6ebae769fe7a9c15d016ee7f92cab3d73
   > Blocks: 1            Seconds: 4
   > contract address:    0xB3133D624562976eeF4a6ba0422E6Bb42a6003e8
   > block number:        17660
   > block timestamp:     1558887102
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             88300
   > gas used:            504268
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01008536 ETH


   Deploying 'ResonanceDataManage'
   -------------------------------
   > transaction hash:    0x06592a3a65e5706d1d36de6cb9ed39caa7cd7bc8f42dd77f52c25cff4cbee14b
   > Blocks: 0            Seconds: 24
   > contract address:    0xeCb634F1e57F52a7B1E6b80685B6a389910c3115
   > block number:        17661
   > block timestamp:     1558887107
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             88305
   > gas used:            1694729
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.03389458 ETH


   Deploying 'Resonance'
   ---------------------
   > transaction hash:    0x0eb88bf7c6226361abeadee1546999690f246a7363828ecb990c337366abffc1
   > Blocks: 0            Seconds: 20
   > contract address:    0x93a4dc59A27Cb08A751d303D588dDe12dA4d3699
   > block number:        17662
   > block timestamp:     1558887135
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             88310
   > gas used:            5262890
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.1052578 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.23527534 ETH


Summary
=======
> Total deployments:   10
> Final cost:          0.23527534 ETH

```