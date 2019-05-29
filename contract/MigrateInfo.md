## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0xE974034d1d276D6e500bc1286898C3A04089D869
FissionReward:0x4313a9Eb9829562226fc95A60dE8d515569694F0
FOMOReward:0x072F9Ff403c704575811a04f88D5F8bdE813e2b3
LuckyReward:0x334012B2d7deaE96FC8340744966b1F11dB83137
FaithReward:0x9bF5338ac796237896dDA5cae1a71D37705054d2
ResonanceDataManage:0x54423E83013d168Ace080D8697FFD234a6d3417C
Resonance:0x694aD3c6c0A34E45dfe0d16Bb2f75fAC2Cd1D9fA
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

   Replacing 'Migrations'
   ----------------------
   > transaction hash:    0x579914d0424c4c29b310e63dce35aba0557ef2216f263224e4bbaa51ed48f299
   > Blocks: 1            Seconds: 12
   > contract address:    0xE627413e378b5DE17b19C2662f351EE88817A5e6
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             41530
   > gas used:            221171
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00442342 ETH


   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0xc4774adda61ac6e23fc219cf0a52fd0b2a07fd23b8bfbd9af4a1479954187cbc
   > Blocks: 0            Seconds: 28
   > contract address:    0xfe5069B0CCADa8eCDC472FD1ae7e4245c9ec1d03
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             41535
   > gas used:            102073
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00204146 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0xfe5069B0CCADa8eCDC472FD1ae7e4245c9ec1d03)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0xfe5069B0CCADa8eCDC472FD1ae7e4245c9ec1d03)

   Linking
   -------
   * Contract: ResonanceDataManage <--> Library: UintUtils (at address: 0xfe5069B0CCADa8eCDC472FD1ae7e4245c9ec1d03)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0x4659a698701c13a7e8d82a3c818e9c1e9533940c84aaa44c69bd584b0a51954a
   > Blocks: 0            Seconds: 36
   > contract address:    0x773f7BdCF63AE6F04DCB00660434414299801715
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             41540
   > gas used:            527498
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01054996 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0x773f7BdCF63AE6F04DCB00660434414299801715)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0xa94cb8c3e9336d7fc25afbd8d6b80e9ca1720def718a419527a3bf7a00231489
   > Blocks: 1            Seconds: 32
   > contract address:    0xE974034d1d276D6e500bc1286898C3A04089D869
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             41545
   > gas used:            787882
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01575764 ETH


   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0x168467aa652a96e4270099185348ec3111bf4ad833c18a811b837f371bd4e94d
   > Blocks: 0            Seconds: 12
   > contract address:    0x4313a9Eb9829562226fc95A60dE8d515569694F0
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             41550
   > gas used:            871655
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0174331 ETH


   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0x403890e1ea3fad4972f4da357761062f88ac8547d923808ff01ffd0c75e106f5
   > Blocks: 0            Seconds: 36
   > contract address:    0x072F9Ff403c704575811a04f88D5F8bdE813e2b3
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             41555
   > gas used:            660085
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0132017 ETH


   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0x452a9cf0640701a6cd0e4a9cbc82afacbb267387c3de5ca5ebd9aeacc755d72d
   > Blocks: 1            Seconds: 32
   > contract address:    0x334012B2d7deaE96FC8340744966b1F11dB83137
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             41560
   > gas used:            799898
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01599796 ETH


   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0x83bfaf0e68df0c2edc380e6b41844c6b682d06a0df31d05ebaa0dcd9e01b3c96
   > Blocks: 0            Seconds: 20
   > contract address:    0x9bF5338ac796237896dDA5cae1a71D37705054d2
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             41565
   > gas used:            456515
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0091303 ETH


   Replacing 'ResonanceDataManage'
   -------------------------------
   > transaction hash:    0x2621f4c6b56bea6a96f3e34c8e1a7ab858350703b5fdb22008b879d8d5b6cd2c
   > Blocks: 3            Seconds: 40
   > contract address:    0x54423E83013d168Ace080D8697FFD234a6d3417C
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             41580
   > gas used:            2326127
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.04652254 ETH


   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0x3447e6f93c9e88588eb0a3fbc3f6ffb40bc6f9a7c1ed5b714002962b1aaddb14
   > Blocks: 1            Seconds: 16
   > contract address:    0x694aD3c6c0A34E45dfe0d16Bb2f75fAC2Cd1D9fA
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             41585
   > gas used:            5685436
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.11370872 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:           0.2487668 ETH


Summary
=======
> Total deployments:   10
> Final cost:          0.2487668 ETH
```