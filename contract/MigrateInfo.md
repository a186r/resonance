## 部署信息
- **合约部署在http://47.103.41.61:8545上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
ABCToken:0x852DB220EE2d339284553D3B1126D13fea9281b3
FissionReward:0x1BE079E88b6251DD2Ff86487b58a4DbDE3a86378
FOMOReward:0x4Db087b433ED25d27cc3711df70137FE2531D4FF
LuckyReward:0xC44292A55F95Ec7694807CB23449FA82d847b3c9
FaithReward:0xDD0B22656ed076Cf46877747678e08A4856ff4d8
ResonanceDataManage:0xaE4b7e836312fe94e687f69b26dceB2724D8244a
Resonance:0xf1C313539d66f9CCD57a1A0b931b7a4DcC65b862
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
   > transaction hash:    0xd62d4c17ba9473f3c831d0c549cdcea0246a4e6b7f480dbc6dad142401ff9500
   > Blocks: 0            Seconds: 20
   > contract address:    0xBdBD2e43e0368b3a0c5e15fCA74b2c9f2EA33775
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             127505
   > gas used:            221171
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00442342 ETH


   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0xa970f0a7ddf8c453f7535cbb75a71b52464807a8420a6e947da131cd738bffee
   > Blocks: 0            Seconds: 0
   > contract address:    0xEfE9D2b0e09ea40667C235C5C64A55cA871cCD9b
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             127515
   > gas used:            102073
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00204146 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0xEfE9D2b0e09ea40667C235C5C64A55cA871cCD9b)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0xEfE9D2b0e09ea40667C235C5C64A55cA871cCD9b)

   Linking
   -------
   * Contract: ResonanceDataManage <--> Library: UintUtils (at address: 0xEfE9D2b0e09ea40667C235C5C64A55cA871cCD9b)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0x5a6a059529434a6b038599bd9701b397d9bcb722929aa6ac3332a9a01e79a7eb
   > Blocks: 1            Seconds: 8
   > contract address:    0x8192b70370F9a244135C8801F5783D813523c0F8
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             127520
   > gas used:            527434
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01054868 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0x8192b70370F9a244135C8801F5783D813523c0F8)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0x00b9f6edfe16577c4529557596d090ea4b36d24e2edab4c88e7a9d38dcf77433
   > Blocks: 0            Seconds: 20
   > contract address:    0xAC7F0c66e0CA8e49Acf25f0A902bf324249e04a2
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             127525
   > gas used:            1033122
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02066244 ETH


   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0x396944827a2c72f0df0b05c077b81d9cab4da972befa2024e7daaa87f48babb8
   > Blocks: 0            Seconds: 76
   > contract address:    0x6232C9a624e6Fa16DB9BdBF5C7d629e34fCAfFd6
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             127530
   > gas used:            871655
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0174331 ETH


   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0x2d4fdd1aaf5328603a3ff61881c6657900e2df8b0089c16b58bf546c4394e6be
   > Blocks: 0            Seconds: 4
   > contract address:    0xA4228F2Fabc009d165d0DedD34431d040186F864
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             127535
   > gas used:            660149
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01320298 ETH


   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0x87bd60c2b624418deaa7765e6b9064532cb9065d41ba45dcaa9c384aa3275c16
   > Blocks: 1            Seconds: 28
   > contract address:    0xEaBD2B2fDB397D7278d01969dD02230DD7BF1a20
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             127540
   > gas used:            800154
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01600308 ETH


   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0xf94da2694919c19f69b31e9a3494fbc6e2de881397e6d87aab3464bb0d32c835
   > Blocks: 0            Seconds: 8
   > contract address:    0xB23C6a488144CE80768Ba71c64869823f3925CD2
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             127545
   > gas used:            456515
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0091303 ETH


   Replacing 'ResonanceDataManage'
   -------------------------------
   > transaction hash:    0x1bc2b0fe95a1bd1ceda02df2e61f9c0bf0206134c136ccc9c907f83a04539706
   > Blocks: 1            Seconds: 8
   > contract address:    0x266D9de10aa4DBbE0344102e773695144A761656
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             127550
   > gas used:            2319420
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0463884 ETH


   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0x834357a2463fa79677f81a0d66889f1e23132ac9277ec25371473e466e0b8994
   > Blocks: 1            Seconds: 12
   > contract address:    0xe5C5793F675054ea957F6567D41FAbB6d5Be7fe0
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             127555
   > gas used:            5576557
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.11153114 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:            0.251365 ETH


Summary
=======
> Total deployments:   10
> Final cost:          0.251365 ETH

```