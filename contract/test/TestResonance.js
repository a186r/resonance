var ABCToken = artifacts.require('ABCToken');
var Resonance = artifacts.require('Resonance');
var FissionReward = artifacts.require('FissionReward');
var FOMOReward = artifacts.require('FOMOReward');
var LuckyReward = artifacts.require('LuckyReward');
var FaithReward = artifacts.require('FaithReward');


var abcToken;
var resonance;

var abcTokenAddress = "0x466567fe4644C7e7157B555Ef5E57A55a6cF075b";

var fissionRewardAddress = "0xbDDd4E25Dd900a9180051c56235D9D9c5C7D73b8";
var FOMORewardAddress = "0x923f6f9bd517fcab9859fED37e2aDe9FAD186D14";
var luckyRewardAddress = "0x2bBd3f4cC153aB05b9ca386037eAAaD43e094196";
var faithRewardAddress = "0xe6df1820464012850e59e50e15Da0511fc91d43D";
var resonanceAddress = "0xfC1a6608199ff203085abBFB895FF0eC1dC4c0b2";

var fissionReward;
var FOMOReward;
var luckyReward;
var faithReward;

const tokenName = "ABCToken";
const symbol = "ABCT";
const decimals = web3.utils.toBN(18);

const account0 = "0xE7A1992ad776767c6478D8105F3A33389389c22B";
const account1 = "0x1b2e39bdb251a17094c51604f7db0e4b2bb83b95";
const account2 = "0x68beda898fa561f539a6010a3e5ecf2aa8203862";
const account3 = "0x7d9c94704b2e745e0dec6212e58ca793e4f8586d";
const account4 = "0x2f45ddbf8978257f36f621aa27dd83864dc98075";
const account5 = "0x1d341abaf972aafb851798386cedc676222480a0";

contract('TestResonance', async (accounts) => {

    it('0...初始化ABCToken', async () => {
        abcToken = await ABCToken.new("ABCToken", "ABCT", decimals, {
            from: account0
        });
        // abcToken = ABCToken.at(abcTokenAddress);

        // await abcToken.mintToken();

        let balanceOf0 = await abcToken.balanceOf(account0) / 1E18;
        console.log("0-----账户0的余额是：", balanceOf0.toString());

        await abcToken.transfer(account1, web3.utils.toWei("1000"), {
            from: account0
        });
        console.log("地址余额", await abcToken.balanceOf(account1) / 1E18);

        // 把token分配给各账户，各1000个
        // for (var i = 0; i <= 9; i++) {
        //     await abcToken.transfer(accounts[i], web3.utils.toWei("1000"), {
        //         from: accounts[0]
        //     });

        //     console.log("地址余额", await abcToken.balanceOf(accounts[i]) / 1E18);
        // }

    });

    it('0...部署奖励合约', async () => {
        fissionReward = await FissionReward.at(fissionRewardAddress);
        FOMOReward = await FOMOReward.at(FOMORewardAddress);
        luckyReward = await LuckyReward.at(luckyRewardAddress);
        faithReward = await FaithReward.at(faithRewardAddress);
    });

    it('1...成为裂变者', async () => {
        // await accounts[0].eth.transfer(web3.utils.toWei("20"));

        // resonance = await Resonance.new(
        //     abcToken.address,
        //     accounts[0],
        //     accounts[0],
        //     fissionReward.address,
        //     FOMOReward.address,
        //     luckyReward.address,
        //     faithReward.address
        // );

        resonance = await Resonance.at(resonanceAddress);

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
            from: account0
        });

        // 变为裂变者
        let result = await resonance.toBeFissionPerson(account0, {
            from: account0
        });

        console.log(await abcToken.balanceOf(account0) / 1E18);

        // account 1授权给合约的token数
        // let amount = await abcToken.allowance(accounts[2],resonance.address);

        console.log(result);

        console.log("合约token余额是", await abcToken.balanceOf(resonance.address) / 1E18);

        // 查一下账户1的余额
        let balanceOf1 = await abcToken.balanceOf(account0) / 1E18;
        console.log(balanceOf1);
    });
})