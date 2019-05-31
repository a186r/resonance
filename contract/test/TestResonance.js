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

        let ress = await abcToken.mintToken({
            from: accounts[0]
        });

        // console.log(ress);

        let balanceOf0 = await abcToken.balanceOf(accounts[0]) / 1E18;
        console.log("0-----账户0的余额是：", balanceOf0.toString());

        await abcToken.transfer(accounts[1], web3.utils.toWei("1000"), {
            from: accounts[0]
        });
        // console.log("地址余额", await abcToken.balanceOf(accounts[1]) / 1E18);

        // 把token分配给各账户，各1000个
        for (var i = 0; i <= 9; i++) {
            await abcToken.transfer(accounts[i], web3.utils.toWei("1000"), {
                from: accounts[0]
            });

            // console.log("地址余额", await abcToken.balanceOf(accounts[i]) / 1E18);
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

        let setAccessForAccounts0 = await resonanceDataManage.allowAccess(accounts[0], {
            from: accounts[0]
        })

        // console.log(setAccessForAccounts0);

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

        let setAccessForResonance = await resonanceDataManage.allowAccess(resonance.address, {
            from: accounts[0]
        });

        // console.log("设置合约访问权:", setAccessForResonance);

        let initParamForFirstStepLog = await resonance.initParamForFirstStep(accounts[0], accounts[8], accounts[7]);

        // console.log(initParamForFirstStepLog);
    })

    it('5...成为裂变者', async () => {

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

        // console.log("账户作为推广者，余额是：", await abcToken.balanceOf(accounts[7]) / 1E18);

    });

    it("6...设置当前轮次募资目标", async () => {
        await resonance.setRaiseTarget(30);

        // console.log("当前轮次募资目标是：", await resonance.getRaiseTarget(0));
        // console.log("当前轮次募资目标是：", await resonance.getRaiseTarget(1));
    });

    it("7...基金会转入Token", async () => {
        // 查询组建期基金会应转入额度
        let getBuildingTokenAmount = await resonanceDataManage.getBuildingTokenAmount();
        // console.log("当前轮次组建期基金会应转入额度", getBuildingTokenAmount);

        // 基金会授权合约Token额度
        await abcToken.approve(resonance.address, web3.utils.toWei("750000"), {
            from: accounts[0]
        });

        let allowanceAmount = await abcToken.allowance(accounts[0], resonance.address);
        // console.log("合约获得的授权额度是", allowanceAmount.toString() / 1E18);

        let result = await resonance.transferToken();
        // console.log(result);

    });

    it("8...组建期社区成员转入Token", async () => {
        // 社区成员accounts[3]授予合约额度
        await abcToken.approve(resonance.address, web3.utils.toWei("200"), {
            from: accounts[3]
        });

        await abcToken.approve(resonance.address, web3.utils.toWei("200"), {
            from: accounts[0]
        });

        await abcToken.approve(resonance.address, web3.utils.toWei("200"), {
            from: accounts[1]
        });

        await abcToken.approve(resonance.address, web3.utils.toWei("200"), {
            from: accounts[2]
        });

        // 查看授权额度
        let allowanceAmount = await abcToken.allowance(accounts[3], resonance.address);
        // console.log("合约获得的授权额度是", allowanceAmount.toString() / 1E18);

        // 转入Token，参与共建
        await resonance.jointlyBuild(100, {
            from: accounts[0]
        });

        await resonance.jointlyBuild(100, {
            from: accounts[1]
        });

        await resonance.jointlyBuild(100, {
            from: accounts[2]
        });

        await resonance.jointlyBuild(100, {
            from: accounts[3]
        });

        // 社区成员accounts[3]的余额是
        // console.log("社区成员的余额是", await abcToken.balanceOf(accounts[3]) / 1E18);

    });

    it("9...募资期社区成员转入ETH", async () => {
        await resonance.send(10, {
            from: accounts[0]
        });

        await resonance.send(10, {
            from: accounts[1]
        });

        await resonance.send(5, {
            from: accounts[2]
        });

        await resonance.send(5, {
            from: accounts[3]
        });
    });

    it("10...获取投资者信息", async () => {
        let funderInfo = await resonance.getFunderInfo({
            from: accounts[7]
        });
        // console.log(funderInfo);
    })

    it("11...查询组建期信息", async () => {
        let getBuildingPerioInfoLog = await resonance.getBuildingPerioInfo({
            from: accounts[0]
        });
        // console.log("查询组建期信息：", getBuildingPerioInfoLog);
    })

    it("12...查询募资期信息", async () => {
        let getFundingPeriodInfoLog = await resonance.getFundingPeriodInfo({
            from: accounts[0]
        });
        // console.log("查询募资期信息：", getFundingPeriodInfoLog);
    })

    it("13...查询当前轮次信息", async () => {
        let getCurrentStepFundsInfoLog = await resonance.getCurrentStepFundsInfo({
            from: accounts[0]
        });
        //      console.log("查询募资期信息：", getCurrentStepFundsInfoLog);
    })

    it("14...查询轮次funders信息", async () => {
        let getStepFundersLog = await resonance.getStepFunders(0, {
            from: accounts[0]
        });
        // console.log("查询轮次funders信息:", getStepFundersLog);
    })

    it("15...结算当前轮次", async () => {
        winners[0] = accounts[0];
        winners[1] = accounts[1];
        winners[2] = accounts[2];

        let a = await resonance.settlementStep(
            winners,
            winners, {
                from: accounts[0]
            });

        // console.log("结算当前轮次：", a);

        // console.log("当前轮次：", await resonance.currentStep.call());
    })

    it("16...结算已完成，提取Token和ETH", async () => {

        // 提取前合约Token余额
        console.log("提取前合约Token余额", await abcToken.balanceOf(resonance.address) / 1E18);

        // 提取前账户Token余额
        console.log("提取前账户Token余额", await abcToken.balanceOf(accounts[2]) / 1E18);

        await resonance.withdrawAllToken({
            from: accounts[2]
        });

        // 提取后账户Token余额
        console.log("提取后账户Token余额", await abcToken.balanceOf(accounts[2]) / 1E18);

        // 提取完成后合约Token余额
        console.log("提取完成后合约Token余额", await abcToken.balanceOf(resonance.address) / 1E18);

    })

    // it("17...结算信仰奖励", async () => {
    //     winners[0] = accounts[0];
    //     winners[1] = accounts[1];
    //     winners[2] = accounts[2];

    //     let b = await resonance.settlementFaithReward(
    //         winners, {
    //             from: accounts[0]
    //         }
    //     );
    // })
})