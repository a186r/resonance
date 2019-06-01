import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import Web3 from 'web3'
import BigNumber from 'bignumber.js'
import { formatEth, ethToWei } from './utils/ethUtils'

const web3 = new Web3()

Vue.use(Vuex)

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
    res[0] = web3.utils.fromWei(res[0].toString())
    res[2] = res[1].map((item, i) => web3.utils.fromWei(res[2][i].toString()))
    console.log(stepIndex, index, methodName, res)
    commit('GET_REWARD_LIST', res)
  })
}

export default new Vuex.Store({
  state: {
    account: '',
    isBuilder: false,
    isMobile: false,
    myDetail: [],
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
      0: [],
      1: [],
      2: [],
      3: []
    }
  },
  mutations: {
    GET_FUNDER_INFO: (state, data) => {
      state.myDetail = data
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
      Object.assign(state.rewardList, {index: data})
    }
  },
  actions: {
    async getFunderInfo({ commit }, contract) {
      const stepIndex = this.state.homeData.stepIndex
      console.log('before get funder info ', stepIndex)
      contract.methods.getFunderInfo(stepIndex).call({from: this.state.account}, (err, result) => {
        console.log(err, 'get funder info', result)
        for (let i in result) {
          if (i === 2) {
            result[i] = result[i].toString()
          } else if (i === 0) {
            result[i] = BigNumber(web3.utils.fromWei(result[i].toString())).toFixed(0)
          } else {
            result[i] = web3.utils.fromWei(result[i].toString())
          }
        }
        if (result) {
          commit('GET_FUNDER_INFO', result)
        }
      })
    },
    async getBuildingPeriodInfo({ commit }, contract) {
      contract.methods.getBuildingPerioInfo().call()
        .then(result => {
          console.log('get building info', result)
          const data = {}
          // data.bpCountdown = result[0].toNumber() * 1000
          data.remainingToken = BigNumber(web3.utils.fromWei(result[1].toString())).toFixed(0)
          data.eachAddressLimit = web3.utils.fromWei(result[2].toString())
          data.totalTokenAmount = web3.utils.fromWei(result[3].toString())
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
          data.remainingETH = BigNumber(web3.utils.fromWei(result[1].toString())).toFixed(4)
          data.totalETHAmount = web3.utils.fromWei(result[2].toString())
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
          data.currentStepTokenAmount = web3.utils.fromWei(result[1].toString()),
          data.currentStepRaisedETH = web3.utils.fromWei(result[2].toString()),
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
    // async isBuilder({ commit }, contract) {
    //   contract.methods.getStepFunders(0).call({
    //     from: this.state.account,
    //   }).then(res => {
    //     console.log('funders: ', res)
    //     // commit('GET_ADDRESS_IS_BUILDER', res)
    //   }).catch(err => {
    //     console.log('funders err', err)
    //   })
    // },
    async queryRewardList({commit}, contract) {
      const stepIndex = 0 //this.state.homeData.stepIndex
      const arr = ['getFissionRewardInfo', 'getFOMORewardIofo', 'getLuckyRewardInfo', 'getFaithRewardInfo']
      for (let i = 0; i < 4; i++) {
        getReward(contract, arr[i], stepIndex, this.state.account, i, commit)
      }
    },
    async startListenEvent({commit}, data) {
      const contract = data.contract
      const eventName = data.eventName
      contract.events[eventName]({}, (error, event) => { 
        console.log(eventName, 'initial event: ', event, event.returnValues)
        const data = {}
        if (eventName === 'currentStepRaisedToken') {
          data.totalTokenAmount = web3.utils.fromWei(event.returnValues.raisedTokenAmount.toString())
        } else if (eventName === 'currentStepRaisedEther') {
          data.totalETHAmount = web3.utils.fromWei(event.returnValues.raisedETHAmount.toString())
        }
        commit('GET_OFFER_INFO', data)
      })
      .on('data', (event) => {
        console.log(eventName, 'listen event on data:', event)
      })
      .on('changed', (event) => {
        console.log(eventName, 'listen event on changed:', event)
      })
      .on('error', console.error)
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