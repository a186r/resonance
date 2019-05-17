const Migrations = artifacts.require("Migrations");
const ABCToken = artifacts.require("ABCToken");
const Resonance = artifacts.require("Resonance");

module.exports = function (deployer) {
    deployer.then(async () => {
        await deployer.deploy(Migrations)
        await deployer.deploy(ABCToken, "ABCToken", "ABCT", 18)

        let ABCTInstance = await ABCToken.deployed()

        // await deployer.deploy(Resonance, ABCTInstance)
        // let ResonanceInstance = await Resonance.deployed()

        return Promise.all([
            // ResonanceInstance.toBeFissionPerson("0x2012E149fc31F4D45b17796177c4f771C33D7a61")
        ])
    })
}