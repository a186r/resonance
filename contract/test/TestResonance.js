var ABCToken = artifacts.require('ABCToken');
var Resonance = artifacts.require('Resonance');
var FissionReward = artifacts.require('FissionReward');
var FOMOReward = artifacts.require('FOMOReward');
var LuckyReward = artifacts.require('LuckyReward');
var FaithReward = artifacts.require('FaithReward');


var abcToken;
var resonance;

var abcTokenAddress;

var fissionReward;
var FOMOReward;
var luckyReward;
var faithReward;

const tokenName = "ABCToken";
const symbol = "ABCT";
const decimals = web3.utils.toBN(18);


contract('TestResonance', async (accounts) => {

    it('0...初始化ABCToken', async () => {
        abcToken = await ABCToken.new("ABCToken", "ABCT", decimals);

        await abcToken.mintToken({
            from: accounts[0]
        });

        let balanceOf0 = await abcToken.balanceOf(accounts[0]) / 1E18;
        console.log("0-----账户0的余额是：", balanceOf0.toString());

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
        luckyReward = await LuckyReward.new();;
        faithReward = await FaithReward.new();;
    });

    it('1...成为裂变者', async () => {
        // await accounts[0].eth.transfer(web3.utils.toWei("20"));

        resonance = await Resonance.new(
            abcToken.address,
            accounts[0],
            accounts[0],
            fissionReward.address,
            FOMOReward.address,
            luckyReward.address,
            faithReward.address
        );

        // 允许合约具有转账权
        // for (var i = 0; i <= 0; i++) {
        //     await abcToken.approve(resonance.address, web3.utils.toWei("8"), {
        //         from: accounts[i]
        //     });

        //     let allowanceAmount = await abcToken.allowance(accounts[i], resonance.address);
        //     console.log("获得的可挪用额度是", allowanceAmount.toString() / 1E18);

        //     // 变为裂变者
        //     // let result = await resonance.toBeFissionPerson(accounts[0], {
        //     //     from: accounts[i]
        //     // });

        //     // console.log(await abcToken.balanceOf(accounts[i]) / 1E18);
        // }

        await abcToken.approve(resonance.address, web3.utils.toWei("8"), {
            from: accounts[1]
        });

        // 变为裂变者
        let result = await resonance.toBeFissionPerson(accounts[2], {
            from: accounts[1]
        });

        console.log(await abcToken.balanceOf(accounts[2]) / 1E18);

        // account 1授权给合约的token数
        // let amount = await abcToken.allowance(accounts[2],resonance.address);

        console.log(result);

        console.log("合约token余额是", await abcToken.balanceOf(resonance.address) / 1E18);

        // 查一下账户1的余额
        let balanceOf1 = await abcToken.balanceOf(accounts[1]) / 1E18;
        console.log(balanceOf1);
    });
})