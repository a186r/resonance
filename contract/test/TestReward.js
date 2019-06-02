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

var winners = new Array();
contract('TestResonance', async (accounts) => {

    it('1...初始化ABCToken', async () => {
        abcToken = await ABCToken.new(tokenName, symbol, decimals, {
            from: accounts[0]
        });

        await abcToken.mintToken({
            from: accounts[0]
        });

        await abcToken.transfer(accounts[1], web3.utils.toWei("1000"), {
            from: accounts[0]
        });

        for (var i = 0; i <= 9; i++) {
            await abcToken.transfer(accounts[i], web3.utils.toWei("2000"), {
                from: accounts[0]
            });
        }

    });

    it('2...部署奖励合约', async () => {
        fissionReward = await FissionReward.new();
        FOMOReward = await FOMOReward.new();
        luckyReward = await LuckyReward.new();
        faithReward = await FaithReward.new();
    });

    it('3...初始化权限', async () => {
        resonanceDataManage = await ResonanceDataManage.new(
            fissionReward.address,
            FOMOReward.address,
            luckyReward.address,
            faithReward.address
        );

        await resonanceDataManage.allowAccess(accounts[0], {
            from: accounts[0]
        })
    });

    it('4...初始化参数', async () => {
        resonance = await Resonance.new(
            resonanceDataManage.address,
            abcToken.address,
            fissionReward.address,
            FOMOReward.address,
            luckyReward.address,
            faithReward.address
        );
        await resonance.setBlockHash(0);

        await resonanceDataManage.allowAccess(resonance.address, {
            from: accounts[0]
        });

        await resonance.initParamForFirstStep(accounts[0], accounts[8], accounts[7]);
    })

    it('5...成为裂变者', async () => {

        // 允许合约具有转账权
        for (var i = 0; i <= 8; i++) {
            await abcToken.approve(resonance.address, web3.utils.toWei("8"), {
                from: accounts[i]
            });

            // 变为裂变者
            await resonance.toBeFissionPerson(accounts[7], {
                from: accounts[i]
            });
        }
    });

    it("6...设置当前轮次募资目标", async () => {
        await resonance.setRaiseTarget(web3.utils.toWei("12"));
    });

    it("7...基金会转入Token", async () => {
        // 基金会授权合约Token额度
        await abcToken.approve(resonance.address, web3.utils.toWei("150000000"), {
            from: accounts[0]
        });

        await resonance.transferToken();
    });

    it("8...组建期社区成员转入Token", async () => {
        // 社区成员accounts[3]授予合约额度
        await abcToken.approve(resonance.address, web3.utils.toWei("2000"), {
            from: accounts[3]
        });

        await abcToken.approve(resonance.address, web3.utils.toWei("2000"), {
            from: accounts[0]
        });

        await abcToken.approve(resonance.address, web3.utils.toWei("2000"), {
            from: accounts[1]
        });

        await abcToken.approve(resonance.address, web3.utils.toWei("2000"), {
            from: accounts[2]
        });

        // 转入Token，参与共建
        await resonance.jointlyBuild(web3.utils.toWei("500"), {
            from: accounts[0]
        });

        await resonance.jointlyBuild(web3.utils.toWei("500"), {
            from: accounts[1]
        });

        await resonance.jointlyBuild(web3.utils.toWei("500"), {
            from: accounts[2]
        });

        await resonance.jointlyBuild(web3.utils.toWei("500"), {
            from: accounts[3]
        });
    });

    it("9...募资期社区成员转入ETH", async () => {
        // await resonance.send(web3.utils.toWei("3"), {
        //     from: accounts[0]
        // });

        // await resonance.send(web3.utils.toWei("3"), {
        //     from: accounts[4]
        // });

        // await resonance.send(web3.utils.toWei("3"), {
        //     from: accounts[1]
        // });

        // await resonance.send(web3.utils.toWei("1"), {
        //     from: accounts[2]
        // });

        // await resonance.send(web3.utils.toWei("1"), {
        //     from: accounts[3]
        // });

        await resonance.send(web3.utils.toWei("12"), {
            from: accounts[2]
        });
    });

    it("10...结算当前轮次", async () => {
        // winners[0] = accounts[0];
        // winners[1] = accounts[1];
        winners[2] = accounts[2];
        // winners[3] = accounts[3];
        // winners[4] = accounts[4];

        await resonance.settlementStep(
            winners,
            winners, {
                from: accounts[0]
        });


        await resonance.setRaiseTarget(web3.utils.toWei("12"));

        await abcToken.approve(resonance.address, web3.utils.toWei("2000"), {
            from: accounts[2]
        });

        // 转入Token，参与共建
        await resonance.jointlyBuild(web3.utils.toWei("500"), {
            from: accounts[0]
        });

        await resonance.send(web3.utils.toWei("12"), {
            from: accounts[2]
        });

        winners[2] = accounts[2];
        // winners[3] = accounts[3];
        // winners[4] = accounts[4];
        winners[3] = accounts[3];
        winners[4] = accounts[4];


        await resonance.settlementStep(
            winners,
            winners, {
                from: accounts[0]
        });

        await resonance.settlementFaithReward(winners);

    })

    it("11...getFunderRewardInfo",async() => {
        let getFunderRewardInfoLog = await resonance.getFunderRewardInfo({
            from:accounts[2]
        });

        // console.log("用户FOMO所得：", await FOMOReward.getFOMORewardAmount({from:accounts[2]}));
        // console.log("用户裂变所得：", await fissionReward.getFissionRewardAmount({from:accounts[2]}));

        // console.log("用户奖金所得：", getFunderRewardInfoLog);


        console.log("幸运奖励信息：",await luckyReward.getLuckyInfo(0));

        console.log("裂变奖励信息：",await fissionReward.getFissionInfo(0));

        console.log("FOMO奖励所得：",await FOMOReward.getFOMOWinnerInfo(0));

        console.log("信仰奖励所得：",await faithReward.getFaithWinnerInfo(1, {from:accounts[7]}));

        // console.log("FOMO奖励所得：",await FOMOReward.getTotalRewardAmount(0));

    })

    it("12...getFunderFundsByStep", async() => {
        // let getFunderFundsByStepLog = await resonance.getFunderFundsByStep(0,{
        //     from:accounts[2]
        // });
        // console.log("用户可提取资金：",getFunderFundsByStepLog);

        // 可提取Token数量：125333
        // 可提取ETH数量：0.5
        // 组建期共投资Token金额：500
        // 募集期共投资ETH数量：2
    })
})