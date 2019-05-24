<template>
  <div class="home">
    <el-row>
      <el-col class="col-flex-column"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="title dark-card">
          <div class="building-period">
            <div class="building-period-icon"></div>
            <p >组建期</p>
          </div>
          <p>CAD: <span class="value-span">{{homeData.currentStepTokenAmount}}</span> CAD</p>
          <router-link class="to-offer" to="/offer">点击进入组建期页面</router-link>
        </div>
        <div class="intro">
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
          <div class="funding-period">
            <div class="funding-period-icon"></div>
            <p >募资期</p>
          </div>
          <p>ETH: <span class="value-span">{{homeData.currentStepRaisedETH}}</span> ETH</p>
          <router-link class="to-offer" to="/offer">点击进入募资期页面</router-link>
        </div>
        <div class="intro">
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

  },
  mounted() {
  }
}
</script>
<style lang='scss' scoped>
@import "../assets/variables.scss";

.home {
  // display: flex;
  font-size: 0.16rem;
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
    .building-period {
      display: flex;
      justify-content: center;
      div {
        width: .2rem;
        background-image: url('~@/assets/image/building.png');
        background-repeat: no-repeat;
        background-size: .2rem;
        background-position-y: center;
      }
    }
    .funding-period {
      display: flex;
      justify-content: center;
      div {
        width: .2rem;
        background-position-y: center;
        background-image: url('~@/assets/image/funding.png');
        background-repeat: no-repeat;
        background-size: .2rem;
      }
    }
    :nth-child(3) {
      font-weight: bold;
    }
    .to-offer {
      color: $theme;
    }
  }
  .intro {
    display: flex;
    flex-direction: column;
    margin-top: 0.3rem;
    padding-bottom: 0.2rem;
    background-color: $dark-main;
    border-radius: 5px;
    width: 80%;
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
