<template>
  <div id="message">
    <div class="title-text">短信：</div>
    <div class="message_main_panel">
      <div class="left" :style="`width: calc(30% + (${left}px));`">
        <contact-nav :contact-list="contactList" :type="'message'" @pageChange="getContactPage" @selectContact="selectContact"></contact-nav>
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
      <div class="right" :style="`width: calc(70% - 10px - (${left}px));`">
        <Chat :message-list="currentMessageList"></Chat>
      </div>
    </div>
  </div>
</template>

<script>
import {loadScript, formatDate} from '../../util/util'
import {Loading} from 'element-ui'
import ContactNav from './comp/ContactNav'
import Chat from './comp/Chat'

export default {
  name: 'Message',
  components: {
    Chat,
    ContactNav
  },
  data () {
    return {
      contactList: [],
      currentMessageList: [],
      left: 0
    }
  },
  methods: {
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
    getContactPage (activeObj) {
      this.setCurrentMessageList(activeObj)
    },
    selectContact (contact) {
      this.setCurrentMessageList(contact)
    },
    setCurrentMessageList (contact) {
      this.currentMessageList = contact.messageRecords.map(msg => {
        return {
          content: msg.body,
          chatTime: formatDate(msg.dateTime, 'Y-M-D h:m:s'),
          senderNickname: msg.received ? ((msg.person && msg.person !== '') ? `${msg.person}(${msg.targetNum})` : msg.targetNum) : ' ',
          received: msg.received,
          isDeleted: msg.isDelMsg
        }
      })
    }
  },
  mounted () {
    let loading = Loading.service({target: document.getElementById('message'), text: '数据正在加载中...'})
    loadScript('./static/data/phone_info/message.js', () => {
      // 适配公共组件属性
      this.contactList = window.globalJSData['message'].map(it => {
        return {
          ...it,
          calledTimes: it.messagedTime,
          lastChatTime: it.lastMessagedTime
        }
      })
      loading.close()
    })
  }
}
</script>

<style scoped lang="scss">
* {
  &::-webkit-scrollbar {
    display: none
  }
}
#message {
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
  width: calc(100% - 80px);
  height: calc(100% - 20px);
  overflow: auto;
  padding: 10px 40px;
  .message_main_panel {
    width: 100%;
    height: 90%;
    border: 1px solid #c7c7c7;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: row;
    .right {
      //width: calc(70% - 5px);
      height: 100%;
      margin-left: 5px;
    }
    .left {
      //width: 30%;
      height: 100%;
      overflow: auto;
      border-right: 1px solid #c7c7c7;
    }
  }
}
</style>
