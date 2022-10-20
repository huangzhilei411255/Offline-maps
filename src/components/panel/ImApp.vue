<template>
  <div :id="appCode + '_im_app'" class="im_app">
    <div class="title-text">{{ appName }}：</div>
    <div class="im_app_main_panel">
      <div class="left" :style="`width: calc(30% + (${left}px));`">
        <ImNav @changePitch="changePitchs" :appCode="appCode" :main-accounts="mainAccounts" @contactSelectChange="contactSelectChange" @mainAccountChange="mainAccountSelectChange"></ImNav>
      </div>
      <div
        @mouseup="dragBar({e: $event, type: 'up'})"
        @mousedown.stop="dragBar({e: $event, type: 'down'})"
        @mousemove="dragBar({e: $event, type: 'move'})"
        class="drag_bar">
        <div>.</div>
        <div>.</div>
        <div>.</div>
      </div>
      <div id="im_app_main_panel_right" class="right" :style="`width: calc(70% - 10px - (${left}px));`">
        <div class="chat-title" v-if="type == 'im-contact'">
          <el-row>
            <el-col class="copyname" :span="8">昵称:
                <span class="setname" style="user-select: none;">{{activeItem.friendNickname}}</span>
            </el-col>
            <el-col class="copyname" :span="8">账号: 
                 <span  class="setname" style="user-select: none;">{{activeItem.friendAccount ? activeItem.friendAccount : activeItem.friendRelid}}</span>
            </el-col>
            <el-col class="copyname" :span="8">备注: 
                <span class="setname" style="user-select: none;"> {{activeItem.friendRemark}}</span>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="8">所在地: {{activeItem.address}}</el-col>
            <el-col :span="8">分组: {{activeItem.groupName}}</el-col>
            <el-col :span="8">签名: <span>{{activeItem.signature}}</span></el-col>
          </el-row>
        </div>
        <div class="chat-title" v-if="type == 'im-group'">
          <el-row>
            <el-col class="copyname" :span="12">群名称:
                <span class="setname" style="user-select: none;">{{activeItem.name}}</span>
            </el-col>
            <el-col class="copyname" :span="12">群账号: 
                 <span  class="setname" style="user-select: none;">{{activeItem.groupAccount}}</span>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">群主名: {{activeItem.groupOwnerNickname}}</el-col>
          </el-row>
        </div>
        <Chat :message-list="currentMessageList" :chat-type="'im_message'" :app-name="appName" :app-code="appCode"></Chat>
      </div>
    </div>
  </div>
</template>

