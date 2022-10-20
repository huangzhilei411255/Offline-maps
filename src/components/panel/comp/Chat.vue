<template>
  <div id="chat_panel" :style="`height: calc(100% - (${chatType != 'message' ? 70 : 0}px));`">
    <div id="chat-wrap" style="width: 100%; height: calc(100% - 50px); overflow: auto;">
      <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;" v-show="currentShownMessageList.length <= 0">
        <el-empty description="暂无数据"></el-empty>
      </div>
      <div v-show="currentShownMessageList.length > 0">
        <div v-for="msg in currentShownMessageList"
             :class="msg.received ? 'chat-message-msg-item-receive' : 'chat-message-msg-item-send'">
          <div v-if="chatType === 'im_message' && msg.type === '10'" class="system-notice">
            <span style="background-color: #d4d4d4; padding: 2px 10px; border-radius: 3px;">{{ msg.content }}</span>
          </div>
          <div v-else class="msg">
            <div class="msg-avator">
              <div style="width: 38px; height: 38px; background: #eeeeee; border-radius: 5px; display: flex; justify-content: center; align-items: center; overflow: hidden;">
                <i v-if="!msg.avator" class="el-icon-user-solid" style="font-size: 20px;"></i>
                <img v-else style="width: 100%; height: 100%;" :src="msg.avator" />
              </div>
            </div>
            <div class="msg-detail">
              <div class="msg-detail-contact">
                &nbsp;{{ msg.senderNickname }}
              </div>
              <div style="width: 100%; position: relative;">
                <!-- 红包-->
                <div v-if="msg.type === '4'" class="msg-detail-content-red-pack">
                  <div style="margin-bottom: 20px; font-size: 37px;"><Icon class="red-package-icon" icon="redpackage"></Icon></div>
                  <div style="font-weight: bold;">{{  handlePayment(msg.content).money }}</div>
                  <span class="arrow"></span>
                </div>
                <div v-else-if="msg.type === '8' || msg.type === '9'" class="msg-detail-content-trans">
                  <div style="width: 100%; height: 80px; display: flex; align-items: center;">
                    <Icon style="font-size: 30px; width: 40px; height: 40px; margin-left: 20px;" icon="payment"></Icon>
                    <span v-if="handlePayment(msg.content).moneyType == '1'" class="payment-text overflow" :title="handlePayment(msg.content).money">向您转账{{handlePayment(msg.content).money}}</span>
                    <span v-else-if="handlePayment(msg.content).moneyType == '3'" class="payment-text overflow" :title="handlePayment(msg.content).money">已收款{{handlePayment(msg.content).money}}</span>
                    <span v-else-if="handlePayment(msg.content).moneyType == '7'" class="payment-text overflow" :title="handlePayment(msg.content).money + handlePayment(msg.content).moneys">{{handlePayment(msg.content).money}} {{handlePayment(msg.content).moneys}}</span>
                    <span v-else class="payment-text overflow" :title="handlePayment(msg.content).money">{{handlePayment(msg.content).money}}</span>
                  </div>
                  <div style="width: 100%; height: 30px; background-color: #eaeaea; border-radius: 0 0 5px 5px; color: #6c6c6c; font-size: 15px; display: flex; justify-content: space-between; align-items: center; font-weight: bold;">
                    <span style="margin-left: 10px;">{{ appName + (msg.type === '8' ? '转账' : '收款')}}</span><Icon class="payment-checked" style="margin-right: 10px;" icon="check"></Icon>
                  </div>
                  <span class="arrow"></span>
                </div>
                <div v-else class="msg-detail-content">
                  <!-- start if-->
                  <!-- 视频-->
                  <div v-if="msg.type === '1'">
                    <video style="width: 300px; height: 200px;" :src="msg.fileConvertedPath ? `static/cloud_plus_converter/${ msg.fileConvertedPath }` : `static/attach${ msg.filePath }`" controls="controls"></video>
                  </div>
                  <!-- 图片-->
                  <div v-else-if="msg.type === '2'">
                    <div style="width: 200px; height: 300px; overflow: hidden; position: relative;">
                      <CommonImage :width="'100%'" :height="'100%'" :src="msg.fileConvertedPath ? `static/cloud_plus_converter/${ msg.fileConvertedPath }` : `static/attach${ msg.filePath }`"></CommonImage>
                      <!--                    <img :src="`static/attach/${msg.filePath}`" class="pic_image" />-->
                    </div>
                  </div>
                  <!-- 语音-->
                  <div v-else-if="msg.type === '3'">
                    <audio style="width: 300px; height: 57px;" :src="msg.fileConvertedPath ? `static/cloud_plus_converter/${ msg.fileConvertedPath }` : `static/attach${ msg.filePath }`" controls="controls"></audio>
                  </div>
                  <!-- 文件-->
                  <div v-else-if="msg.type === '5'">
                    <div class="file">
                      <i class="el-icon-document" style="font-size: 25px; margin-right: 15px;"></i>
                      <span style="font-size: 15px;" :title="`static/attach${msg.filePath}`" class="overflow">{{ msg.filePath ? msg.filePath.split('/')[msg.filePath.split('/').length - 1] : '' }}</span>
                      <br>
                      <div style="width: 100%; height: 20px; display: flex; justify-content: flex-end; font-size: 13px; align-items: center;">
                        <a :href="`static/attach${msg.filePath}`" style="margin-right: 10px;">下载</a>
                      </div>
                    </div>
                  </div>
                  <!-- 位置信息 -->
                  <div v-else-if="msg.type === '6'">
                    <div class="position">
                      <div style="width: 100%; height: 180px; margin-bottom: 5px;">
                        <img src="static/img/chat-position.jpg" style="width: 100%; height: 100%;" />
                      </div>
                      <div style="width: 100%; height: 70px; display: flex; justify-content: flex-start; align-items: center; flex-wrap: wrap; font-size: 10px;">
                        <div style="width: 100%;">经度：{{ handlePosition(msg.content).longitude }}</div>
                        <div style="width: 100%;">纬度：{{ handlePosition(msg.content).latitude }}</div>
                        <div style="width: 100%;">具体位置：{{ handlePosition(msg.content).locationName }}</div>
                      </div>
                    </div>
                  </div>
                  <!-- 名片 -->
                  <div v-else-if="msg.type === '7'">
                    <div class="id-card">
                      <div class="id-card-top">
                        <div style="width: 70px; height: 70px; display: flex; justify-content: center; align-items: center;">
                          <img src="static/img/contact-card.png" />
                        </div>
                        <div style="width: calc(100% - 70px); height: 100%; display: flex; flex-wrap: wrap; align-items: center; align-content: center;">
                          <div style="width: 100%; height: 20px; font-size: 13px;" class="overflow">{{handleContactcard(msg.content).name}}</div>
                          <div style="width: 100%; height: 20px; font-size: 13px;" class="overflow">{{handleContactcard(msg.content).account}}</div>
                          <div style="width: 100%; height: 20px; font-size: 13px;" class="overflow">{{handleContactcard(msg.content).area}}</div>
                        </div>
                      </div>
                      <div style="width: 100%; height: 25px; font-size: 15px; display: flex; justify-content: flex-start; align-items: center; color: #797979;">
                        个人名片
                      </div>
                    </div>
                  </div>
                  <!-- 动画表情 -->
                  <div v-else-if="msg.type === '11'">
                    <div style="width: 150px; height: 150px; display: flex; justify-content: center; align-items: center; flex-direction: column; background-color: white; color: #afafaf;">
                      <Icon style="width: 70px; height: 70px;" icon="emoji"></Icon>
                      <div style="font-size: 15px; margin-top: 10px;">表情动画</div>
                    </div>
                  </div>
                  <!-- 分享链接 -->
                  <div v-else-if="msg.type === '16'">
                    <div class="share-link"
                         :style="handleSharelink(msg.content).clickable ? `cursor: pointer` : ''"
                         @click="() => {handleSharelink(msg.content).clickable ? gotoLink(handleSharelink(msg.content).url) : ''}"
                    >
                      <div style="width: 100%; height: 30px; font-size: 16px;">
                        {{ handleSharelink(msg.content).content ? '未知链接' : handleSharelink(msg.content).title }}
                      </div>
                      <div style="width: 100%; height: 50px; display: flex; justify-content: center; align-items: center">
                        <div class="share-link-content">
                          {{ handleSharelink(msg.content).content ? handleSharelink(msg.content).content : handleSharelink(msg.content).des }}
                        </div>
                        <div style="width: 50px; height: 100%; display: flex; justify-content: center; align-items: center;">
                          <img src="static/img/sharelink.png">
                        </div>
                      </div>
                    </div>
                  </div>
                  <div v-else>
                    <span>&nbsp;{{  !msg.content ? ' ' : msg.content }}&nbsp;</span>
                  </div>
                  <!--                end if-->
                  <span class="arrow"></span>
                  <span v-if="msg.isDeleted" :style="`position: absolute; bottom: 0; ${msg.isSend ? 'left: -25px;' : 'right: -25px;'} color: red;`"><i class="el-icon-delete"></i></span>
                </div>
                <br style="clear: both;" />
              </div>
              <div class="msg-detail-time">
                &nbsp;{{ msg.chatTime }}
              </div>
            </div>
          </div>
          <br style="clear: both;" />
        </div>
      </div>
    </div>
    <div style="width: 100%; height: 50px; display: flex; justify-content: center; align-items: center;">
      <el-pagination :total="messageList.length"
                     @current-change="changePage"
                     :current-page="currentPage"
                     :page-size="pageSize">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import {getTagContent} from '../../../util/util'
