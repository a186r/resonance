var ResonanceDataManage = artifacts.require('ResonanceDataManage');

var resonanceDataManage;

contract('TestResonance', async (accounts) => {
    it('0...初始化resonanceDataManage', async () => {
        resonanceDataManage = await ResonanceDataManage.new(
            accounts[9],
            accounts[8],
            accounts[7],
            accounts[6], {
                from: accounts[0]
            });

        let logAllowAccess = await resonanceDataManage.allowAccess(accounts[1]);

        console.log(logAllowAccess);

        // let result = await resonanceDataManage.getAccess(accounts[1]).call;

        let logAllwAccess = await resonanceDataManage.allowAccess(accounts[2], {
            from: accounts[1]
        });

        let lsogAllwAccess = await resonanceDataManage.allowAccess(accounts[3], {
            from: accounts[4]
        });

        console.log(logAllwAccess);

    })
})