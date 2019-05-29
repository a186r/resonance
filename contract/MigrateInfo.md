## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0xebF632CFf7DE55e03C54009e8332476c1710bA24
FissionReward:0x17fCbF0a75D0ed7922Ef964BcC3BB310124F8F0d
FOMOReward:0xbE849Ee64BC7F2f1142946bEB7b21a0B86C94548
LuckyReward:0x5B9d86880855436E3cbF0cD645FF7bF3694DF0C8
FaithReward:0x49b175B9EEA6932BAd33440d1C69d28D5A7B1620
ResonanceDataManage:0xc9bE6a8F87603FdaC2C0a69a866CD5026a288275
Resonance:0xfc5D0EB15Cc71Cff1F7D3517763746f37d6b1161
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
   > transaction hash:    0xaf712b890dea6f52e45e3940893041fb70cc9e983894f4979362da4177a1ca33
   > Blocks: 0            Seconds: 68
   > contract address:    0x8015224bF46ea4DDeE0756b1a34fc4998c974FF4
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             42525
   > gas used:            221171
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00442342 ETH


   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0xfff84801f846ee19314c2e9fa0860b6353439710724cf98d78af9e9504833e66
   > Blocks: 0            Seconds: 52
   > contract address:    0x651d34FD63CC276D017E39F2e66CA8c96faC2968
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             42530
   > gas used:            102073
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00204146 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0x651d34FD63CC276D017E39F2e66CA8c96faC2968)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0x651d34FD63CC276D017E39F2e66CA8c96faC2968)

   Linking
   -------
   * Contract: ResonanceDataManage <--> Library: UintUtils (at address: 0x651d34FD63CC276D017E39F2e66CA8c96faC2968)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0xbd8da0c61facde57e497134a283adab352f8f16122e014c1f9d437cc651aa9b2
   > Blocks: 0            Seconds: 8
   > contract address:    0xd487b46C7ac7504dBEB513976e027E326260eae3
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             42535
   > gas used:            527498
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01054996 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0xd487b46C7ac7504dBEB513976e027E326260eae3)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0xcf926de89244b4388351657b8637d6d664d6e4d0cf69e24f4633ef2c1d6fa579
   > Blocks: 1            Seconds: 12
   > contract address:    0x046f96de09f879d0dF10cD8225C58Ae46Ddd1D99
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             42540
   > gas used:            787882
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01575764 ETH


   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0x031df7e5afd5b1ef95bf596dbb76dac8460dddaa7276012f06ae208abec6da32
   > Blocks: 2            Seconds: 52
   > contract address:    0x17fCbF0a75D0ed7922Ef964BcC3BB310124F8F0d
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             42550
   > gas used:            871655
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0174331 ETH


   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0x9c88347f7896e142a087e5446217498f73f6d9a91a697b68dd371885073d42be
   > Blocks: 0            Seconds: 12
   > contract address:    0xbE849Ee64BC7F2f1142946bEB7b21a0B86C94548
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             42555
   > gas used:            660085
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0132017 ETH


   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0x294a6d84a982828093663e689ad4fc8e454def2f2178bd6942108f5e02d9dc8a
   > Blocks: 0            Seconds: 32
   > contract address:    0x5B9d86880855436E3cbF0cD645FF7bF3694DF0C8
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             42560
   > gas used:            800154
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01600308 ETH


   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0xd5c82b30b3c02cbee997d6dfc3ab6526e2168b7bd3ff35a23ee7f518ade1b8e8
   > Blocks: 0            Seconds: 20
   > contract address:    0x49b175B9EEA6932BAd33440d1C69d28D5A7B1620
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             42565
   > gas used:            456515
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0091303 ETH


   Replacing 'ResonanceDataManage'
   -------------------------------
   > transaction hash:    0x363ec72c5b28c80c293a48b26411bd4a31e451b74eab756e434fec229a24e749
   > Blocks: 0            Seconds: 16
   > contract address:    0xc9bE6a8F87603FdaC2C0a69a866CD5026a288275
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             42570
   > gas used:            2326127
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.04652254 ETH


   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0xbfb8aa7a83546f6eda551d7ffe76b8fe1b3a39a6af9b16126abd6eb2c5adab4c
   > Blocks: 0            Seconds: 32
   > contract address:    0xfc5D0EB15Cc71Cff1F7D3517763746f37d6b1161
   > account:             0x31b17D03A5F41Cc52067165353Aa901951a38ba0
   > balance:             42575
   > gas used:            5721653
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.11443306 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.24949626 ETH


Summary
=======
> Total deployments:   10
> Final cost:          0.24949626 ETH
```