<template>
  <div class="offer">
    <el-row :gutter="40">
      <el-col class="col-flex" :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="period dark-card">
          <p>{{ $t('index.buildingPeriodText') }} {{ $t('offer.number') }} {{stepIndex + 1}} {{ $t('offer.round') }}</p>
          <countdown :time="offerData.bpCountdown" v-if="offerData.bpCountdown > 0">
            <template slot-scope="props">{{ $t('offer.countDown') }}：{{ props.hours }} {{ $t('offer.hour') }} : {{ props.minutes }} {{ $t('offer.minute') }} : {{ props.seconds }} {{ $t('offer.second') }}</template>
          </countdown>
          <p v-else>{{ $t('offer.buildingEnd') }}</p>
          <p>{{ $t('offer.remainCAD') }}：{{offerData.remainingToken}}</p>
          <p>{{ $t('offer.eachAddressLimit') }}：{{offerData.eachAddressLimit}}</p>
          <p>{{ $t('offer.totalRaisedCAD') }}：{{offerData.totalTokenAmount}}</p>
          <div class="deposit-area" v-if="isBuilder">
            <div class="deposit-area-input">
              <input class="custom-input" :disabled="!isBuilding" v-model="depostCADAmount" :placeholder="'CAD ' + $t('offer.depositAmount')" />
            </div>
            <button class="custom-button" :disabled="!isBuilding" @click="approve">{{ $t('offer.approveContract') }}</button>
            <button class="custom-button" :disabled="!isBuilding" @click="depositCAD">{{ $t('offer.depositCAD') }}</button>
          </div>
          <div class="deposit-area" v-else>
            <div class="deposit-area-input">
              <input class="custom-input" :disabled="!isBuilding" v-model="address" :placeholder="$t('offer.referrerAddress')" />
            </div>
            <button class="custom-button" :disabled="!isBuilding" @click="approveFission">{{ $t('offer.approveContract') }}</button>
            <button class="custom-button" :disabled="!isBuilding" @click="toBeFissionPerson">{{ $t('offer.toBeFission') }}</button>
          </div>
        </div>
      </el-col>
      <el-col class="col-flex" :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="period dark-card">
          <p>{{ $t('index.fundingPeriodText') }} {{ $t('offer.number') }} {{stepIndex + 1}} {{ $t('offer.round') }}</p>
          <countdown :time="offerData.fpCountdown" v-if="offerData.bpCountdown < 1">
            <template slot-scope="props">{{ $t('offer.countDown') }}：{{ props.hours }} {{ $t('offer.hour') }} : {{ props.minutes }} {{ $t('offer.minute') }} : {{ props.seconds }} {{ $t('offer.second') }}</template>
          </countdown>
          <p v-else>{{ $t('offer.fundingNotStart') }}</p>
          <p>{{ $t('offer.remainETH') }}：{{offerData.remainingETH}}</p>
          <div class="deposit-area">
            <div class="deposit-area-input">
              <input class="custom-input" :disabled="isBuilding" v-model="depostETHAmount" :placeholder="'ETH ' + $t('offer.depositAmount')" />
            </div>
            <button class="custom-button" :disabled="isBuilding" @click="depositETH">{{ $t('offer.depositETH') }}</button>
          </div>
        </div>
      </el-col>
    </el-row>
    <el-row :gutter="10">
      <el-col class="reward-list" :xs="12" :sm="12" :md="6" :lg="6" :xl="6" v-for="(item, i) in rewardList" :key="i">
        <div class="reward-area">
          <div class="reward-type">
            <div :class="rewardList[i].class"></div>
            <p>{{getText(i)}}</p>
          </div>
          <p>{{ $t('offer.currentTotalReward') }} <span class="value-span">{{rewardListData[i] && rewardListData[i][0]}}</span> ETH</p>
          <div class="reward-detail" v-if="rewardListData[i] && rewardListData[i][1] && rewardListData[i][1].length">
            <div class="reward-detal-item" v-for="j in rewardListData[i][1].length > 5 ? 5 : rewardListData[i][1].length" :key="j">
              <span class="rank">{{j > 3 ? j : ''}}  </span>
              <span class="address">{{rewardListData[i][1][j-1]}}</span>
              <span>：</span>
              <span>{{rewardListData[i][2][j-1]}} ETH</span>
            </div>
          </div>
          <div v-else>
            <span>{{ $t('offer.noData') }}</span>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import store from '../store'
import { mapState, mapGetters, mapActions } from 'vuex'
import ResonanceDataManageJson from '../../../contract/build/contracts/ResonanceDataManage.json'

