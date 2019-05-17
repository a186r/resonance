var ABCToken = artifacts.require('ABCToken');
var Resonance = artifacts.require('Resonance');

var abcToken;
var resonance;

var abcTokenAddress;

const tokenName = "ABCToken";
const symbol = "ABCT";
const decimals = web3.utils.toBN(18);


contract('TestResonance', async (accounts) => {

    it('0...初始化ABCToken', async () => {
        abcToken = await ABCToken.new("ABCToken", "ABCT", decimals);

        let balanceOf0 = await abcToken.balanceOf(accounts[0]) / 1E18;
        console.log("0-----账户0的余额是：", balanceOf0.toString());

        // 把token分配给账户1、2，各1000个
        await abcToken.transfer(accounts[1], web3.utils.toWei("1000"));
        await abcToken.transfer(accounts[2], web3.utils.toWei("1000"));

    });

    it('1...成为裂变者', async () => {
        await accounts[0].eth.transfer(web3.utils.toWei("20"));

        // resonance = await Resonance.new(abcToken.address);

        // // 允许合约具有转账权
        // await abcToken.approve(resonance.address, web3.utils.toWei("8"), {
        //     from: accounts[2]
        // });

        // let allowanceAmount = await abcToken.allowance(accounts[2], resonance.address);
        // console.log(allowanceAmount.toString() / 1E18);

        // // account 2变为裂变者
        // let result = await resonance.toBeFissionPerson(accounts[1], 8, {
        //     from: accounts[2]
        // });

        // console.log(await abcToken.balanceOf(accounts[2]) / 1E18);
        // // account 1授权给合约的token数
        // // let amount = await abcToken.allowance(accounts[2],resonance.address);

        // console.log(result);

        // console.log(await abcToken.balanceOf(resonance.address) / 1E18);


        // // // 查一下9的余额
        // // let balanceOf9 = await abcToken.balanceOf(accounts[9]) / 1E18;
        // // console.log(balanceOf9);
    });
})