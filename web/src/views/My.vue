<template>
  <div class="my">
    <el-row>
      <el-col class="col-flex"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="withdraw dark-card">
          <div class="withdraw-cad"></div>
          <p>{{ $t('my.withdrawCAD') }}</p>
          <p>{{ $t('my.canWithdrawAmount') }}：<span class="value-span">{{myDetail.funderAmount.withdrawCAD}}</span> BDE</p> 
          <div>（{{ $t('my.totalAmount') }}：{{myDetail.funderAmount.allCAD}} BDE）</div>
          <button class="custom-button" @click="withdrawAllCAD">{{ $t('my.withdraw') }}</button>
        </div>
      </el-col>
      <el-col class="col-flex"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="withdraw dark-card" v-if="!isResonanceClosed">
          <div class="withdraw-eth"></div>
          <p>{{ $t('my.withdrawETH') }}</p>
          <p>{{ $t('my.canWithdrawAmount') }}：<span class="value-span">{{myDetail.funderAmount.withdrawETH}}</span> ETH </p>
          <div>（{{ $t('my.totalAmount') }}：{{myDetail.funderAmount.allETH}} ETH）</div> 
          <button class="custom-button" @click="withdrawAllETH">{{ $t('my.withdraw') }}</button>
        </div>
        <div class="withdraw dark-card" v-else>
          <div class="withdraw-eth"></div>
          <p>{{ $t('my.closed') }}</p>
          <el-tooltip class="item" effect="dark" content="全部资产包含信仰奖励和最后一轮募资退款" placement="bottom">
          <button class="custom-button" @click="refund">{{ $t('my.refund') }}</button>
          </el-tooltip>
        </div>
      </el-col>
    </el-row>
    <el-row>
      <el-col class="col-flex" :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
        <div class="my-detail">
          <div class="invite-link">
            <p>{{ $t('my.myInviteLink') }}：{{link}}</p>
            <button :data-clipboard-text="link" class="copy-button"></button>
          </div>
          <div class="my-detail-list">
            <div class="my-detail-list-left">
              <p>{{getText(0)}}：{{myDetail.funderInvite.count}}</p>
              <p>{{getText(1)}}：{{myDetail.funderInvite.reward}} BDE</p>
              <p>{{getText(2)}}：{{myDetail.funderAmount.depositCAD}} BDE</p>
              <p>{{getText(3)}}：{{myDetail.funderAmount.depositETH}} ETH</p>
            </div>
            <div class="my-detail-list-middle">
            </div>
            <div class="my-detail-list-right">
              <p v-for="i in 4" :key="i">{{getText([i+3])}}：{{ myDetail.rewardList && myDetail.rewardList[i-1]}} ETH</p>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import store from '../store'
import { mapState, mapGetters, mapActions } from 'vuex'
import Clipboard from 'clipboard'
export default {
  name: 'my',
  components: {
  },
  data () {
    return {
      inviteText: '我的邀请链接',
      detailList: [
        {
          cn: '我的邀请人数',
          value: 23,
          en: 'Invite the number'
        },{
          cn: '邀请所得金额',
          value: 23,
          en: 'Invitation amount'
        },{
          cn: '组建投资金额',
          value: 23,
          en: 'Investment amount'
        },{
          cn: '募资投资金额',
          value: 23,
          en: 'Raise investment amount'
        },{
          cn: '幸运奖励',
          value: 23,
          en: 'Lucky prize'
        },{
          cn: '裂变奖励',
          value: 23,
          en: 'Fission reward'
        },{
          cn: 'FOMO 奖励',
          value: 23,
          en: 'FOMO reward'
        },{
          cn: '信仰奖励',
          value: 23,
          en: 'Faith reward'
        }
      ]
    }
  },
  computed: {
    ...mapState({
      myDetail: state => state.myDetail,
      isResonanceClosed: state => state.isResonanceClosed,
      link: () => {
        return document.location.origin + '/#/offer' + '?uid=' + store.state.account
      }
    })
  },
  methods: {
    getText(index) {
      if (localStorage.getItem('currentLocale') && localStorage.getItem('currentLocale') == 'en') {
        return this.detailList[index].en
      } else {
        return this.detailList[index].cn
      }
    },
    withdrawAllETH () {
      store.dispatch('withdrawAllETH')
    },
    withdrawAllCAD () {
      store.dispatch('withdrawAllCAD')
    },
    refund () {
      store.dispatch('withdrawFaithRewardAndRefund')
    }
  },
  mounted() {
    const self = this
    const clipboard = new Clipboard('.copy-button')
    clipboard.on('success', function(e) {
      self.$alert(`已经成功复制您的邀请地址: ${self.link}`, '提示', {
        confirmButtonText: '确定',
      })
    })
    clipboard.on('error', function(e) {
      console.log(e)
    })
  }
}
</script>
<style lang='scss' scoped>
@import "../assets/variables.scss";

.my {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  height: 100%;
  font-size: 0.16rem;
  .withdraw {
    height: 1.8rem;
    width: 80%;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
    margin-bottom: 0.3rem;
    .withdraw-cad {
      width: .4rem;
      height: .4rem;
      background-image: url('~@/assets/image/cad.png');
      background-repeat: no-repeat;
      background-size: .4rem;
      background-position-y: center;
    }
    .withdraw-eth {
      width: .4rem;
      height: .4rem;
      background-image: url('~@/assets/image/eth.png');
      background-repeat: no-repeat;
      background-size: .4rem;
      background-position-y: center;
    }
  }
  .my-detail {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 80%;
    background-color: $dark-main;
    border-radius: 5px;
    padding: .2rem 0;
    .invite-link {
      background-color: #161616;
      display: flex;
      border-radius: 5px;
      width: 80%;
      justify-content: space-between;
      p {
        max-width: 80%;
        height: .4rem;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        line-height: .4rem;
      }
      .copy-button {
        background-color: #161616;
        cursor: pointer;
        margin-right: .1rem;
        background-image: url('~@/assets/image/copy.png');
        background-repeat: no-repeat;
        background-size: 80%;
        width: .28rem;
        background-position-y: .1rem;
      }
    }
    .my-detail-list {
      width: 80%;
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: .2rem;
      .my-detail-list-middle {
        width: 1px;
        background-color: $theme;
        height: .8rem;
      }
      .my-detail-list-left, .my-detail-list-right {
        text-align: left;
      }
    }
  }
}
</style>
