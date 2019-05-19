<template>
  <div class="home">
    <el-row>
      <el-col class="col-flex-column"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="title dark-card">
          <p>组建期</p>
          <p>CAD: {{homeData.currentStepTokenAmount}} CAD</p>
          <router-link to="/offer">（点击进入组建期页面）</router-link>
        </div>
        <div class="intro dark-card">
          <p>组建期规则</p>
          <div class="detail">
            <p>规则一：一二三阿萨德阿萨德奥森奥森阿萨德</p>
            <p>规则一：一二三阿萨德阿萨德奥森奥森阿萨德</p>
            <p>规则一：一二三阿萨德阿萨德奥森奥森阿萨德</p>
            <p>规则一：一二三阿萨德阿萨德奥森奥森阿萨德</p>
            <p>规则一：一二三阿萨德阿萨德奥森奥森阿萨德</p>
          </div>
        </div>
      </el-col>
      <el-col class="col-flex-column"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="title dark-card">
          <p>募资期</p>
          <p>ETH: {{homeData.currentStepRaisedETH}} ETH</p>
          <router-link to="/offer">（点击进入募资期页面）</router-link>
        </div>
        <div class="intro dark-card">
          <p>募资期规则</p>
          <div class="detail">
            <p>规则一：一二三阿萨德阿萨德奥森奥森阿萨德</p>
            <p>规则一：一二三阿萨德阿萨德奥森奥森阿萨德</p>
            <p>规则一：一二三阿萨德阿萨德奥森奥森阿萨德</p>
            <p>规则一：一二三阿萨德阿萨德奥森奥森阿萨德</p>
            <p>规则一：一二三阿萨德阿萨德奥森奥森阿萨德</p>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import store from '../store'
import { mapState, mapGetters, mapActions } from 'vuex'
import { formatEth } from '../utils/ethUtils'

export default {
  name: 'home',
  components: {
  },
  data() {
    return {
    }
  },
  computed: {
    ...mapState({
      homeData: state => state.homeData,
    })
  },
  methods: {
    async getInfo() {
      const contract = await new web3.eth.Contract(
        ContractJson.abi,
        ContractJson["networks"][web3.currentProvider.connection.networkVersion].address
      )
      contract.getPastEvents("LogClosedBet", {
        fromBlock: 4000000
      })
      .then(
        (event) => {
          console.log(event)
        })
      .catch(
        error => {
          console.log(error);
        }
      )
      // contract.methods.getCurrentStepFundsInfo().call({}, (err, result) => {
      //   console.log(err, formatEth(result), contract.address)
      // })
    }
  },
  mounted() {
    store.dispatch('getCurrentStepFundsInfo')
  }
}
</script>
<style lang='scss'>
.home {
  // display: flex;
  height: 100%;
  width: 100%;
  align-items: center;
  justify-content: space-around;
  .divide {
    width: 0.02rem;
    height: 90%;
    background-color: #fff;
  }
  .title {
    margin-top: 0.3rem;
    height: 1rem;
    width: 80%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    :nth-child(3) {
      font-weight: bold;
    }
  }
  .intro {
    display: flex;
    flex-direction: column;
    margin-top: 0.3rem;
    padding-bottom: 0.2rem;
    // height: 100%;
    p {
      margin-top: 0.2rem;
      text-align: center;
    }
    .detail {
      display: flex;
      flex: 1;
      flex-direction: column;
      justify-content: space-around;
      font-size: 0.15rem;
    }
    margin-bottom: 0.2rem;
  }
}
</style>
