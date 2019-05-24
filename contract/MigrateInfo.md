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
> Artifacts written to /Users/a186r/dev/sourcecode/contracts/contract/contract/build/contracts
> Compiled successfully using:
   - solc: 0.5.2+commit.1df8f40c.Emscripten.clang


Starting migrations...
======================
> Network name:    'development'
> Network id:      123456
> Block gas limit: 0x7a1200


1_initial_migration.js
======================

   Replacing 'Migrations'
   ----------------------
   > transaction hash:    0x7013111e3765706ad65846ba9de2908b43e733aae8225eb0c8347f34e758bfac
   > Blocks: 0            Seconds: 4
   > contract address:    0x4e902318f07752e77d3C00122e42BEe4D8b56171
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             6595
   > gas used:            273162
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00546324 ETH


   Replacing 'UintUtils'
   ---------------------
   > transaction hash:    0x938039b255c4e9107d3b3e6b0d5a4731596e49be59a58a7d9011cb1dd4f917aa
   > Blocks: 1            Seconds: 8
   > contract address:    0x1d11642D617173095B32304d72C2bdF7CCB67C61
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             6605
   > gas used:            109248
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00218496 ETH


   Linking
   -------
   * Contract: FissionReward <--> Library: UintUtils (at address: 0x1d11642D617173095B32304d72C2bdF7CCB67C61)

   Linking
   -------
   * Contract: Resonance <--> Library: UintUtils (at address: 0x1d11642D617173095B32304d72C2bdF7CCB67C61)

   Replacing 'StringUtils'
   -----------------------
   > transaction hash:    0xd89fddfbacff786ac2206f0774bac238fb9a9233b2a662772e5fea59604bb7b1
   > Blocks: 0            Seconds: 24
   > contract address:    0x44DafF902Acb5bEd8a2f0E774AfFbfD7868ffF1f
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             6615
   > gas used:            746334
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01492668 ETH


   Linking
   -------
   * Contract: LuckyReward <--> Library: StringUtils (at address: 0x44DafF902Acb5bEd8a2f0E774AfFbfD7868ffF1f)

   Replacing 'ABCToken'
   --------------------
   > transaction hash:    0x1cdc61fbad238c84e491ffd157b6605511017ed6e13e023fa51947cba1c75630
   > Blocks: 0            Seconds: 16
   > contract address:    0x5AA434CEDca3C7e56a3DaDFEe82BcE76AD295C88
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             6620
   > gas used:            1852165
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0370433 ETH


   Replacing 'FissionReward'
   -------------------------
   > transaction hash:    0xb61ef2846aecfb0da907ffd2d96f64be23def43ac96fc35908e763aa31aa3f61
   > Blocks: 0            Seconds: 0
   > contract address:    0x980CeC5d6132fc1dE8A9f36609C0703DD1A6F5F2
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             6630
   > gas used:            1244759
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02489518 ETH


   Replacing 'FOMOReward'
   ----------------------
   > transaction hash:    0x5368bcbe11131f2708c7c38d45473d9b5f9f025d39cf76c3c8af57f9577083f9
   > Blocks: 0            Seconds: 0
   > contract address:    0x60BECE43266A24298dd3902Abf2aCe74C7c77495
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             6635
   > gas used:            864949
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01729898 ETH


   Replacing 'LuckyReward'
   -----------------------
   > transaction hash:    0x8fa4e0b44cdc5fd29495d6bd2239b499a332f7d186bbdd4916f6ed96a660ef08
   > Blocks: 1            Seconds: 4
   > contract address:    0x008F09e76180a55Bd0f546996187827c288422E6
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             6645
   > gas used:            1018390
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0203678 ETH


   Replacing 'FaithReward'
   -----------------------
   > transaction hash:    0x86657460dea5579fa54fc83e813ccc08dd460dab0b4fef86933739f06921b85d
   > Blocks: 0            Seconds: 4
   > contract address:    0x404392F8F927eeEe1ec26F2736503F7eC5AcBffA
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             6655
   > gas used:            591351
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01182702 ETH


   Replacing 'Resonance'
   ---------------------
   > transaction hash:    0xc2e6a58622db44bfa34c635e6283961adcfb26a335946fca13992a904bc6ecf9
   > Blocks: 0            Seconds: 4
   > contract address:    0x383a284f2D67c154bfe2e1CE6eD1c18Dd64ef5F2
   > account:             0xE7A1992ad776767c6478D8105F3A33389389c22B
   > balance:             6660
   > gas used:            6667262
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.13334524 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:           0.2673524 ETH


Summary
=======
> Total deployments:   9
> Final cost:          0.2673524 ETH

```