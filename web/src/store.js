import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    account: '',
    isMobile: false,
    myDetail: [
      30,
      3
    ],
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
      currentStepRaisedETH: 100.1234
    }
  },
  mutations: {
    GET_FUNDER_INFO: (state, data) => {
      state.myDetail = data
    },
    GET_OFFER_INFO: (state, data) => {
      return Object.assign(state.offerData, data)
    },
    GET_CURRENT_STEP_FUNDS_INFO: (state, data) => {
      return Object.assign(state.homeData, data)
    },
  },
  actions: {
    async getFunderInfo({ commit }) {
      commit('GET_FUNDER_INFO', [3000, 23])
    },
    async getBuildingPeriodInfo({ commit }) {
      commit('GET_OFFER_INFO', {})
    },
    async getFundingPeriodInfo({ commit }) {
      commit('GET_OFFER_INFO', {})
    },
    async getCurrentStepFundsInfo({ commit }) {
      commit('GET_CURRENT_STEP_FUNDS_INFO', {})
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
