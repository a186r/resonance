import BigNumber from 'bignumber.js'

export function formatEth(inWei) {
  return new BigNumber(inWei).dividedBy(oneEthInWei()).toString();
}

export function oneEthInWei() {
  return new BigNumber(1e18);
}

export function ethToWei(inEth) {
  return inEth * oneEthInWei();
}

export function weiToEth(inWei) {
  return inWei / oneEthInWei();
}

export function formatToken(inWei, dec = 0) {
  if (dec === 0)
    return inWei;
  return new BigNumber(inWei).dividedBy((new BigNumber(10)).toPower(dec)).toString();
}

export function getBytes32(str) {
  return web3.utils.fromAscii(str)
}

export function getStr(bytes32) {
  return web3.utils.hexToAscii(bytes32)
}
