<template>
  <div class="home">
    <!-- <el-row type="flex" justify="space-around"> -->
    <el-row :gutter=20>
      <!-- <el-col :xs="24" :sm="24" :md="12" :lg="12" :xl="12"> -->
      <el-col class="padding-span" :xs="2" :sm="2" :md="1" :lg="1" :xl="1"></el-col>
      <el-col :xs="20" :sm="20" :md="10" :lg="10" :xl="10">
        <div class="title dark-card">
          <p>组建期</p>
          <p>CAD: 10000000 CAD</p>
          <router-link to="/offer">（点击进入组建期页面）</router-link>
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
      <el-col class="padding-span" :xs="2" :sm="2" :md="1" :lg="1" :xl="1"></el-col>
      <el-col class="padding-span" :xs="2" :sm="2" :md="1" :lg="1" :xl="1"></el-col>
      <!-- <div class="divide hidden-sm-and-down"></div> -->
      <el-col :xs="20" :sm="20" :md="10" :lg="10" :xl="10">
      <!-- <el-col :xs="24" :sm="24" :md="12" :lg="12" :xl="12"> -->
        <div class="title dark-card">
          <p>募资期</p>
          <p>ETH: 100.1234 ETH</p>
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
      <el-col class="padding-span" :xs="2" :sm="2" :md="1" :lg="1" :xl="1"></el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: 'home',
  components: {
  }
}
</script>
<style lang='scss'>
@import "../assets/base.scss";
.home {
  // display: flex;
  height: 100%;
  width: 100%;
  align-items: center;
  justify-content: space-around;
  .padding-span {
    min-height: 4.5rem;
  }
  .divide {
    width: 0.02rem;
    height: 90%;
    background-color: #fff;
  }
  .title {
    margin-top: 0.3rem;
    height: 1rem;
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
