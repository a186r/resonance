var ABCToken = artifacts.require('ABCToken');
var Resonance = artifacts.require('Resonance');
var FissionReward = artifacts.require('FissionReward');
var FOMOReward = artifacts.require('FOMOReward');
var LuckyReward = artifacts.require('LuckyReward');
var FaithReward = artifacts.require('FaithReward');
var ResonanceDataManage = artifacts.require('ResonanceDataManage');

var abcToken;
var resonance;
var resonanceDataManage;

var fissionReward;
var FOMOReward;
var luckyReward;
var faithReward;

const tokenName = "ABCToken";
const symbol = "ABCT";
const decimals = web3.utils.toBN(18);

contract('TestResonance', async (accounts) => {

    it('0...初始化ABCToken', async () => {
        abcToken = await ABCToken.new("ABCToken", "ABCT", decimals, {
            from: accounts[0]
        });

        let ress = await abcToken.mintToken({
            from: accounts[0]
        });

        console.log(ress);

        let balanceOf0 = await abcToken.balanceOf(accounts[0]) / 1E18;
        console.log("0-----账户0的余额是：", balanceOf0.toString());

        await abcToken.transfer(accounts[1], web3.utils.toWei("1000"), {
            from: accounts[0]
        });
        console.log("地址余额", await abcToken.balanceOf(accounts[1]) / 1E18);

        // 把token分配给各账户，各1000个
        for (var i = 0; i <= 9; i++) {
            await abcToken.transfer(accounts[i], web3.utils.toWei("1000"), {
                from: accounts[0]
            });

            console.log("地址余额", await abcToken.balanceOf(accounts[i]) / 1E18);
        }

    });

    it('0...部署奖励合约', async () => {
        fissionReward = await FissionReward.new();
        FOMOReward = await FOMOReward.new();
        luckyReward = await LuckyReward.new();
        faithReward = await FaithReward.new();
    });

    it('1...初始化权限', async () => {
        resonanceDataManage = await ResonanceDataManage.new(
            fissionReward.address,
            FOMOReward.address,
            luckyReward.address,
            faithReward.address
        );

        let setAccessForAccounts0 = await resonanceDataManage.allowAccess(accounts[0], {
            from: accounts[0]
        })

        console.log(setAccessForAccounts0);

    });

    it('2...初始化参数', async () => {
        resonance = await Resonance.new(
            resonanceDataManage.address,
            abcToken.address,
            fissionReward.address,
            FOMOReward.address,
            luckyReward.address,
            faithReward.address
        );

        let setAccessForResonance = await resonanceDataManage.allowAccess(resonance.address, {
            from: accounts[0]
        })

        let initParamForFirstStepLog = await resonance.initParamForFirstStep(accounts[0], accounts[8], accounts[7]);

        console.log(initParamForFirstStepLog);
    })

    it('3...成为裂变者', async () => {

        // 允许合约具有转账权
        for (var i = 0; i <= 8; i++) {
            await abcToken.approve(resonance.address, web3.utils.toWei("8"), {
                from: accounts[i]
            });

            // let allowanceAmount = await abcToken.allowance(accounts[i], resonance.address);
            // console.log("获得的可挪用额度是", allowanceAmount.toString() / 1E18);

            // 变为裂变者
            let result = await resonance.toBeFissionPerson(accounts[7], {
                from: accounts[i]
            });
        }

        console.log("账户作为推广者，余额是：", await abcToken.balanceOf(accounts[7]) / 1E18);

    });

    it("4...设置当前轮次募资目标", async () => {
        await resonance.setRaiseTarget(5000);

        console.log("当前轮次募资目标是：", await resonance.getRaiseTarget(0));
        console.log("当前轮次募资目标是：", await resonance.getRaiseTarget(1));
    });

    it("5...基金会转入Token", async () => {
        // 基金会授权合约1亿Token额度

        await abcToken.approve(resonance.address, web3.utils.toWei("150000000"), {
            from: accounts[0]
        });

        let result = await resonance.transferToken();
        console.log(result);

        // 基金会地址余额

    });
})