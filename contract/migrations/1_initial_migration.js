const Migrations = artifacts.require("Migrations");
const ABCToken = artifacts.require("ABCToken");

const UintUtils = artifacts.require("UintUtils");
const StringUtils = artifacts.require("StringUtils");


const FissionReward = artifacts.require("FissionReward");
const FOMOReward = artifacts.require("FOMOReward");
const LuckyReward = artifacts.require("LuckyReward");
const FaithReward = artifacts.require("FaithReward");
const Resonance = artifacts.require("Resonance");

const beneficiaryAddr = "0x0ac26115fEacba375dA2eF39648A87A30519dCB9";
const initialFissionPerson = "0xAE553492128FfE03Eae35Ea002839A4363E36495";

module.exports = function (deployer) {
    deployer.then(async () => {
        await deployer.deploy(Migrations)

        await deployer.deploy(UintUtils)
        await deployer.link(UintUtils, [FissionReward, FOMOReward, LuckyReward, FaithReward, Resonance]);

        await deployer.deploy(StringUtils)
        await deployer.link(StringUtils, [FissionReward, FOMOReward, LuckyReward, FaithReward, Resonance]);

        await deployer.deploy(ABCToken, "ABCToken", "ABCT", 18)

        await deployer.deploy(FissionReward)
        await deployer.deploy(FOMOReward)
        await deployer.deploy(LuckyReward)
        await deployer.deploy(FaithReward)


        let ABCTInstance = await ABCToken.deployed()
        let FissionRewardInstance = await FissionReward.deployed()
        let FOMORewardInstance = await FOMOReward.deployed()
        let LuckyRewardInstance = await LuckyReward.deployed()
        let FaithRewardInstance = await FaithReward.deployed()


        await deployer.deploy(Resonance, ABCTInstance.address, beneficiaryAddr, initialFissionPerson, FissionRewardInstance.address, FOMORewardInstance.address, LuckyRewardInstance.address, FaithRewardInstance.address)
        // let ResonanceInstance = await Resonance.deployed()

        return Promise.all([
            // ResonanceInstance.toBeFissionPerson("0x2012E149fc31F4D45b17796177c4f771C33D7a61")
        ])
    })
}

// // module.exports = function (deployer) {
// //     deployer.deploy(Migrations);
// //     deployer.deploy(UintUtils);
// //     deployer.deploy(StringUtils);
// //     deployer.deploy(ABCToken, "ABCToken", "ABCT", 18);
// // };

// var Migrations = artifacts.require('./Migrations.sol');

// module.exports = function (deployer) {
//     deployer.deploy(Migrations);
// };