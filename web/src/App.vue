<template>
  <div id="app">
    <el-container>
      <el-header>
        <div id="nav">
          <div class="left">
            <div class="logo">
              <img src="./assets/image/logo.png">
            </div>
          </div>
          <div class="right">
            <router-link to="/">{{ $t('nav.index') }}</router-link>
            <router-link to="/offer">{{ $t('nav.offer') }}</router-link>
            <router-link to="/my">{{ $t('nav.my') }}</router-link>
            <a class="link-metamask" @click="unlockMetaMask">{{account}}</a>
            <el-dropdown @command="handleCommand">
              <span class="el-dropdown-link">
                {{currentLanguage}}<i class="el-icon-arrow-down el-icon--right"></i>
              </span>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item command="cn">中文简体</el-dropdown-item>
                <el-dropdown-item command="en">English</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>
        </div>    
      </el-header>
      <el-main>
        <router-view></router-view>
        <!-- <HelloI18n /> -->
      </el-main>
      <el-footer>Copyright © 2018-2019 bdex | All rights reserved</el-footer>
    </el-container>
  </div>
</template>

<script>
import Web3 from "web3"
import store from './store'
import ResonanceJson from '../../contract/build/contracts/Resonance.json'
import TokenJson from '../../contract/build/contracts/ABCToken.json'

export default {
  name: 'app',
  data () {
    return {
      account: ethereum.selectedAddress || '登录 metamask',
      currentLanguage: localStorage.getItem('currentLocale') && localStorage.getItem('currentLocale') == 'en' ? 'English' : '中文简体'
    }
  },
  computed: {
  },
  components: {
  },
  methods: {
    handleCommand(command) {
      this._i18n.locale = command
      if (command === 'cn') {
        this.currentLanguage = '中文简体'
      } else if (command === 'en') {
        this.currentLanguage = 'English'
      }
      localStorage.setItem('currentLocale', command)
    },
    async initTokenContract() {
      const address = TokenJson["networks"][web3.currentProvider.connection.networkVersion].address
      console.log('token contract address:', address)
      const contract = await new web3.eth.Contract(
        TokenJson.abi,
        address
      )
      return contract
    },
    async initContract() {
      const address = ResonanceJson["networks"][web3.currentProvider.connection.networkVersion].address
      console.log('contract address:', address)
      const contract = await new web3.eth.Contract(
        ResonanceJson.abi,
        address
      )
      return contract
    },
    async unlockMetaMask() {
      const self = this

      if (window.ethereum) {
        window.web3 = new Web3(ethereum)
        try {
          await ethereum.enable();
          self.account = ethereum.selectedAddress
        } catch (error) {
          self.$alert('您拒绝了授权使用 MetaMask', '提示', {
            confirmButtonText: '确定',
          })
        }
      }
      // Legacy dapp browsers...
      else if (window.web3) {
        window.web3 = new Web3(web3.currentProvider)
        const account = web3.eth.accounts[0]
        if (!account){
          self.$alert('您的 MetaMask 被锁住了，请先解锁', '提示', {
            confirmButtonText: '确定',
          })
          return
        }
        self.account = account
      }
      else {
        self.$alert('您的浏览器还没有安装 MetaMask，请先安装该插件', '提示', {
          confirmButtonText: '确定',
        })
        return
      }
      store.state.account = self.account
    }
  },
  async created () {
    await this.unlockMetaMask()
    const contract = await this.initContract()
    const tokenContract = await this.initTokenContract()
    window.contract = contract
    window.tokenContract = tokenContract
    // const amount = await tokenContract.methods.allowance(this.account, contract.address).call()
    // console.log('allowance: ', amount)
    store.dispatch('getCurrentStepFundsInfo', contract)
    store.dispatch('getBuildingPeriodInfo', contract)
    store.dispatch('getFundingPeriodInfo', contract)
    store.dispatch('getFunderInfo', contract)
    store.dispatch('isBuilder', contract)
    const data = {contract: contract, eventName: 'ToBeFissionPerson'}
    store.dispatch('startListenEvent', data)
    data.eventName = 'FundsInfo'
    store.dispatch('startListenEvent', data)
  }
}
</script>

<style lang='scss'>
@import "./assets/base.scss";
body {
  margin: 0;
  height: 100vh;
}

html {
  font-size: 10.416666vw;
}
 
.el-dropdown-link {
  font-size: 0.14rem;
}

.el-dropdown {
  display: flex;
}

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  height: 100vh;
  font-size: 0.16rem;
}

.el-header, .el-footer {
  background-color: $main;
  color: #fff;
  text-align: center;
  height: .4rem !important;
}

.el-main {
  height: 100%;
  background-color: $bg;
  color: #fff;
}

.el-container {
  height: 100%;
}

#nav {
  display: flex;
  justify-content: space-between;
  font-size: 0.14rem;
  height: 100%;
  .locale-changer {
    color: #fff;
    background-color: $dark-main;
  }
  .left {
    display: flex;
    justify-content: space-around;
    color: #fff;
    width: 10%;
    .logo {
      display: flex;
      align-items: center;
      img {
        margin-left: .6rem;
        height: .2rem;
      }
    }
  }
  .right {
    display: flex;
    justify-content: space-around;
    align-items: center;
    width: 50%;
    .link-metamask {
      cursor: pointer;
      overflow: hidden;
      max-width: 1.5rem;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
  }
}
.el-footer {
  color: #fff;
  line-height: 60px;
}
</style>
