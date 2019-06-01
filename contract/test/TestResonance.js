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
        await resonance.setBlockHash(0);

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

        // accounts[9]成为共建者
        await abcToken.approve(resonance.address, web3.utils.toWei("8"), {
            from: accounts[9]
        });

        let result = await resonance.toBeFissionPerson(accounts[2], {
            from: accounts[9]
        });

        console.log("账户9的余额是：", await abcToken.balanceOf(accounts[9]) / 1E18);

        console.log("账户作为推广者，余额是：", await abcToken.balanceOf(accounts[7]) / 1E18);

    });

    it("6...设置当前轮次募资目标", async () => {
        await resonance.setRaiseTarget(web3.utils.toWei("12"));

        // console.log("当前轮次募资目标是：", await resonance.getRaiseTarget(0));
        // console.log("当前轮次募资目标是：", await resonance.getRaiseTarget(1));
    });

    it("7...基金会转入Token", async () => {
        // 查询组建期基金会应转入额度
        let getBuildingTokenAmount = await resonanceDataManage.getBuildingTokenAmount();
        // console.log("当前轮次组建期基金会应转入额度", getBuildingTokenAmount);

        // 基金会授权合约Token额度
        await abcToken.approve(resonance.address, web3.utils.toWei("150000000"), {
            from: accounts[0]
        });

        // let allowanceAmount = await abcToken.allowance(accounts[0], resonance.address);
        // // console.log("合约获得的授权额度是", allowanceAmount.toString() / 1E18);

        let result = await resonance.transferToken();
        // console.log(result);

    });

    it("8...组建期社区成员转入Token", async () => {
        // 社区成员accounts[3]授予合约额度
        await abcToken.approve(resonance.address, web3.utils.toWei("300"), {
            from: accounts[3]
        });

        await abcToken.approve(resonance.address, web3.utils.toWei("300"), {
            from: accounts[0]
        });

        await abcToken.approve(resonance.address, web3.utils.toWei("300"), {
            from: accounts[1]
        });

        await abcToken.approve(resonance.address, web3.utils.toWei("300"), {
            from: accounts[2]
        });

        // 查看授权额度
        // let allowanceAmount = await abcToken.allowance(accounts[3], resonance.address);
        // console.log("合约获得的授权额度是", allowanceAmount.toString() / 1E18);

        // 转入Token，参与共建
        await resonance.jointlyBuild(web3.utils.toWei("100"), {
            from: accounts[0]
        });

        await resonance.jointlyBuild(web3.utils.toWei("100"), {
            from: accounts[1]
        });

        await resonance.jointlyBuild(web3.utils.toWei("100"), {
            from: accounts[2]
        });

        await resonance.jointlyBuild(web3.utils.toWei("100"), {
            from: accounts[3]
        });

        // 社区成员accounts[3]的余额是
        // console.log("社区成员的余额是", await abcToken.balanceOf(accounts[3]) / 1E18);

    });

    it("9...募资期社区成员转入ETH", async () => {
        await resonance.send(web3.utils.toWei("3"), {
            from: accounts[0]
        });

        await resonance.send(web3.utils.toWei("3"), {
            from: accounts[1]
        });

        await resonance.send(web3.utils.toWei("1"), {
            from: accounts[2]
        });

        await resonance.send(web3.utils.toWei("1"), {
            from: accounts[3]
        });

        await resonance.send(web3.utils.toWei("1"), {
            from: accounts[2]
        });

        await resonance.send(web3.utils.toWei("1"), {
            from: accounts[2]
        });

        await resonance.send(web3.utils.toWei("1"), {
            from: accounts[2]
        });

        await resonance.send(web3.utils.toWei("1"), {
            from: accounts[2]
        });
    });

    it("10...获取投资者信息", async () => {
        // console.log(await resonance.getFunderInfo(0, {
        //     from: accounts[7]
        // }));
    })

    it("11...查询组建期信息", async () => {
        // console.log("查询组建期信息：", await resonance.getBuildingPerioInfo({
        //     from: accounts[0]
        // }));
    })

    it("12...查询募资期信息", async () => {
        // console.log("查询募资期信息：", await resonance.getFundingPeriodInfo({
        //     from: accounts[0]
        // }));
    })

    it("13...查询当前轮次信息", async () => {
        // console.log("查询当前轮次信息", await resonance.getCurrentStepFundsInfo({
        //     from: accounts[0]
        // }));
    })

    it("14...查询轮次funders信息", async () => {
        console.log("查询轮次funders信息:", await resonance.getStepFunders(0, {
            from: accounts[0]
        }));
    })

    it("15...结算当前轮次", async () => {

        console.log("结算前查询当前轮次:", await resonance.currentStep.call());

        winners[0] = accounts[0];
        winners[1] = accounts[1];
        winners[2] = accounts[2];
        winners[3] = accounts[3];
        winners[4] = accounts[4];
        winners[5] = accounts[5];
        winners[6] = accounts[6];


        let a = await resonance.settlementStep(
            winners,
            winners, {
                from: accounts[0]
            });

        // console.log("结算当前轮次奖励总金额：", a);

        console.log("当前轮次：", await resonance.currentStep.call());
    })

    it("16...结算已完成，提取Token", async () => {

        console.log("结算已完成，提取Token当前轮次：", await resonance.currentStep.call());

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

    it("18...结算已完成，提取ETH", async () => {
        console.log(await resonance.withdrawAllETH({
            from: accounts[2]
        }));
    })

    it("19...查询区块hash", async () => {
        let blockHash = await resonance.getBlockHash(0);
        // console.log(blockHash);
    })

    it("20...查询轮次funders信息(个人中心)", async () => {

        console.log("查询个人信息1：", await resonance.getFunderRewardInfo({from:accounts[8]}));
        console.log("查询个人信息AFF：", await resonance.getFunderAffInfo({from:accounts[9]}));
        console.log("查询个人信息Funds：", await resonance.getFunderFundsByStep(0, {from:accounts[3]}));

    })

    // getBuildingTokenFromParty
    it("21...查询基金会可转入Token额度", async() => {
        // 结算一下，进入第三轮

        // winners[0] = accounts[0];
        // winners[1] = accounts[1];
        // winners[2] = accounts[2];
        // winners[3] = accounts[3];
        // winners[4] = accounts[4];
        // winners[5] = accounts[5];
        // winners[6] = accounts[6];

        // let a = await resonance.settlementStep(
        //     winners,
        //     winners, {
        //         from: accounts[0]
        //     });
        
        // let aa = await resonance.settlementStep(
        //     winners,
        //     winners, {
        //         from: accounts[0]
        //     });

        // 查询共振是否结束
        console.log("共振是否结束：", await resonanceDataManage.getResonanceIsClosed());

        // let aa = await resonance.settlementStep(
        //     winners,
        //     winners, {
        //         from: accounts[0]
        //     });
    
        // console.log("查询组建期信息：", await resonance.getBuildingPerioInfo({
        //     from: accounts[0]
        // }));

        // console.log("基金会本轮次可转入额度：",await resonanceDataManage.getBuildingTokenFromParty() / 1E18);

        // console.log("查询当前轮次信息", await resonance.getCurrentStepFundsInfo({
        //     from: accounts[0]
        // }));
    })

    it("22...查询FOMO奖励列表",async() => {
        // console.log(await FOMOReward.getFOMOWinnerInfo(0));

        // console.log("查询当前轮次:", await resonance.currentStep.call());
        // 查看合约token余额
        // console.log("查看提取前合约Token余额", await abcToken.balanceOf(resonance.address) / 1E18);

        // 提走所有token和eth
        // await resonance.withdrawAllETHByOwner();

        // 查看合约token余额
        // console.log("查看提取前合约Token余额", await abcToken.balanceOf(resonance.address) / 1E18);

    })

    it("23...第二轮参与共建", async () => {
        // 社区成员accounts[3]授予合约额度
        // await abcToken.approve(resonance.address, web3.utils.toWei("100"), {
        //     from: accounts[2]
        // });

        // await abcToken.approve(resonance.address, web3.utils.toWei("100"), {
        //     from: accounts[3]
        // });


        // 查看授权额度
        // let allowanceAmount = await abcToken.allowance(accounts[3], resonance.address);
        // console.log("合约获得的授权额度是", allowanceAmount.toString() / 1E18);

        // 转入Token，参与共建
        await resonance.jointlyBuild(web3.utils.toWei("100"), {
            from: accounts[2]
        });

        await resonance.jointlyBuild(web3.utils.toWei("100"), {
            from: accounts[3]
        });

        // 社区成员accounts[3]的余额是
        // console.log("社区成员的余额是", await abcToken.balanceOf(accounts[3]) / 1E18);
        
    });
})