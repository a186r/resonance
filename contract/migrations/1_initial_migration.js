const Migrations = artifacts.require("Migrations");

const UintUtils = artifacts.require("UintUtils");

const FissionReward = artifacts.require("FissionReward");
const FOMOReward = artifacts.require("FOMOReward");
const LuckyReward = artifacts.require("LuckyReward");
const FaithReward = artifacts.require("FaithReward");
const Resonance = artifacts.require("Resonance");
const ResonanceDataManage = artifacts.require("ResonanceDataManage");

module.exports = function (deployer) {
    deployer.then(async () => {
        await deployer.deploy(Migrations)

        await deployer.deploy(UintUtils)
        await deployer.link(UintUtils, [FissionReward, FOMOReward, LuckyReward, FaithReward, Resonance, ResonanceDataManage]);

        await deployer.deploy(FissionReward)
        await deployer.deploy(FOMOReward)
        await deployer.deploy(LuckyReward)
        await deployer.deploy(FaithReward)

        let FissionRewardInstance = await FissionReward.deployed()
        let FOMORewardInstance = await FOMOReward.deployed()
        let LuckyRewardInstance = await LuckyReward.deployed()
        let FaithRewardInstance = await FaithReward.deployed()

        await deployer.deploy(
            ResonanceDataManage,
            FissionRewardInstance.address,
            FOMORewardInstance.address,
            LuckyRewardInstance.address,
            FaithRewardInstance.address
        )

        await deployer.deploy(
            Resonance,
            "0x809e634ea2f3c665ed9ec17f4e5a810f36c654af",
            ResonanceDataManage.address,
            FissionRewardInstance.address,
            FOMORewardInstance.address,
            LuckyRewardInstance.address,
            FaithRewardInstance.address
        )
    })
}