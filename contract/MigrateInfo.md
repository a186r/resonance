## 部署信息
- **合约部署在Ropsten测试网上**

- **ABCToken是测试用的Token合约，在该地址上调用mintToken()即可生成测试Token**

- **其他的业务接口和查询接口都在Resonance地址上调用**

#### 合约地址：

```
UintUtils：0x6E76D925471eb5E9B6D801aD3aAC306c0f6df3E1
StringUtils：0xCB75D8BA14039716D1185b409DFA7baf3a315730
ABCToken：0x8812C064802A52f3283F8875d3DB15059Fd5d02D
FissionReward：0x693Ac35cD8383fb82E0aa45674DDeBfe95dac77B
FOMOReward：0xadEbae7e8923e496303B2E734fDd77C8d85Fe983
LuckyReward：0xD32e070AD98D230c217f10dc2A34602b16fda3a5
FaithReward：0x328b1808dFfd9d88C13DAeEDd8Af34Ff4780F816
Resonance：0x8AAecc198dd825f09C1C8f862e737cf3f2b026D8
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
> Artifacts written to /Users/a186r/dev/sourcecode/contracts/contract/contract/build/contracts
> Compiled successfully using:
   - solc: 0.5.2+commit.1df8f40c.Emscripten.clang


Starting migrations...
======================
> Network name:    'ropsten'
> Network id:      3
> Block gas limit: 0x7a1200


1_initial_migration.js
======================

   Replacing 'Migrations'
   ----------------------
   > transaction hash:    0xfc0fc3d9c4833453db52f5f9eb7d815a3ad1429084aa7bfa8adc3289d29ac92d
   > Blocks: 1            Seconds: 14
   > contract address:    0x7910b89Cd7D3E138f11EE11fB6FA87A7c8Ee6a5A
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             5.738419542
   > gas used:            273162
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00546324 ETH


   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0x63fe602bbc875a48de40974db4f5030a9bf2e446e98c5865bcd852fa40d7263b
   > Blocks: 0            Seconds: 9
   > contract address:    0x6E76D925471eb5E9B6D801aD3aAC306c0f6df3E1
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             5.736234582
   > gas used:            109248
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00218496 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0x6E76D925471eb5E9B6D801aD3aAC306c0f6df3E1)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0x6E76D925471eb5E9B6D801aD3aAC306c0f6df3E1)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0xb8608f06c8e49781cedf3d68a0025b96417eb256acc1f73162aa294ea806a814
   > Blocks: 1            Seconds: 23
   > contract address:    0xCB75D8BA14039716D1185b409DFA7baf3a315730
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             5.721307902
   > gas used:            746334
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01492668 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0xCB75D8BA14039716D1185b409DFA7baf3a315730)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0xfcee30b68687425b1fb4495c96ffd25d85fc42f2d4bc67dabcb46bb606842cda
   > Blocks: 0            Seconds: 17
   > contract address:    0x8812C064802A52f3283F8875d3DB15059Fd5d02D
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             5.686237862
   > gas used:            1753502
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.03507004 ETH


   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0x863ff6e589c83b7d471f4ed1ab31a44c5b092b5de35b97682c1c9bdee11951d5
   > Blocks: 2            Seconds: 37
   > contract address:    0x693Ac35cD8383fb82E0aa45674DDeBfe95dac77B
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             5.661342682
   > gas used:            1244759
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02489518 ETH


   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0xff36df5f41ffa19043b954dffd9127dc25a9ebf99f2f02f9bff22cb43ebdc49d
   > Blocks: 0            Seconds: 25
   > contract address:    0xadEbae7e8923e496303B2E734fDd77C8d85Fe983
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             5.645364922
   > gas used:            798888
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01597776 ETH


   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0x80b26f12e8d116343a0e5c3aa185f6a47cbc1f285c51f5a84c2a15f8519a3c76
   > Blocks: 0            Seconds: 9
   > contract address:    0xD32e070AD98D230c217f10dc2A34602b16fda3a5
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             5.624997122
   > gas used:            1018390
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0203678 ETH


   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0x256d82bb0793f7d1df3af87e0e835da3cb5037df17be128a3755375781eed72c
   > Blocks: 1            Seconds: 9
   > contract address:    0x328b1808dFfd9d88C13DAeEDd8Af34Ff4780F816
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             5.609343462
   > gas used:            782683
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01565366 ETH


   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0x94e8f9b5900bfad60f7e8ed42ed8c8591763472c5e0ec2d7f5c4122c6198c1b8
   > Blocks: 0            Seconds: 9
   > contract address:    0x8AAecc198dd825f09C1C8f862e737cf3f2b026D8
   > account:             0x0ac26115fEacba375dA2eF39648A87A30519dCB9
   > balance:             5.502773682
   > gas used:            5328489
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.10656978 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:           0.2411091 ETH


Summary
=======
> Total deployments:   9
> Final cost:          0.2411091 ETH
```