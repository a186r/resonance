<template>
  <div class="my">
    <el-row>
      <el-col class="col-flex"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="withdraw dark-card">
          <p>提取 CAD 代币</p>
          <div class="amount-action">
            <p>数量：{{myDetail[0]}} CAD</p>
            <button class="custom-button" @click="withdrawAllCAD">提取</button>
          </div>
        </div>
      </el-col>
      <el-col class="col-flex"  :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="withdraw dark-card">
          <p>提取 ETH 代币</p>
          <div class="amount-action">
            <p>数量：{{myDetail[1]}} ETH</p>
            <button class="custom-button" @click="withdrawAllETH">提取</button>
          </div>
        </div>
      </el-col>
    </el-row>
    <el-row>
      <el-col class="col-flex"  :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
        <div class="my-detail dark-card">
          <p v-for="(item,i) in detailList" :key="i">{{item.text}}：{{getMyDetailValue(i)}}</p>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import store from '../store'
import { mapState, mapGetters, mapActions } from 'vuex'

export default {
  name: 'my',
  components: {
  },
  data () {
    return {
      detailList: [
        {
          text: '我的邀请链接',
          value: 'http://asdfasdfsadf.com/?uid=123456'
        },{
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
    },
    getMyDetailValue(i) {
      if (i === 0) {
        return document.baseURI + '?uid=' + store.state.account
      }
      return this.myDetail[i]
    }
  },
  mounted() {
  }
}
</script>
<style lang='scss'>
.my {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  height: 100%;
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
    width: 50%;
    text-align: left;
    margin-top: .5rem;
    padding: .2rem .5rem;
  }
}
</style>
