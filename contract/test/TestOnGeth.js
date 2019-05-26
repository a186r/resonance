var ABCToken = artifacts.require('ABCToken');
var Resonance = artifacts.require('Resonance');
var FissionReward = artifacts.require('FissionReward');
var FOMOReward = artifacts.require('FOMOReward');
var LuckyReward = artifacts.require('LuckyReward');
var FaithReward = artifacts.require('FaithReward');


var abcToken;
var resonance;

var abcTokenAddress = "0xcB75DEbe73716F6c512a90D01B42093622f3699E";

var fissionRewardAddress = "0x172f683F020F9ea487eAbCc6ef0b034F98d40F5d";
var FOMORewardAddress = "0x45398972283b0309e3f9fd44c7D5eFfc7D7Ad6dd";
var luckyRewardAddress = "0x1b9ABec5BACAB876f211726B24A65B87ef7d1437";
var faithRewardAddress = "0xb4886428b786db5cc6a00F7de04a29d4bbB7e2d6";
var resonanceAddress = "0x0383607D453588cDB96bF4E46F93CeBf902aF2bA";

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
        
        abcToken = await ABCToken.at(abcTokenAddress);

        let ress = await abcToken.mintToken({
            from: account0
        });

        console.log(ress);

        let balanceOf0 = await abcToken.balanceOf(account0) / 1E18;

        console.log("0-----账户0的余额是：", balanceOf0.toString());

        await abcToken.transfer(account1, web3.utils.toWei("1000"), {
            from: account0
        });

        console.log("地址余额", await abcToken.balanceOf(account1) / 1E18);

    });

    it('1...成为裂变者', async () => {

        resonance = await Resonance.at(resonanceAddress);

        await abcToken.approve(resonance.address, web3.utils.toWei("8"), {
            from: account0
        });

        console.log("合约token余额1是", await abcToken.balanceOf(resonance.address) / 1E18);

        // 变为裂变者
        let result = await resonance.toBeFissionPerson(account1, {
            from: account0
        });

        console.log(result);

        console.log("合约token余额是", await abcToken.balanceOf(resonance.address) / 1E18);

        // 查一下账户1的余额
        let balanceOf1 = await abcToken.balanceOf(account1) / 1E18;
        console.log("账户1作为推广者，余额是：",balanceOf1);
    });
})