<script>
import ImNav from './comp/ImNav'
import Chat from './comp/Chat'
import {loadScriptAsync, formatDate} from '../../util/util'
import {Loading} from 'element-ui'
export default {
  name: 'ImApp',
  components: {Chat, ImNav},
  props: {
    appCode: String,
    appName: String
  },
  data () {
    return {
      mainAccounts: [],
      currentChatMainAccount: '',
      currentSelectedTheirAccount: '',
      currentMessageList: [],
      left: 0,
      activeItem: {},
      type: 'im-contact', // 默认是好友
    }
  },
  methods: {
    changePitchs({item, type}) {
      this.type = type
      console.log(item);
      if (item) {
        this.activeItem = item
      } else {
        this.activeItem = {}
      }
    },
    dragBar (option) {
      let _this = this
      if (option.type === 'down') {
        this.dragState = 'down'

        document.onmousemove = function (e) {
          _this.left += e.movementX
        }
      }
      if (option.type === 'up') {
        this.dragState = 'up'
        document.onmousemove = undefined
      }
    },
    contactSelectChange ({contact, indexPath}) {
      if (!contact) {
        this.currentMessageList = []
        return
      }
      this.currentSelectedTheirAccount = contact
      if (indexPath && indexPath.includes('im-group')) {
        this.loadGroupChatMessage()
      } else {
        this.loadContactChatMessage()
      }
    },
    async mainAccountSelectChange (mainAccount) {
      this.currentChatMainAccount = mainAccount
      // await this.loadContactChatMessage()
    },
    loadAppMainAccounts () {
      this.mainAccounts = window.globalJSData['im_main_accounts'][this.appCode]
    },
    async loadContactChatMessage () {
      let loading = Loading.service({target: document.getElementById('im_app_main_panel_right'), text: '数据正在加载中...'})
      // 加载对应的聊天记录
      // await loadScriptAsync(`./static/data/contact_message/${this.appCode}/${this.currentChatMainAccount}/orphanapp.js`)
      let key = `${this.appCode} _ ${this.currentChatMainAccount} _ ${this.currentSelectedTheirAccount}`
      if (!window.globalJSData['contact_message'][key]) {
        await loadScriptAsync(`./static/data/contact_message/${this.appCode}/${this.$md5(this.currentChatMainAccount)}/${this.$md5(this.currentSelectedTheirAccount)}.js`)
      }
      // 获取对应key
      // let key = `${this.appCode} _ ${this.currentChatMainAccount} _ orphanapp`
      this.currentMessageList = window.globalJSData['contact_message'][key].map(x => {
        if (x.friendRemark) {
          return {
            ...x,
            senderNickname: x.isSend === 0
              ? ((x.friendAccount && x.friendAccount !== '') ? `${x.friendRemark}（${x.friendAccount}）` : `${x.friendRemark}（${x.friendRelid}）`)
              : ((x.ownerAccount && x.ownerAccount !== '') ? `${x.ownerNickname}（${x.ownerAccount}）` : `${x.ownerNickname}（${x.ownerRelid}）`),
            chatTime: formatDate(x.sendTime, 'Y-M-D h:m:s'),
            received: x.isSend === 0,
            isDeleted: x.isDeleted == 1
          }
        } else {
          return {
            ...x,
            senderNickname: x.isSend === 0
              ? ((x.friendNickname && x.friendNickname !== '') ? `${x.friendNickname}（${x.friendRelid}）` : `${x.friendRelid}`)
              : ((x.ownerNickname && x.ownerNickname !== '') ? `${x.ownerNickname}（${x.ownerRelid}）` : `${x.ownerRelid}`),
            chatTime: formatDate(x.sendTime, 'Y-M-D h:m:s'),
            received: x.isSend === 0,
            isDeleted: x.isDeleted == 1
          }
        }
        
      })
      window.globalJSData['contact_message'][key] = null
      loading.close()
      console.log(this.currentMessageList);
    },
    async loadGroupChatMessage () {
      let loading = Loading.service({target: document.getElementById('im_app_main_panel_right'), text: '数据正在加载中...'})
      // 加载对应的聊天记录
      // await loadScriptAsync(`./static/data/contact_message/${this.appCode}/${this.currentChatMainAccount}/orphanapp.js`)
      // 获取对应key
      let key = `${this.appCode} _ ${this.currentChatMainAccount} _ ${this.currentSelectedTheirAccount}`
      if (!window.globalJSData['group_message'][key]) {
        await loadScriptAsync(`./static/data/group_message/${this.appCode}/${this.$md5(this.currentChatMainAccount)}/${this.$md5(this.currentSelectedTheirAccount)}.js`)
      }
      // let key = `${this.appCode} _ ${this.currentChatMainAccount} _ orphanapp`
      this.currentMessageList = window.globalJSData['group_message'][key].map(x => {
        return {
          ...x,
          senderNickname: ((x.friendNickname && x.friendNickname !== '') ? `${x.friendNickname}（${x.friendAccount}）` : `${x.friendAccount}`),
          chatTime: formatDate(x.sendTime, 'Y-M-D h:m:s'),
          received: x.isSend === 0,
          isDeleted: x.isDeleted == 1,
          type: x.type + ''
        }
      })
      window.globalJSData['group_message'][key] = null
      loading.close()
    }
  },
  async mounted () {
    if (!window.globalJSData['im_main_accounts']) {
      // 加载对应js文件（主账号）
      await loadScriptAsync('./static/data/im_main_accounts.js')
      this.loadAppMainAccounts()
    }
  },
  watch: {
    appCode: {
      handler (val) {
        this.loadAppMainAccounts()
      }
    }
  }
}
</script>

<style scoped lang="scss">
* {
  &::-webkit-scrollbar {
    display: none
  }
}
.im_app {
  .drag_bar {
    width: 10px;
    height: 100%;
    cursor: col-resize;
    background: #f1f1f1;
    display: flex;
    justify-content: center;
    align-items: center;
    align-content: center;
    flex-direction: column;
    transition: ease all .2s;
    color: #9c9c9c;
    font-size: 20px;
  }
  .drag_bar:hover {
    background: #bdbdbd;
    color: white;
    box-shadow: 0 0 3px 2px #afafaf;
    z-index: 2000;
    font-weight: bolder;
  }
  .overflow {
    text-overflow: ellipsis; overflow: hidden; white-space: nowrap;
  }
  width: calc(100% - 80px);
  height: calc(100% - 20px);
  padding: 10px 40px;
  .im_app_main_panel {
    width: 100%;
    height: 90%;
    border: 1px solid #c7c7c7;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: row;
    .right {
      //width: calc(70% - 10px);
      height: 100%;
      // margin-left: 5px;
      // display: flex;
      flex-direction: row;
      .chat-title {
        box-sizing: border-box;
        width: 100%;
        height: 60px;
        margin: 2px;
        line-height: 22px;
        padding: 7px 20px;
        background-color: #F5F7FA;
        border-radius: 10px;
        &>div>div {
          overflow: hidden;
          white-space: nowrap;
          text-overflow: ellipsis;
        }
      }
    }
    .left {
      //width: 30%;
      height: 100%;
      overflow: auto;
      //border-right: 1px solid #ffffff;
    }
  }
}
</style>
