import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
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
    getFunderInfo: async ({ commit }) => {
      commit('GET_FUNDER_INFO', [3000, 23])
    },
    getBuildingPeriodInfo: async ({ commit }) => {
      commit('GET_OFFER_INFO', {})
    },
    getFundingPeriodInfo: async ({ commit }) => {
      commit('GET_OFFER_INFO', {})
    },
    getCurrentStepFundsInfo: async ({ commit }) => {
      commit('GET_CURRENT_STEP_FUNDS_INFO', {})
    },
  }
})
