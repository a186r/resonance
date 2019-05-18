<template>
  <div class="offer">
    <el-row :gutter="40">
      <el-col class="col-flex" :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="period dark-card">
          <p>组建期</p>
          <p>结束时间倒计时: 10.59:59</p>
          <p>可投入剩余CAD数量：{{cadRemain}}</p>
          <p>当前最大投入：5000000</p>
          <div class="deposit-area">
            <div class="deposit-area-input">
              <el-input v-model="depostCADAmount" placeholder="CAD投入数量"></el-input>
            </div>
            <el-button size="small" @click="depositCAD">投入CAD</el-button>
          </div>
        </div>
      </el-col>
      <el-col class="col-flex" :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <div class="period dark-card">
          <p>募资期</p>
          <p>结束时间倒计时: 10.59:59</p>
          <p>可投入剩余总额：{{ethRemain}}</p>
          <div class="deposit-area">
            <div class="deposit-area-input">
              <el-input v-model="depostCADAmount" placeholder="ETH投入数量"></el-input>
            </div>
            <el-button size="small" @click="depositETH">投入ETH</el-button>
          </div>
        </div>
      </el-col>
    </el-row>
    <el-row :gutter="10">
      <el-col :xs="12" :sm="12" :md="6" :lg="6" :xl="6" v-for="(item, i) in rewardList" :key="i">
        <div class="reward-area dark-card">
          <p>{{item.text}}</p>
          <div class="reward-detail">
            <div class="reward-detal-item" v-for="i in 5" :key="i">
              <span class="address">0x7525c82e0cf1832e79ff3aff259c5fe853cf95f4</span>
              <span>：</span>
              <span>1.3 ETH</span>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>
<script>

export default {
  name: 'offer',
  data () {
    return {
      currentRound: 3,
      cadRemain: 3000,
      ethRemain: 23,
      depostCADAmount: '',
      depostETHAmount: '',
      rewardList: [{
          text: '裂变奖励',
          value: 23
        },{
          text: 'FOMO 奖励',
          value: 23
        },
        {
          text: '幸运奖励',
          value: 23
        },{
          text: '信仰奖励',
          value: 23
        }
      ]
    }
  },
  methods: {
    depositETH () {
      console.log('deposit eth')
    },
    depositCAD () {
      console.log('deposit cad')
    }
  }
}
</script>
<style lang='scss'>
@import "../assets/base.scss";
.offer {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  height: 100%;
  .period {
    width: 80%;
    margin-bottom: 0.3rem;
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
  .reward-area {
    padding: 0.1rem 0.1rem;
    margin-bottom: 0.3rem;
    .reward-detail {
      font-size: 0.12rem;
      margin-top: 0.2rem;
      .reward-detal-item {
        display: flex;
        justify-content: center;
        .address {
          width: 70%;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
        }
      }
    }
  }
}
</style>

