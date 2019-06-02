import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import Web3 from 'web3'
import BigNumber from 'bignumber.js'
import { formatEth, ethToWei } from './utils/ethUtils'

const web3 = new Web3()

Vue.use(Vuex)

function getFormat(data, decimal) {
  if (!data) { return 0 }
  if (data.toString() === '0') { return 0 }
  return BigNumber(web3.utils.fromWei(data.toString())).toFixed(decimal)
}

async function getStepIndex(contract) {
  return contract.methods.getCurrentStepFundsInfo().call()
}

function getReward(contract, methodName, stepIndex, account, index, commit) {
  let method
  if (methodName !== 'getFaithRewardInfo') {
    method = contract.methods[methodName](stepIndex)
  } else {
    method = contract.methods[methodName]()
  }
  method.call({
    from: account,
  }).then(res => {
    // console.log(stepIndex, index, methodName, res)
    res.index = index
    res[0] = getFormat(res[0], 5)
    if (index === 2) {
      res[2] = res[1].map((item, i) => getFormat(res[2], 5))
    } else {
      res[2] = res[1].map((item, i) => getFormat(res[2][i], 5))
    }
    console.log(stepIndex, index, methodName, res)
    commit('GET_REWARD_LIST', res)
  })
}

export default new Vuex.Store({
  state: {
    account: '',
    isBuilder: false,
    isMobile: false,
    isResonanceClosed: false,
    myDetail: {
      rewardList: [],
      funderAmount: {
        withdrawCAD: 0,
        withdrawETH: 0,
        allCAD: 0,
        allETH: 0,
        depositCAD: 0,
        depositETH: 0
      },
      funderInvite: {
        count: 0,
        reward: 0
      }
    },
    offerData: {
      bpCountdown: 0,
      fpCountdown: 0,
      currentRound: 0,
      remainingToken: 0,
      remainingETH: 0,
      totalTokenAmount: 0,
      totalETHAmount: 0,
      eachAddressLimit: 0
    },
    homeData: {
      currentStepTokenAmount: 0,
      currentStepRaisedETH: 0,
      stepIndex: 0
    },
    rewardList: {
      0: {},
      1: {},
      2: {},
      3: {}
    }
  },
  mutations: {
    GET_RESONANCE_IS_CLOSED: (state, data) => {
      console.log('------------------closed update', data)
      state.isResonanceClosed = data
    },
    GET_FUNDER_AMOUNT: (state, data) => {
      Object.assign(state.myDetail.funderAmount, data)
    },
    GET_FUNDER_REWARD: (state, data) => {
      state.myDetail.rewardList = data
    },
    GET_FUNDER_INVITE: (state, data) => {
      Object.assign(state.myDetail.funderInvite, data)
    },
    GET_OFFER_INFO: (state, data) => {
      Object.assign(state.offerData, data)
    },
    GET_CURRENT_STEP_FUNDS_INFO: (state, data) => {
      Object.assign(state.homeData, data)
    },
    GET_ADDRESS_IS_BUILDER: (state, data) => {
      state.isBuilder = data
    },
    GET_REWARD_LIST: (state, data) => {
      // console.log('reward ', data.index, data)
      const index = data.index
      const payload = {}
      payload[index] = data
      Object.assign(state.rewardList, payload)
    }
  },
  actions: {
    async getFunderInfo({ commit }, contract) {
      contract.methods.getFunderAffInfo().call({from: this.state.account}, (err, result) => {
        console.log('getFunderAffInfo', result)
        if (result) {
          const data = {}
          data.count = result[0].toString()
          data.reward = getFormat(result[1], 0)
          commit('GET_FUNDER_INVITE', data)
        }
      })
      contract.methods.getFunderRewardInfo().call({from: this.state.account}, (err, result) => {
        console.log('getFunderRewardInfo', result)
        for (let i in result) {
          result[i] = getFormat(result[i], 5)
        }
        commit('GET_FUNDER_REWARD', result)
      })
      const res = await getStepIndex(contract)
      if (res) {
        const arr = ['getFunderWithdrawTokenAmount', 'getFunderWithdrawETHAmount', 'getFunderTokenAmount', 'getFunderETHAmount']
        const properties = ['allCAD', 'allETH', 'depositCAD', 'depositETH']
        const stepIndex = res[0].toNumber()
        for (let i = 0; i < 4; i++) {
          contract.methods[arr[i]](stepIndex).call({from: this.state.account}, (err, result) => {
            console.log(err, stepIndex, arr[i], result)
            if (result) {
              const data = {}
              let decimal = 5
              if (i === 0 || i === 2) {
                decimal = 0
              }
              data[properties[i]] = getFormat(result, decimal)
              commit('GET_FUNDER_AMOUNT', data)
            }
          })
        }
        contract.methods.getFunderFundsByStep(stepIndex).call({from: this.state.account}, (err, result) => {
          console.log(err, stepIndex, 'getFunderFundsByStep', result)
          if (result) {
            const data = {}
            data.allCAD  = getFormat(result[0], 0)
            data.allETH = getFormat(result[1], 5)
            data.depositCAD = getFormat(result[2], 0)
            data.depositETH = getFormat(result[3], 5)
            commit('GET_FUNDER_AMOUNT', data)
          }
        })
      }
    },
    async getBuildingPeriodInfo({ commit }, contract) {
      contract.methods.getBuildingPerioInfo().call()
        .then(result => {
          console.log('get building info', result)
          const data = {}
          // data.bpCountdown = result[0].toNumber() * 1000
          data.remainingToken = getFormat(result[1], 0)
          data.eachAddressLimit = getFormat(result[2], 0)
          data.totalTokenAmount = getFormat(result[3], 0)
          commit('GET_OFFER_INFO', data)
        })
        .catch(err => {
          console.log(err)
        })
    },
    async getFundingPeriodInfo({ commit }, contract) {
      contract.methods.getFundingPeriodInfo().call()
        .then(result => {
          console.log('get funding info', result)
          const data = {}
          // data.fpCountdown = result[0].toNumber() * 1000
          data.remainingETH = getFormat(result[1], 5)
          data.totalETHAmount = getFormat(result[2], 5)
          commit('GET_OFFER_INFO', data)
        })
        .catch(err => {
          console.log(err)
        })
    },
    async getOpeningTime({ commit }, contract) {
      contract.methods.getOpeningTime().call()
        .then(result => {
          console.log('get opening time', result)
          const data = {}
          data.bpCountdown = (result.toNumber() * 1000) + 8 * 3600 * 1000 - new Date().getTime()
          data.fpCountdown = data.bpCountdown + 16 * 3600 * 1000
          commit('GET_OFFER_INFO', data)
        })
        .catch(err => {
          console.log(err)
        })
    },
    async getCurrentStepFundsInfo({ commit }, contract) {
      const self = this
      contract.methods.getCurrentStepFundsInfo().call()
        .then(result => {
          console.log('get current step info', result)
          const data = {}
          data.stepIndex = result[0].toNumber(),
          data.currentStepTokenAmount = getFormat(result[1], 0),
          data.currentStepRaisedETH = getFormat(result[2], 5),
          commit('GET_CURRENT_STEP_FUNDS_INFO', data)
        })
        .catch(err => {
          console.log(err)
        })
    },
    async depositETH({ commit }, amount) {
      const self = this
      const data = {
        from: self.state.account,
        to: window.contract.address,
        value: web3.utils.toWei(amount),
        gas: '0x52080'
      }
      window.web3.eth.sendTransaction(data)
      .then(res => {
        console.log(res)
      }).catch(err => {
        self._vm.$alert('Metamask 提交失败', '提示', {
          confirmButtonText: '确定',
        })
      })
    },
    async depositCAD({ commit }, amount) {
      // solidity function name: jointlyBuild
      const self = this
      window.contract.methods.jointlyBuild(web3.utils.toWei(amount)).send({
        from: self.state.account,
      }).then(res => {
        console.log(res)
      }).catch(err => {
        self._vm.$alert('Metamask 提交失败', '提示', {
          confirmButtonText: '确定',
        })
      })
    },
    async approve({ commit }, amount) {
      const self = this
      window.tokenContract.methods.approve(window.contract.address, web3.utils.toWei(String(amount))).send({
        from: self.state.account
      }).then(res => {
        console.log(res)
      }).catch(err => {
        self._vm.$alert('授权合约失败', '提示', {
          confirmButtonText: '确定',
        })
      })
    },
    async toBeFissionPerson({ commit }, address) {
      console.log(address)
      const self = this
      window.contract.methods.toBeFissionPerson(address).send({
        from: self.state.account
      }).then(res => {
        console.log(res)
      }).catch(function(error){
        self._vm.$alert('Metamask 提交失败', '提示', {
          confirmButtonText: '确定',
        })
      })
    }, 
    async withdrawAllETH({ commit }) {
      const self = this
      window.contract.methods.withdrawAllETH().send({
        from: this.state.account,
      }).then(res => {
        console.log(res)
      }).catch(err => {
        self._vm.$alert('Metamask 提交失败', '提示', {
          confirmButtonText: '确定',
        })
      })
    },
    async withdrawAllCAD({ commit }) {
      const self = this
      window.contract.methods.withdrawAllToken().send({
        from: this.state.account,
      }).then(res => {
        console.log(res)
      }).catch(err => {
        self._vm.$alert('Metamask 提交失败', '提示', {
          confirmButtonText: '确定',
        })
      })
    },
    async isBuilder({ commit }, contract) {
      contract.methods.isBuilder(this.state.account).call()
      .then(res => {
        commit('GET_ADDRESS_IS_BUILDER', res)
      })
    },
    async queryRewardList({commit}, contract) {
      if (window.contract) {
        const data = await getStepIndex(window.contract)
        const stepIndex = data[0].toNumber()
        const arr = ['getFissionRewardInfo', 'getFOMORewardIofo', 'getLuckyRewardInfo', 'getFaithRewardInfo']
        for (let i = 0; i < 4; i++) {
          getReward(contract, arr[i], Math.abs(stepIndex - 1), this.state.account, i, commit)
        }
      } else {
        const self = this
        setTimeout(() => {
          console.log('query reward list second time')
          self.dispatch('queryRewardList', contract)
        }, 1000)
      }
    },
    async startListenEvent({commit}, data) {
      const contract = data.contract
      const eventName = data.eventName
      contract.events[eventName]({}, (error, event) => { 
        console.log(eventName, 'initial event: ', event, event.returnValues)
        const data = {}
        const homeData = {}
        if (eventName === 'currentStepRaisedToken') {
          data.totalTokenAmount = getFormat(event.returnValues.raisedTokenAmount, 0)
          data.remainingToken = getFormat(event.returnValues.totalRemainingToken, 0)
          // data.eachAddressLimit = getFormat(event.returnValues.remainingTokenForPersonal, 0)
          homeData.currentStepTokenAmount = getFormat(event.returnValues.raisedTokenAmount, 0)
        } else if (eventName === 'currentStepRaisedEther') {
          data.totalETHAmount = getFormat(event.returnValues.raisedETHAmount, 5)
          data.remainingETH = getFormat(event.returnValues.totalRemainingEther, 5)
          homeData.currentStepRaisedETH = getFormat(event.returnValues.raisedETHAmount, 5)
        }
        commit('GET_OFFER_INFO', data)
        commit('GET_CURRENT_STEP_FUNDS_INFO', homeData)
      })
      .on('data', (event) => {
        console.log(eventName, 'listen event on data:', event)
      })
      .on('changed', (event) => {
        console.log(eventName, 'listen event on changed:', event)
      })
      .on('error', console.error)
    },
    async getWithdrawAmountPriv({commit}, contract) {
      const res = await getStepIndex(contract)
      if (!res || res[0].toNumber() === 0) {
        console.log('current step index is 0')
        return
      }
      contract.methods.getWithdrawAmountPriv().call({from: this.state.account}, (err, result) => {
        console.log(err, 'getWithdrawAmountPriv', result)
        if (result) {
          const data = {}
          data.withdrawCAD  = getFormat(result[0], 0)
          data.withdrawETH = getFormat(result[1], 5)
          commit('GET_FUNDER_AMOUNT', data)
        }
      })
    },
    async withdrawFaithRewardAndRefund({commit}) {
      const self = this
      window.contract.methods.withdrawFaithRewardAndRefund().send({
        from: self.state.account,
      }).then(res => {
        console.log(res)
      }).catch(err => {
        self._vm.$alert('Metamask 提交失败', '提示', {
          confirmButtonText: '确定',
        })
      })
    },
    async getResonanceIsClosed({commit}, contract) {
      contract.methods.getResonanceIsClosed().call()
      .then(res => {
        console.log('getResonanceIsClosed', res)
        if (res) {
          commit('GET_RESONANCE_IS_CLOSED', res)
        }
      })
    },
    async getRewardList({commit}, params) {
      const url = 'test.com'
      return await axios.get(url, {params}).then(
        res => {
          if (res.data.ok) {
            const data = res.data.data
          }
        }
      ).catch(err => {
        console.log(err)
      })
    }
  }
})
// 0x256DD44a34478AceC9A7da479DBcf0C3C599AD55
// 0xA8BA9dEa29234Be7504fAE477d2f6B1fd1078D46