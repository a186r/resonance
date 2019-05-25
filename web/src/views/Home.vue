<template>
  <div class="home">
    <el-row>
      <el-col class="col-flex-column"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="title dark-card">
          <div class="building-period">
            <div class="building-period-icon"></div>
            <p>{{ $t('index.buildingPeriodText') }}</p>
          </div>
          <div class="period-value">
            <div class="building-period-value"></div>
            <div class="period-value-enter">
              <p>CAD: <span class="value-span">{{homeData.currentStepTokenAmount}}</span> CAD</p>
              <div class="period-enter">
                <div></div>
                <router-link class="to-offer" to="/offer">点击进入组建期页面</router-link>
              </div>
            </div>
          </div>
        </div>
        <div class="intro">
          <p>{{ $t('index.buildingRulesText') }}</p>
          <div class="detail">
            <p>1. {{ $t('index.buildingRules[0]') }}</p>
            <p>2. {{ $t('index.buildingRules[1]') }}</p>
            <p>3. {{ $t('index.buildingRules[2]') }}</p>
            <p>4. {{ $t('index.buildingRules[3]') }}</p>
          </div>
        </div>
      </el-col>
      <el-col class="col-flex-column"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="title dark-card">
          <div class="funding-period">
            <div class="funding-period-icon"></div>
            <p >{{ $t('index.fundingPeriodText') }}</p>
          </div>
          <div class="period-value">
            <div class="funding-period-value"></div>
            <div class="period-value-enter">
              <p>ETH: <span class="value-span">{{homeData.currentStepRaisedETH}}</span> ETH</p>
              <div class="period-enter">
                <div></div>
                <router-link class="to-offer" to="/offer">点击进入募资期页面</router-link>
              </div>
            </div>
          </div>
        </div>
        <div class="intro">
          <p>{{ $t('index.fundingRulesText') }}</p>
          <div class="detail">
            <p>1. {{ $t('index.fundingRules[0]') }}</p>
            <p>2. {{ $t('index.fundingRules[1]') }}</p>
            <p>3. {{ $t('index.fundingRules[2]') }}</p>
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
  font-size: 0.14rem;
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
    .period-value {
      display: flex;
      margin-top: .1rem;
      .funding-period-value {
        width: .4rem;
        background-image: url('~@/assets/image/eth.png');
        background-repeat: no-repeat;
        background-size: .4rem;
        background-position-y: center;
      }
      .building-period-value {
        width: .4rem;
        background-image: url('~@/assets/image/cad.png');
        background-repeat: no-repeat;
        background-size: .4rem;
        background-position-y: center;
      }
      .period-value-enter {
        margin-left: .1rem;
        .period-enter {
          display: flex;
          div {
            width: .14rem;
            background-image: url('~@/assets/image/click.png');
            background-repeat: no-repeat;
            background-size: .14rem;
            background-position-y: center;
          }
        }
      }
    }
    .building-period {
      display: flex;
      justify-content: center;
      color: $theme;
      div {
        width: .18rem;
        background-image: url('~@/assets/image/building.png');
        background-repeat: no-repeat;
        background-size: .18rem;
        background-position-y: center;
      }
    }
    .funding-period {
      display: flex;
      justify-content: center;
      color: $theme;
      div {
        width: .18rem;
        background-position-y: center;
        background-image: url('~@/assets/image/funding.png');
        background-repeat: no-repeat;
        background-size: .18rem;
      }
    }
    :nth-child(3) {
      font-weight: bold;
    }
    .to-offer {
      color: $theme;
      font-size: .14rem;
    }
  }
  .intro {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 0.3rem;
    padding-top: .2rem;
    padding-bottom: 0.2rem;
    background-color: $dark-main;
    border-radius: 5px;
    width: 80%;
    .detail {
      display: flex;
      flex-direction: column;
      font-size: 0.14rem;
      width: 80%;
      p {
        margin-top: 0.2rem;
        text-align: left;
      }
    }
    margin-bottom: 0.2rem;
  }
}
</style>
