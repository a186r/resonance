## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0x5367e3eD26f616b5947F9fb91f3dB453efB87b45
FissionReward:0x999D3462c09E71c41796D2662532fd6295b55988
FOMOReward:0x5eA30b38025d9C8beAC4ab820F01A8AD01c84365
LuckyReward:0x16a70911500839D30d0C5e71FF164Fb2e11A0744
FaithReward:0xB8ead7352138E49A54cD24508e724ab893BcfEdB
ResonanceDataManage:0xfc8E5371c677b298bF3f5E5f7472CAAD5bAAb82c
Resonance:0x636C97aF319B178309c17Bd2350C283CA8179E82
``` 

#### 部署日志：

```
 truffle migrate --reset --network geth --compile-all

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
   > transaction hash:    0x4a099a58c81deb56ec3e42707f1dd8462f145a1e4158b0e7a68d4f93da9c3e72
   > Blocks: 1            Seconds: 8
   > contract address:    0xf663aa231B05421dc3e6648eCF53D97e0bbdFEaF
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             101370
   > gas used:            221171
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00442342 ETH


   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0x9931f4ba1ea14b81cf5dacd21aab3f535eb604e39dccb5de2d5711dd1f8faabc
   > Blocks: 1            Seconds: 4
   > contract address:    0xF313fc5b85844deDA0A509d82866bCd4B90c0B0D
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             101375
   > gas used:            102073
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00204146 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0xF313fc5b85844deDA0A509d82866bCd4B90c0B0D)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0xF313fc5b85844deDA0A509d82866bCd4B90c0B0D)

   Linking
   -------
   * Contract: ResonanceDataManage <--> Library: UintUtils (at address: 0xF313fc5b85844deDA0A509d82866bCd4B90c0B0D)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0xfa7b6f120b2b08183d8ee439100641b34a7edbfd74c6b5279e66340ac5b9fbe5
   > Blocks: 0            Seconds: 0
   > contract address:    0x35042000A31D1781Be761a1e1D31b31f944C06f4
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             101380
   > gas used:            527434
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01054868 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0x35042000A31D1781Be761a1e1D31b31f944C06f4)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0x8379ca4612108e9db3924896d322b89951e5afd1b42c47a9bab4fd27d76226f9
   > Blocks: 0            Seconds: 16
   > contract address:    0x5367e3eD26f616b5947F9fb91f3dB453efB87b45
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             101390
   > gas used:            1033122
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02066244 ETH


   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0xb3dc1c7212139670262e2ef24ae0a56509f914c3d9fd97d5398b7ce406a79083
   > Blocks: 0            Seconds: 12
   > contract address:    0x999D3462c09E71c41796D2662532fd6295b55988
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             101395
   > gas used:            927060
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0185412 ETH


   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0x8c416102a3c02391be6a61bfd27cd39969230e824e471254009195fd990f6843
   > Blocks: 0            Seconds: 12
   > contract address:    0x5eA30b38025d9C8beAC4ab820F01A8AD01c84365
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             101400
   > gas used:            658745
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0131749 ETH


   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0xd437aec77555069b2e6be131181aaabb6c830347aefdabdf62e8b30bd5366bc3
   > Blocks: 0            Seconds: 8
   > contract address:    0x16a70911500839D30d0C5e71FF164Fb2e11A0744
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             101405
   > gas used:            831955
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0166391 ETH


   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0x8034beef6f3e31e5995f381e3b3b9deed28b5589ee0f79a063327e058cc694b2
   > Blocks: 1            Seconds: 4
   > contract address:    0xB8ead7352138E49A54cD24508e724ab893BcfEdB
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             101415
   > gas used:            504268
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01008536 ETH


   Replacing 'ResonanceDataManage'
   -------------------------------
   > transaction hash:    0x5d44829e3b83c6defc9cedf459fae61326de4616647ca9ca09db7d95ec401af8
   > Blocks: 2            Seconds: 16
   > contract address:    0xfc8E5371c677b298bF3f5E5f7472CAAD5bAAb82c
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             101425
   > gas used:            2342765
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0468553 ETH


   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0xc6648c1238217fee3668d7648d316f7144560b18fba92c36d28ca40ace9e74d0
   > Blocks: 1            Seconds: 8
   > contract address:    0x636C97aF319B178309c17Bd2350C283CA8179E82
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             101430
   > gas used:            5346317
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.10692634 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:           0.2498982 ETH


Summary
=======
> Total deployments:   10
> Final cost:          0.2498982 ETH
```