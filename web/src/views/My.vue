<template>
  <div class="my">
    <el-row type="flex" justify="space-around">
      <!-- <el-col :xs="24" :sm="24" :md="12" :lg="12" :xl="12"> -->
      <!-- <el-col class="padding-span" :xs="2" :sm="2" :md="1" :lg="1" :xl="1"></el-col> -->
      <el-col :xs="20" :sm="20" :md="10" :lg="10" :xl="10">
        <div class="withdraw dark-card">
          <p>提取 CAD 代币</p>
          <div class="amount-action">
            <p>数量：{{cadAmount}} CAD</p>
            <el-button size="medium" @click="withdrawCAD">提取</el-button>
          </div>
        </div>
      </el-col>
      <el-col :xs="20" :sm="20" :md="10" :lg="10" :xl="10">
        <div class="withdraw dark-card">
          <p>提取 ETH 代币</p>
          <div class="amount-action">
            <p>数量：{{ethAmount}} ETH</p>
            <el-button size="medium" @click="withdrawETH">提取</el-button>
          </div>
        </div>
      </el-col>
    </el-row>
    <el-row type="flex" justify="space-around">
      <el-col :xs="20" :sm="20" :md="12" :lg="12" :xl="12">
        <div class="my-detail dark-card">
          <p v-for="(item,i) in detailList" :key="i">{{item.text}}：{{item.value}}</p>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: 'home',
  components: {
  },
  data () {
    return {
      cadAmount: 3000,
      ethAmount: 23,
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
  methods: {
    withdrawETH () {
      console.log('withdraw eth')
    },
    withdrawCAD () {
      console.log('withdraw cad')
    }
  }
}
</script>
<style lang='scss'>
@import "../assets/base.scss";
.my {
  display: flex;
  flex-direction: column;
  justify-content: center;
  height: 100%;
  .withdraw {
    height: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    .amount-action {
      display: flex;
      justify-content: space-around;
      align-items: center;
    }
  }
  .my-detail {
    text-align: left;
    margin-top: .5rem;
    padding: .2rem .5rem;
  }
}
</style>