export default {
  name: 'offer',
  data () {
    return {
      approveAmount: 0,
      buildingText: '组建期',
      depostCADAmount: '',
      depostETHAmount: '',
      address: '',
      rewardList: [{
          cn: '裂变奖励',
          class: 'fission',
          value: 23,
          en: 'Fission reward'
        },{
          cn: 'FOMO 奖励',
          class: 'fomo',
          value: 23,
          en: 'FOMO reward'
        },
        {
          cn: '幸运奖励',
          class: 'lucky',
          value: 23,
          en: 'Lucky prize'
        },{
          cn: '信仰奖励',
          class: 'faith',
          value: 23,
          en: 'Faith reward'
        }
      ]
    }
  },
  computed: {
    ...mapState({
      offerData: state => state.offerData,
      stepIndex: state => state.homeData.stepIndex,
      isBuilder: state => state.isBuilder,
      rewardListData: state => state.rewardList,
      isBuilding: state => state.offerData.bpCountdown > 0
    })
  },
  methods: {
    getText(index) {
      if (localStorage.getItem('currentLocale') && localStorage.getItem('currentLocale') == 'en') {
        return this.rewardList[index].en
      } else {
        return this.rewardList[index].cn
      }
    },
    approve () {
      store.dispatch('approve', this.depostCADAmount)
    },
    approveFission () {
      store.dispatch('approve', 8)
    },
    depositETH () {
      if (!this.depostETHAmount) {
        this.$alert('请输入具体数量', '提示', {
          confirmButtonText: '确定',
        })
        return
      }
      if (parseFloat(this.depostETHAmount) > parseFloat(this.offerData.remainingETH)) {
        this.$alert('您投入的 ETH 超出最大值', '提示', {
          confirmButtonText: '确定',
        })
        return
      }
      if (parseFloat(this.depostETHAmount) < 0.1) {
        this.$alert('请投入大于 0.1 个 ETH ', '提示', {
          confirmButtonText: '确定',
        })
        return
      }
      store.dispatch('depositETH', this.depostETHAmount)
    },
    depositCAD () {
      if (!this.depostCADAmount) {
        this.$alert('请输入具体数量', '提示', {
          confirmButtonText: '确定',
        })
        return
      }
      if (parseFloat(this.depostCADAmount) > parseFloat(this.offerData.eachAddressLimit) || parseFloat(this.depostCADAmount) > parseFloat(this.offerData.remainingToken)) {
        this.$alert('您投入的 CAD 超出最大值', '提示', {
          confirmButtonText: '确定',
        })
        return
      }
      store.dispatch('depositCAD', this.depostCADAmount)
    }, 
    toBeFissionPerson () {
      store.dispatch('toBeFissionPerson', this.address || '0x3223AEB8404C7525FcAA6C512f91e287AE9FfE7B')
    },
    async initDataContract() {
      const address = ResonanceDataManageJson["networks"][web3.currentProvider.connection.networkVersion].address
      const contract = await new web3.eth.Contract(
        ResonanceDataManageJson.abi,
        address
      )
      return contract
    },
  },
  async created() {
    const contract = await this.initDataContract()
    store.dispatch('queryRewardList', contract)
    store.dispatch('getOpeningTime', contract)
  },
  mounted() {
    const url = document.baseURI
    const params = url.split('?')[1]
    if (params) {
      const address = params.split('=')[1]
      this.address = address
    }
  }
}
</script>
<style lang='scss' scoped>
@import "../assets/variables.scss";

.offer {
  font-size: 0.14rem;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  height: 100%;
  .period {
    width: 80%;
    margin-top: .4rem;
    padding-top: 0.1rem;
    padding-bottom: 0.1rem;
    min-height: 1.4rem;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    .deposit-area {
      display: flex;
      justify-content: space-around;
      .deposit-area-input {
        width: 1.2rem;
      }
    }
  }
  .reward-list {
    .reward-area {
      padding: 0.1rem 0.1rem;
      height: 1.6rem;
      margin-bottom: 0.3rem;
      font-size: .14rem;
      background-color: $dark-main;
      border-radius: 5px;
      .reward-type {
        display: flex;
        justify-content: center;
        div {
          background-repeat: no-repeat;
          background-size: .18rem;
          background-position-y: center;
          width: .18rem;
        }
        div.fission {
          background-image: url('~@/assets/image/fission.png');
        }
        div.fomo {
          background-image: url('~@/assets/image/fomo.png');
        }
        div.lucky {
          background-image: url('~@/assets/image/lucky.png');
        }
        div.faith {
          background-image: url('~@/assets/image/faith.png');
        }
      }
      p {
        font-size: .16rem;
      }
      .reward-detail {
        font-size: 0.12rem;
        margin-top: 0.1rem;
        :nth-child(1) {
          .rank {
            background-image: url('~@/assets/image/1.png');
            background-repeat: no-repeat;
            background-size: .12rem;
            background-position: center 1px;
          }
        }
        :nth-child(2) {
          .rank {
            background-image: url('~@/assets/image/2.png');
            background-repeat: no-repeat;
            background-size: .12rem;
            background-position: center 1px;
          }
        }
        :nth-child(3) {
          .rank {
            background-image: url('~@/assets/image/3.png');
            background-repeat: no-repeat;
            background-size: .12rem;
            background-position: center 1px;
          }
        }
        .reward-detal-item {
          display: flex;
          justify-content: center;
          height: .21rem;
          .rank {
            color: $theme;
            width: .2rem;
            height: .26rem;
            text-align: center;
          }
          .address {
            max-width: 50%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
          }
        }
      }
    }
  }
}
</style>

