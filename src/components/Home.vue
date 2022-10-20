<template>
  <div id="home">
    <div id="home-left">
      <div class="top">
        <span style="margin-left: 20px;">xxxx检材报告</span><span style="font-size: 10px; margin-top: -10px; margin-left: 10px;">v1.8</span>
      </div>
      <div class="tree">
        <el-menu
          :default-active="currentSelectedFunctionId"
          class="el-menu-vertical-demo"
          @select="menuSelectChange"
        >
          <nav-menu :nav-menu="navData"></nav-menu>
        </el-menu>
      </div>
    </div>
    <div id="home-right">
      <div style="width: 100%; height: 45px;">
        <el-tabs v-model="currentSelectedFunctionId" type="card" :closable="closable" @tab-remove="removeTab">
          <el-tab-pane
            v-for="item in currentOpenTabs"
            :key="item.functionId"
            :label="item.title"
            :name="item.functionId"
          >
          </el-tab-pane>
        </el-tabs>
      </div>
      <div style="width: 100%; height: calc(100% - 45px);">
        <keep-alive>
          <template v-if="!currentSelectedFunctionId.startsWith('imapp--')">
            <component :is="currentSelectedFunctionId"></component>
          </template>
          <template v-else>
            <ImApp :app-code="navList[currentSelectedFunctionId]['functionId'].replace('imapp--', '')"
                   :app-name="navList[currentSelectedFunctionId]['title']"></ImApp>
          </template>
        </keep-alive>
      </div>
    </div>
  </div>
</template>

<script>
import NavMenu from './NavMenu'
import BasicInfo from './panel/BasicInfo'
import Contact from './panel/Contact'
import CallRecord from './panel/CallRecord'
import Message from './panel/Message'
import AppHis from './panel/AppHis'
import Picture from './panel/Picture'
import Video from './panel/Video'
import Audio from './panel/Audio'
import {loadScript, loadScriptAsync} from '../util/util'
import ImApp from './panel/ImApp'
import Map_analysis from './panel/Map_analysis.vue'
import Finance from './panel/Finance'
export default {
  name: 'Home',
  components: {
    ImApp,
    NavMenu,
    basic_info: BasicInfo,
    contact: Contact,
    call_record: CallRecord,
    message: Message,
    app_his: AppHis,
    pic: Picture,
    vid: Video,
    aud: Audio,
    finance: Finance,
    map_analy: Map_analysis,
  },
  data () {
    return {
      currentOpenTabs: [],
      jsonData: [],
      currentShownData: [],
      currentPage: 0,
      navList: {},
      currentSelectedFunctionId: 'basic_info',
      navData: [
        {
          title: '手机信息',
          icon: 'el-icon-mobile',
          functionId: 'phone_info',
          children: [
            {
              title: '基本信息',
              icon: 'el-icon-document',
              functionId: 'basic_info'
            },
            {
              title: '通讯录',
              icon: 'el-icon-notebook-2',
              functionId: 'contact'
            },
            {
              title: '通话记录',
              icon: 'el-icon-phone-outline',
              functionId: 'call_record'
            },
            {
              title: '短信',
              icon: 'el-icon-chat-dot-square',
              functionId: 'message'
            },
            {
              title: '应用列表',
              icon: 'el-icon-menu',
              functionId: 'app_his'
            },
            {
              title: '文件',
              icon: 'el-icon-video-camera-solid',
              functionId: 'media',
              children: [
                {
                  title: '图片',
                  icon: 'el-icon-picture-outline',
                  functionId: 'pic'
                },
                {
                  title: '视频',
                  icon: 'el-icon-video-camera',
                  functionId: 'vid'
                },
                {
                  title: '音频',
                  icon: 'el-icon-headset',
                  functionId: 'aud'
                }
              ]
            }
          ]
        },
        {
          title: '即时通讯',
          icon: 'el-icon-chat-line-round',
          functionId: 'im',
          children: []
        },
        {
          title: '高级功能',
          icon: 'el-icon-menu',
          functionId: 'function',
          children: []
        }
      ]
    }
  },
  computed: {
    closable () {
      return this.currentOpenTabs.length > 1
    }
  },
  methods: {
    menuSelectChange (functionId) {
      this.currentSelectedFunctionId = functionId
      this.currentOpenTabs = Array.from(new Set(this.currentOpenTabs).add(this.navList[functionId]))
    },
    removeTab (tab) {
      let i = 0
      for (i = 0; i < this.currentOpenTabs.length; i ++) {
        if (this.currentOpenTabs[i].functionId === tab) {
          break
        }
      }
      this.currentOpenTabs = this.currentOpenTabs.filter(x => {
        return x.functionId !== tab
      })
      if (tab === this.currentSelectedFunctionId) {
        if (this.currentOpenTabs.length <= i) {
          this.currentSelectedFunctionId = this.currentOpenTabs[this.currentOpenTabs.length - 1].functionId
        } else {
          this.currentSelectedFunctionId = this.currentOpenTabs[i].functionId
        }
      }
    }
  },
  async mounted () {
     // 先加载后台生成的动态menu
    loadScript('./static/data/senior_function.js', () => {
      console.log(window.globalJSData['senior_function']);
      this.navData[2]['children'].push(...window.globalJSData['senior_function'].map(x => { return {...x, functionId: x.functionId} }))
    })
    // 先加载后台生成的动态menu
    loadScript('./static/data/dynamic_menu.js', () => {
      this.navData.filter(menu => {
        return menu.functionId === 'im'
      })[0]['children'].push(...window.globalJSData['dynamic_menu'].map(x => { return {...x, functionId: 'imapp--' + x.functionId} }))
      let navList = {}
      function deepScan (array) {
        for (let it of array) {
          navList[it.functionId] = {
            functionId: it.functionId,
            title: it.title
          }
          if (it.children) {
            deepScan(it.children)
          }
        }
      }
      // 将navData变成数组
      deepScan(this.navData)
      this.navList = navList
      this.currentOpenTabs.push(this.navList['basic_info'])
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
  #home {
    width: 100%;
    height: 100%;
    overflow: auto;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: row;
  }
  #home-left {
    width: 20%;
    height: calc(100% - 10px);
    box-shadow: 0px 0px 10px 2px #b3b3b3;
    .top {
      width: 100%;
      height: 100px;
      background-color: white;
      display: flex;
      align-items: center;
      color: black;
      font-size: 30px;
    }
    .tree {
      width: 100%;
      height: calc(100% - 100px);
      overflow: auto;
    }
  }
  #home-right {
    width: calc(80% - 20px);
    margin-left: 5px;
    height: calc(100% - 10px);
    overflow: hidden;
    box-shadow: 0px 0px 10px 2px #b3b3b3;
    //background-color: #a9ccf1;
  }
</style>
