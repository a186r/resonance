<template>
  <div class="my">
    <el-row>
      <el-col class="col-flex"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="withdraw dark-card">
          <p>提取 CAD 代币</p>
          <div class="amount-action">
            <p>数量：<span class="value-span">{{myDetail[0]}}</span> CAD</p>
            <button class="custom-button" @click="withdrawAllCAD">提取</button>
          </div>
        </div>
      </el-col>
      <el-col class="col-flex"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="withdraw dark-card">
          <p>提取 ETH 代币</p>
          <div class="amount-action">
            <p>数量：<span class="value-span">{{myDetail[1]}}</span> ETH</p>
            <button class="custom-button" @click="withdrawAllETH">提取</button>
          </div>
        </div>
      </el-col>
    </el-row>
    <el-row>
      <el-col class="col-flex" :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
        <div class="my-detail">
          <div class="invite-link">
            <p>{{inviteText}}：{{link}}</p>
            <button :data-clipboard-text="link" class="copy-button"></button>
          </div>
          <div class="my-detail-list">
            <div class="my-detail-list-left">
              <p v-for="i in 4" :key="i">{{detailList[i-1].text}}：{{myDetail[i-1]}}</p>
            </div>
            <div class="my-detail-list-middle">
            </div>
            <div class="my-detail-list-right">
              <p v-for="i in 4" :key="i">{{detailList[i+3].text}}：{{myDetail[i+3]}}</p>
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
          text: '我的邀请人数',
          value: 23
        },{
          text: '邀请所的金额',
          value: 23
        },{
          text: '组建投资金额',
          value: 23
        },{
          text: '募资投资金额',
          value: 23
        },{
          text: '幸运奖励',
          value: 23
        },{
          text: '裂变奖励',
          value: 23
        },{
          text: 'FOMO 奖励',
          value: 23
        },{
          text: '信仰奖励',
          value: 23
        }
      ]
    }
  },
  computed: {
    ...mapState({
      myDetail: state => state.myDetail,
      link: () => {
        return document.baseURI + '?uid=' + store.state.account
      }
    })
  },
  methods: {
    withdrawAllETH () {
      console.log('withdraw eth')
      store.dispatch('withdrawAllETH')
    },
    withdrawAllCAD () {
      console.log('withdraw cad')
      store.dispatch('withdrawAllCAD')
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
    height: 1rem;
    width: 80%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    margin-bottom: 0.3rem;
    .amount-action {
      display: flex;
      justify-content: space-around;
      align-items: center;
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
        background-color: $dark-main;
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
