## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0x8FD15A63C1532EA1EbBC3D3AC58ecBBD6D592fFf
FissionReward:0xA155d582B7b55dA0C8DE8b9F1659866a5a3F49EC
FOMOReward:0x6b4D1f634CABf93c078852052Af95F71D360B352
LuckyReward:0x7b33E492B0d32Ba82D768FeD3710227839E4EF9d
FaithReward:0x7b2f2a741ffFc02aA64dEA428F571df3Ac7657C2
ResonanceDataManage:0xf252DABf8c0a26CD4fe83a8d62F20300cD6e9378
Resonance:0x56105b6c316d952f1f5c12a370CB49C8Fff56c2A
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
   > transaction hash:    0x9ce6874743dca8ddcdbd3113ec20e3f346e9658ec75cd6b1fb4fcaea9af03ad7
   > Blocks: 0            Seconds: 0
   > contract address:    0xd11d1bD9E5d424DA35dEAF9B2986FAB87d478A33
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             21240
   > gas used:            221171
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00442342 ETH


   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0xc087957bfeb8dac536ec4e8f157e7067526be9d2511e346c3ae68de0f2362bcb
   > Blocks: 2            Seconds: 4
   > contract address:    0x98778768C84e66bcd6A45A2E7c8639faA2094Ebd
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             21250
   > gas used:            102073
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00204146 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0x98778768C84e66bcd6A45A2E7c8639faA2094Ebd)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0x98778768C84e66bcd6A45A2E7c8639faA2094Ebd)

   Linking
   -------
   * Contract: ResonanceDataManage <--> Library: UintUtils (at address: 0x98778768C84e66bcd6A45A2E7c8639faA2094Ebd)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0x6d0f8e9d5a4ad7d50e59961d96a6535dc35b89723e4193fde669092d80f1c428
   > Blocks: 0            Seconds: 16
   > contract address:    0x7392E1c613FE0676E5e0610273D90D54e6B23319
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             21255
   > gas used:            527434
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01054868 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0x7392E1c613FE0676E5e0610273D90D54e6B23319)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0x9782a0b9a2b6ce2272f2971792b07dbbce8e3bafbfdb6f3ead7dd9f2767eacfc
   > Blocks: 0            Seconds: 16
   > contract address:    0x8FD15A63C1532EA1EbBC3D3AC58ecBBD6D592fFf
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             21265
   > gas used:            1033122
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02066244 ETH


   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0xc97dd7a1235334e3b8c1eb71797dfc348fb7afe6d7b3a538239604aa1df75098
   > Blocks: 1            Seconds: 4
   > contract address:    0xA155d582B7b55dA0C8DE8b9F1659866a5a3F49EC
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             21280
   > gas used:            871655
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0174331 ETH


   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0x8cc3f23cb10330f2a2a2fdc8da07647883ba0453cf851502405762baf88ae89f
   > Blocks: 0            Seconds: 16
   > contract address:    0x6b4D1f634CABf93c078852052Af95F71D360B352
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             21285
   > gas used:            660149
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01320298 ETH


   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0x371b444012798400a0c0eb981120eeeade8c7a35065915307a6848c2c2de8980
   > Blocks: 0            Seconds: 40
   > contract address:    0x7b33E492B0d32Ba82D768FeD3710227839E4EF9d
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             21290
   > gas used:            800154
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01600308 ETH


   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0xdd07bd75f52cbf2a138c29c46fd4543d0784fc4c493d42c41184b8536172f598
   > Blocks: 1            Seconds: 8
   > contract address:    0x7b2f2a741ffFc02aA64dEA428F571df3Ac7657C2
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             21300
   > gas used:            456515
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0091303 ETH


   Replacing 'ResonanceDataManage'
   -------------------------------
   > transaction hash:    0x7582917edf77bd66943f6459dc3778e84841a5c321da2690f8c93186306033eb
   > Blocks: 0            Seconds: 8
   > contract address:    0xf252DABf8c0a26CD4fe83a8d62F20300cD6e9378
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             21305
   > gas used:            2326063
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.04652126 ETH


   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0x7895b2cf189826ba168e2704f9916e35638f6aee7157d90961514f3a9650c3cf
   > Blocks: 0            Seconds: 32
   > contract address:    0x56105b6c316d952f1f5c12a370CB49C8Fff56c2A
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             21310
   > gas used:            5615752
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.11231504 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.25228176 ETH


Summary
=======
> Total deployments:   10
> Final cost:          0.25228176 ETH
```