import Icon from './Icon'
import CommonImage from './CommonImage'
export default {
  name: 'Chat',
  components: {CommonImage, Icon},
  data () {
    return {
      currentShownMessageList: [],
      pageSize: 50,
      currentPage: 1
    }
  },
  props: {
    appCode: String,
    appName: String,
    messageList: Array,
    chatType: {
      type: String,
      default: 'message' // message（短信） im_message（即时通讯）
    }
  },
  methods: {
    gotoLink (url) {
      window.open(url)
    },
    getPage (page) {
      page = page - 1
      this.currentShownMessageList = this.messageList.filter((x, index) => {
        return index >= page * this.pageSize && index < (page + 1) * this.pageSize
      })
    },
    changePage (page) {
      this.currentPage = page
      this.getPage(page)
      document.getElementById('chat-wrap').scrollTop = 0
    },
    handlePayment (content) {
      // 判断xml
      //  feedesc
      if (content.startsWith('<?xml') || content.startsWith('<msg')) {
        return {
          money: getTagContent(content, 'des').replace(/\<\!\[CDATA\[/g, '').replace(/]]/g, '').replace(/\>/g, ''),
          moneys: getTagContent(content, 'feedesc').replace(/\<\!\[CDATA\[/g, '').replace(/]]/g, '').replace(/\>/g, ''),
          moneyType: getTagContent(content, 'paysubtype')
        }
      } else if (content.includes('{')){
        // 判断json
        try {
          return {
            money: JSON.parse(content).des
          }
        } catch (e) {
          return {
            money: content
          }
        }
        // return {
        //     money: JSON.parse(content).des
        // }
      } else {
        return {
          money: content
        }
      }
    },
    handlePosition (content) {
      // 判断json
      try {
        let contact = JSON.parse(content)
        return {
          isJSON: true,
          longitude: contact.longitude,
          latitude: contact.latitude,
          locationName: contact.locationName
        }
      } catch (e) {
        return {
          isJSON: false,
          content
        }
      }
    },
    // 处理名片
    handleContactcard (content) {
      if (!content) {
        return {
          isJSON: false,
          content
        }
      }
      // 判断json
      try {
        let contact = JSON.parse(content)
        return {
          isJSON: true,
          name: contact.name,
          account: contact.uid,
          area: contact.area
        }
      } catch (e) {
        if (content.indexOf('|') != -1) {
          let parts = content.split('|')
          let name = parts[1]
          let account = parts[0]
          return {
            isJSON: true,
            name,
            account
          }
        }
        return {
          isJSON: false,
          content
        }
      }
    },
    // 处理分享链接
    handleSharelink (content) {
      // 判断xml
      if (content.startsWith('\\<\\?xml') || content.startsWith('\\<msg')) {
        return {
          title: getTagContent(content, 'title'),
          url: getTagContent(content, 'url'),
          clickable: getTagContent(content, 'url').startsWith('http'),
          des: getTagContent(content, 'des') || getTagContent(content, 'url')
        }
      } else if (content.startsWith('[{')) {
        // 判断数组
        try {
          let json = JSON.parse(content)[0]
          return {
            title: json['title'],
            url: json['attachment'],
            clickable: json['attachment'].startsWith('http'),
            des: json['des'] || json['attachment']
          }
        } catch (e) {
          console.log(e)
          return {
            content: content
          }
        }
      } else {
        return {
          content: content
        }
      }
    }
  },
  watch: {
    messageList: {
      handler (val) {
        this.changePage(1)
      }
    }
  }
}
</script>

