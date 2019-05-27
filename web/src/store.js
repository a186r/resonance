import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import { formatEth, ethToWei } from './utils/ethUtils'


Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    account: '',
    isBuilder: false,
    isMobile: false,
    myDetail: [],
    offerData: {
      bpCountdown: 24 * 60 * 60 * 1000,
      fpCountdown: 24 * 60 * 60 * 1000,
      currentRound: 3,
      remainingToken: 3000,
      remainingETH: 23,
      totalTokenAmount: 5000000,
    },
    homeData: {
      currentStepTokenAmount: 10000000,
      currentStepRaisedETH: 100.1234,
      stepIndex: 1
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
      data.this.dispatch('queryRewardList', state.homeData.stepIndex)
    },
    GET_ADDRESS_IS_BUILDER: (state, data) => {
      state.isBuilder = data
    }
  },
  actions: {
    async getFunderInfo({ commit }, contract) {
      contract.methods.getFunderInfo(this.state.account).call({}, (err, result) => {
        console.log(err, result, contract.address)
      })
      commit('GET_FUNDER_INFO', [
        30,
        3,
        12,
        45,
        123,
        12345,
        23,
        1
      ])
    },
    async getBuildingPeriodInfo({ commit }) {
      contract.methods.getCurrentStepFundsInfo().call({}, (err, result) => {
        console.log(err, result, contract.address)
        commit('GET_OFFER_INFO', {})
      })
    },
    async getFundingPeriodInfo({ commit }) {
      contract.methods.getFundingPeriodInfo().call({}, (err, result) => {
        console.log(err, result, contract.address)
        commit('GET_OFFER_INFO', {})
      })
    },
    async getCurrentStepFundsInfo({ commit }, contract) {
      const self = this
      contract.methods.getCurrentStepFundsInfo().call({}, (err, result) => {
        console.log(err, result, contract.address)
        result.currentStepRaisedETH = 200.13
        result.this = self
        commit('GET_CURRENT_STEP_FUNDS_INFO', result)
      })
    },
    async depositETH({ commit }, amount) {
      console.log(window.contract, amount)
      const self = this
      web3.eth.sendTransaction({
        from: this.state.account,
        to: window.contract.address,
        value: ethToWei(amount)
      })
      .then(function(receipt){
        console.log(receipt)
      }).catch(err => {
        self._vm.$alert('Metamask 提交失败', '提示', {
          confirmButtonText: '确定',
        })
      })
    },
    async depositCAD({ commit }, amount) {
      // solidity function name: jointlyBuild
      console.log(amount)
      const self = this
      window.contract.methods.jointlyBuild(ethToWei(amount)).send({
        from: this.state.account,
      }).then(res => {
        console.log(res)
      }).catch(err => {
        self._vm.$alert('Metamask 提交失败', '提示', {
          confirmButtonText: '确定',
        })
      })
    },
    async toBeFissionPerson({ commit }, address) {
      console.log(address)
      const self = this
      contract.methods.toBeFissionPerson(address).send({
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
      contract.methods.isBuilder().call({
        from: this.state.account,
      }).then(res => {
        commit('GET_ADDRESS_IS_BUILDER', res)
      })
    },
    async queryRewardList({commit}, stepIndex) {
      window.contract.methods.getFissionRewardInfo().call({
        from: this.state.account,
      }).then(res => {
        commit('GET_REWARD_LIST', res)
      })
      window.contract.methods.getFOMORewardIofo().call({
        from: this.state.account,
      }).then(res => {
        commit('GET_REWARD_LIST', res)
      })
      window.contract.methods.getLuckyRewardInfo().call({
        from: this.state.account,
      }).then(res => {
        commit('GET_REWARD_LIST', res)
      })
      window.contract.methods.getFaithRewardInfo().call({
        from: this.state.account,
      }).then(res => {
        commit('GET_REWARD_LIST', res)
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
