## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0x6dcE804a088eAc52F4d8fC985ea12c77b180e1E2
FissionReward:0x1EB07205Bf0AD01D9Bb8803116106a797F1071eD
FOMOReward:0x8e524782b3D7eF4aCDb036648AbbD3E9D0Aa5442
LuckyReward:0x6cF639A1306032A4fe36a5E0c277600E3017f2A1
FaithReward:0x44bD0537De52968ea9EB4C4E4fA25E674DEB2D3A
Resonance:0x06348e7d28A8BEb4d53005f6780F34e59183aA82
``` 

#### 部署日志：

```
Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.


Starting migrations...
======================
> Network name:    'development'
> Network id:      123456
> Block gas limit: 0x7a1200


1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0x6aba8e6552b2a8fdcf9d5c0cc04432fff597ff89493b74761c803649066705e0
   > Blocks: 0            Seconds: 0
   > contract address:    0x965c3014eBEaa6c9A41752b90B7Fc7DA985534f1
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             450
   > gas used:            273162
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00546324 ETH


   Deploying 'UintUtils'
   ---------------------
   > transaction hash:    0x095dd5f5abbe76af754a0565a240fd3a7ee9a4bfa4cc1e23d0d34f1627cd5479
   > Blocks: 1            Seconds: 4
   > contract address:    0x354f7f134e08e88599480e6294b5cAA972DDf989
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             460
   > gas used:            109248
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00218496 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0x354f7f134e08e88599480e6294b5cAA972DDf989)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0x354f7f134e08e88599480e6294b5cAA972DDf989)

   Deploying 'StringUtils'
   -----------------------
   > transaction hash:    0x25c99ce3ac0f3f8ed047a4f8f3feff10f0f1d862e4f902be0a4e6aa11d1d2136
   > Blocks: 0            Seconds: 0
   > contract address:    0x003e89A35b3e9b300420e054dB96cA78b75FB3b3
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             470
   > gas used:            746334
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01492668 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0x003e89A35b3e9b300420e054dB96cA78b75FB3b3)

   Deploying 'ABCToken'
   --------------------
   > transaction hash:    0x3cf9f8ca96602f76571962c1c37d2c3e7f525eddd367ea99f36e15b2d2b5284c
   > Blocks: 0            Seconds: 4
   > contract address:    0x6dcE804a088eAc52F4d8fC985ea12c77b180e1E2
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             485
   > gas used:            1753502
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.03507004 ETH


   Deploying 'FissionReward'
   -------------------------
   > transaction hash:    0xe436ca019d1b052a1da4894798e89a85d0e35027db4a2241adbeced05d417b0e
   > Blocks: 0            Seconds: 0
   > contract address:    0x1EB07205Bf0AD01D9Bb8803116106a797F1071eD
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             495
   > gas used:            1244759
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02489518 ETH


   Deploying 'FOMOReward'
   ----------------------
   > transaction hash:    0x9d6f55a622b3e94ae01a572eedaff4eb5a8bfc7e888bf0a0538a55392270cb41
   > Blocks: 1            Seconds: 8
   > contract address:    0x8e524782b3D7eF4aCDb036648AbbD3E9D0Aa5442
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             500
   > gas used:            864949
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01729898 ETH


   Deploying 'LuckyReward'
   -----------------------
   > transaction hash:    0x00fd1a8eda40b2da57363486fdbd263bf20d86bfdd8b1467660366629fb991dd
   > Blocks: 2            Seconds: 4
   > contract address:    0x6cF639A1306032A4fe36a5E0c277600E3017f2A1
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             510
   > gas used:            1018134
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02036268 ETH


   Deploying 'FaithReward'
   -----------------------
   > transaction hash:    0x60b0c0fe9c02d297103813a1ef366ef378fdc97857410737ed634ae372dd0e7d
   > Blocks: 0            Seconds: 0
   > contract address:    0x44bD0537De52968ea9EB4C4E4fA25E674DEB2D3A
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             525
   > gas used:            591351
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01182702 ETH


   Deploying 'Resonance'
   ---------------------
   > transaction hash:    0xcbe8d52c19b9a482e2d86f7d9de7f9b3928ecc338e947da8a0bdd7c33d40b2c1
   > Blocks: 0            Seconds: 4
   > contract address:    0x06348e7d28A8BEb4d53005f6780F34e59183aA82
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             535
   > gas used:            6667262
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.13334524 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.26537402 ETH


Summary
=======
> Total deployments:   9
> Final cost:          0.26537402 ETH
```