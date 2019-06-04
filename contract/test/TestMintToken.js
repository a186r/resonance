var ABCToken = artifacts.require('ABCToken');

var abcToken;

const tokenName = "ABCToken";
const symbol = "ABCT";
const decimals = web3.utils.toBN(18);

contract('TestResonance', async (accounts) => {
    it('0...初始化ABCToken', async () => {
        abcToken = await ABCToken.new("ABCToken", "ABCT", decimals, {
            from: "319262a8dc487c417d9e88358b7f7ea6f4cad292caab80fbc95de8b8b12af3e5"
        });

        let mint0 = await abcToken.mintToken({
            from: "319262a8dc487c417d9e88358b7f7ea6f4cad292caab80fbc95de8b8b12af3e5"
        });

        // let mint1 = await abcToken.mintToken({
        //     from: accounts[1]
        // });

        // let mint2 = await abcToken.mintToken({
        //     from: accounts[2]
        // });

        // let balanceOf0 = await abcToken.balanceOf(accounts[0]) / 1E18;
        // console.log("0-----账户0的余额是：", balanceOf0.toString());

        // let balanceOf1 = await abcToken.balanceOf(accounts[1]) / 1E18;
        // console.log("1-----账户1的余额是：", balanceOf1.toString());

        // let balanceOf2 = await abcToken.balanceOf(accounts[2]) / 1E18;
        // console.log("2-----账户2的余额是：", balanceOf2.toString());

        // console.log(mint2);

    });
})