<style scoped lang="scss">
* {
  &::-webkit-scrollbar {
    /*滚动条整体样式*/
    width: 7px; /*高宽分别对应横竖滚动条的尺寸*/
    height: 1px;
  }

  &::-webkit-scrollbar-thumb {
    /*滚动条里面小方块*/
    border-radius: 2px;
    //box-shadow: 0px 0px 10px 10px #878787;
    //border: 1px solid #f1f1f1;
    background-color: #7d7d7d;
    background-image: -webkit-linear-gradient(
        45deg,
        rgba(255, 255, 255, 0.2) 25%,
        transparent 25%,
        transparent 50%,
        rgba(255, 255, 255, 0.2) 50%,
        rgba(255, 255, 255, 0.2) 75%,
        transparent 75%,
        transparent
    );
  }

  &::-webkit-scrollbar-track {
    /*滚动条里面轨道*/
    //box-shadow: inset 0px 0px 3px 3px #ffffff;
    border-radius: 2px;
    background: #ffffff;
  }
}

#chat_panel {
  width: 100%;
  height: calc(100% - 70px);
  overflow: auto;
  .overflow {
    text-overflow: ellipsis; overflow: hidden; white-space: nowrap;
  }
  .share-link-content {
    width: calc(100% - 60px);
    height: 46px;
    margin-right: 10px;
    font-size: 12px;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }
  .payment-text {
    display: inline-block;
    width: calc(100% - 100px);
    height: 100%;
    margin-left: 20px;
    color: #fff;
    font-weight: bold;
    line-height: 90px;
    font-size: 14px;
    cursor: default;
  }
  .system-notice {
    width: 80%;
    min-height: 25px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-left: auto;
    margin-right: auto;
    color: white;
    font-size: 14px;
    padding: 1px 13px;
  }
  .pic_image {
    left: 50%;
    height: 100%;
    position: absolute;
    top: 50%;
    transform: translate(-50%,-50%);
    width: 100%;
    z-index: 1;
  }
  .chat-message-msg-item-send {
    width: calc(100% - 30px);
    padding: 15px;
    .msg {
      max-width: 70%;
      float: right;
      align-items: center;
      flex-wrap: nowrap;
    }
    .msg-avator {
      height: 50px;
      width: 50px;
      display: flex;
      justify-content: center;
      align-items: center;
      float: right;
      margin-top: 20px;
    }
    .msg-detail {
      width: calc(100% - 50px - 10px);
      float: left;
      margin-right: 10px;
      text-align: end;
    }
    .msg-detail-content {
      background: #90e570;
      border-radius: 5px;
      font-size: 18px;
      position: relative;
      color: #181818;
      padding: 7px 10px;
      word-break: break-all;
      margin-top: 7px;
      text-align: start;
      float: right;
      .file {
        width: 400px; height: 60px; display: flex; justify-content: flex-start; align-items: center; flex-wrap: wrap;
        color: #3e3e3e;
      }
      .position {
        width: 250px; height: 255px; color: #3e3e3e;
      }
      .id-card {
        width: 220px; height: 100px; color: #282828;
        .id-card-top {
          width: 100%; height: 75px; border-bottom: 1px solid #878787; display: flex; justify-content: flex-start; align-items: center;
        }
      }
      .share-link {
        width: 250px; height: 90px; color: black;
      }
      .arrow {
        border: 5px solid transparent;
        border-left: 6px solid #90e570;
        display: inline-block;
        height: 0;
        right: -10px;
        position: absolute;
        top: 5px;
        width: 0;
      }
    }
    .msg-detail-content-trans {
      background: #ff762c;
      width: 260px;
      height: 110px;
      border-radius: 5px;
      font-size: 18px;
      position: relative;
      color: #ffffff;
      word-break: break-all;
      margin-top: 7px;
      text-align: start;
      float: right;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      .arrow {
        border: 5px solid transparent;
        border-left: 6px solid #ff762c;
        display: inline-block;
        height: 0;
        right: -10px;
        position: absolute;
        top: 5px;
        width: 0;
      }
    }
    .msg-detail-content-red-pack {
      background: #ff452c;
      border-radius: 5px;
      font-size: 18px;
      position: relative;
      color: #ffffff;
      padding: 7px 10px;
      word-break: break-all;
      margin-top: 7px;
      text-align: start;
      float: right;
      height: 230px;
      width: 170px;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      .arrow {
        border: 5px solid transparent;
        border-left: 6px solid #ff452c;
        display: inline-block;
        height: 0;
        right: -10px;
        position: absolute;
        top: 5px;
        width: 0;
      }
    }
    .msg-detail-contact {
      color: #232323;
      font-family: -apple-system;
      width: 100%;
      text-align: end;
      padding-right: 3px;
      font-size: 15px;
    }
    .msg-detail-time {
      width: 100%;
      text-align: end;
      color: #9e9e9e;
      padding: 5px 0px 3px;
      font-size: 10px;
    }
  }
  .chat-message-msg-item-receive {
    width: calc(100% - 30px);
    padding: 15px;
    .msg {
      max-width: 70%;
      float: left;
      align-items: center;
      flex-wrap: nowrap;
    }
    .msg-avator {
      height: 50px;
      width: 50px;
      display: flex;
      justify-content: center;
      align-items: center;
      float: left;
      margin-top: 20px;
    }
    .msg-detail {
      max-width: calc(100% - 50px - 10px);
      float: right;
      margin-left: 10px;
    }
    .msg-detail-content {
      background: #dbdbdb;
      border-radius: 5px;
      font-size: 18px;
      position: relative;
      color: #181818;
      padding: 7px 10px;
      word-break: break-all;
      text-align: start;
      margin-top: 7px;
      float: left;
      .file {
        width: 400px; height: 60px; display: flex; justify-content: flex-start; align-items: center; flex-wrap: wrap;
        color: #3e3e3e;
      }
      .position {
        width: 250px; height: 255px; color: #3e3e3e;
      }
      .id-card {
        width: 220px; height: 100px; color: #282828;
        .id-card-top {
          width: 100%; height: 75px; border-bottom: 1px solid #878787; display: flex; justify-content: flex-start; align-items: center;
        }
      }
      .share-link {
        width: 250px; height: 90px; color: black;
      }
      .arrow {
        border: 5px solid transparent;
        border-right: 6px solid #dbdbdb;
        display: inline-block;
        height: 0;
        left: -10px;
        position: absolute;
        top: 5px;
        width: 0;
      }
    }
    .msg-detail-content-trans {
      background: #ff762c;
      width: 260px;
      height: 110px;
      border-radius: 5px;
      font-size: 18px;
      position: relative;
      color: #ffffff;
      word-break: break-all;
      margin-top: 7px;
      text-align: start;
      float: right;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      .arrow {
        border: 5px solid transparent;
        border-right: 6px solid #ff762c;
        display: inline-block;
        height: 0;
        left: -10px;
        position: absolute;
        top: 5px;
        width: 0;
      }
    }
    .msg-detail-content-red-pack {
      background: #ff452c;
      border-radius: 5px;
      font-size: 18px;
      position: relative;
      color: #ffffff;
      padding: 7px 10px;
      word-break: break-all;
      text-align: start;
      margin-top: 7px;
      float: left;
      height: 230px;
      width: 170px;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      .arrow {
        border: 5px solid transparent;
        border-right: 6px solid #ff452c;
        display: inline-block;
        height: 0;
        left: -10px;
        position: absolute;
        top: 5px;
        width: 0;
      }
    }
    .msg-detail-contact {
      color: #232323;
      font-family: -apple-system;
      width: 100%;
      text-align: start;
      padding-left: 3px;
      font-size: 15px;
    }
    .msg-detail-time {
      width: 100%;
      text-align: start;
      color: #9e9e9e;
      padding: 5px 3px 5px 0;
      font-size: 10px;
    }
  }
}
</style>
