<template>
  <div class="im_nav">
    <div v-show="compMainAccounts.length > 0" style="width: 100%; height: 45px;">
      <el-tabs v-model="currentSelectedMainAccount" type="card" @tab-click="changeTab">
        <el-tab-pane
          v-for="item in compMainAccounts"
          :key="item.friendRelid"
          :label="!item.friendNickname || item.friendNickname === '' ? `${item.friendAccount}` : `${item.friendNickname} - ${item.friendAccount}`"
          :name="item.friendRelid"
        >
        </el-tab-pane>
      </el-tabs>
    </div>
    <div style="width: 100%; height: calc(100% - 45px); overflow: auto;" id="nav_contact_panel">
      <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;" v-show="compMainAccounts.length <= 0">
        <el-empty description="暂无数据"></el-empty>
      </div>
      <div v-show="compMainAccounts.length > 0">
        <el-menu
          :default-active="currentSelectedContact"
          :default-openeds="defaultOpenMenus"
          @select="contactSelectChange"
        >
          <el-submenu :index="'im-contact'">
            <template slot="title">
              <i class="el-icon-user-solid" />
              <span>联系人</span>
            </template>
            <el-submenu v-for="group in currentContactGrouped" :key="group.groupName" :index="group.groupName">
              <template slot="title">
                <i class="el-icon-user" />
                <span>{{ `${group.groupName}（${group.times} 次）` }}</span>
              </template>
              <el-menu-item @click="clickmenuitem({item: contact, type: 'im-contact'})" v-for="contact in contactShownLists[group.groupName]" :key="contact.friendRelid" :index="contact.friendRelid">
                <template slot="title">
                  <div v-if="contact.friendRemark && contact.friendRemark !== ''" style="width: 100%;" class="overflow" :title="`${contact.friendRemark} - ${contact.friendAccount}（${contact.messagedTimes} 次）`">
                    <el-avatar class="menu-img" shape="square"
                               v-if="contact.profilePicture.startsWith('http')"
                               :src="contact.profilePicture"
                    />
                    <el-avatar class="menu-img"
                               v-else shape="square"
                               :src="`static/attach${contact.profilePicture}`"
                    />
                    <span>{{ contact.isDeleted === 1 ? '[已删除] ' : '' }}{{ `${contact.friendRemark} - ${contact.friendAccount}（${contact.messagedTimes} 次）`}}</span>
                  </div>
                  <div v-else style="width: 100%;" class="overflow" :title="contact.friendNickname && contact.friendNickname !== '' ? `${contact.friendNickname} - ${contact.friendAccount}（${contact.messagedTimes} 次）` : `${contact.friendAccount}（${contact.messagedTimes} 次）`">
                    <el-avatar class="menu-img" shape="square"
                               v-if="contact.profilePicture.startsWith('http')"
                               :src="contact.profilePicture"
                    />
                    <el-avatar class="menu-img"
                               v-else shape="square"
                               :src="`static/attach${contact.profilePicture}`"
                    />
                    <span>{{ contact.isDeleted === 1 ? '[已删除] ' : '' }}{{ contact.friendNickname && contact.friendNickname !== '' ? `${contact.friendNickname} - ${contact.friendAccount}（${contact.messagedTimes} 次）` : `${contact.friendAccount}（${contact.messagedTimes} 次）` }}</span>
                  </div>
                </template>
              </el-menu-item>
              <div style="width: 100%; height: 40px; display: flex; align-items: center; justify-content: center;">
                <el-pagination :total="group.children.length"
                               @current-change="(page) => {changeContactPage(page, group)}"
                               :current-page="contactPages[group.groupName]"
                               :page-size="contactPageSize"
                               layout="prev, pager, next, total" :pager-count="4">
                </el-pagination>
              </div>
            </el-submenu>
          </el-submenu>
          <el-submenu :index="'im-group'">
            <template slot="title">
              <i class="el-icon-user-solid" style="margin-left: -6px;" />
              <i class="el-icon-user-solid" style="margin-left: -26px; margin-top: 5px;" />
              <span>群组</span>
            </template>
            <el-menu-item @click="clickmenuitem({item: group, type: 'im-group'})"  v-for="group in currentShownGroupList" :key="group.groupAccount" :index="group.groupAccount">
              <template slot="title">
                <div class="overflow" style="width: 100%;" :title="group.name && group.name !== '' ? `${group.name} - ${group.groupAccount}（${group.messagedTimes} 次）` : `${group.groupAccount}（${group.messagedTimes} 次）`">
                  <el-avatar class="menu-img" shape="square"
                             v-if="group.groupAvatar.startsWith('http')"
                             :src="group.groupAvatar"
                  />
                  <el-avatar class="menu-img"
                             v-else shape="square"
                             :src="`static/attach${group.groupAvatar}`"
                  />
                  <span>{{ group.isDeleted === 1 ? '[已删除] ' : '' }}{{ group.name && group.name !== '' ? `${group.name} - ${group.groupAccount}（${group.messagedTimes} 次）` : `${group.groupAccount}（${group.messagedTimes} 次）` }}</span>
                </div>
              </template>
            </el-menu-item>
            <div style="width: 100%; height: 40px; display: flex; align-items: center; justify-content: center;">
              <el-pagination :total="currentGroupList.length"
                             @current-change="changeGroupPage"
                             :current-page="currentGroupPage"
                             :page-size="contactPageSize"
                             layout="prev, pager, next, total" :pager-count="4">
              </el-pagination>
            </div>
          </el-submenu>
        </el-menu>
      </div>
    </div>
  </div>
</template>

<script>
import {loadScriptAsync} from '../../../util/util'
import {Loading} from 'element-ui'
export default {
  name: 'ImNav',
  props: {
    mainAccounts: Array,
    appCode: String
  },
  data () {
    return {
      compMainAccounts: [],
      currentSelectedMainAccount: '',
      currentContactGrouped: [],
      currentSelectedContact: '',
      contactPages: {},
      contactShownLists: {},
      contactPageSize: 30,
      currentGroupList: [],
      currentShownGroupList: [],
      currentGroupPage: 1,
      defaultOpenMenus: []
    }
  },
  methods: {
    clickmenuitem (item) {
      this.$emit('changePitch',item)
    },
    changeGroupPage (page) {
      this.currentGroupPage = page
      page = page - 1
      this.currentShownGroupList = this.currentGroupList.filter((x, index) => {
        return index >= page * this.contactPageSize && index < (page + 1) * this.contactPageSize
      })
    },
    getPagerContacts (contactList, page) {
      return contactList.filter((x, index) => index >= (page - 1) * this.contactPageSize && index < page * this.contactPageSize)
    },
    changeContactPage (page, group) {
      let groupName = group.groupName
      this.contactPages[groupName] = page
      this.contactShownLists[groupName] = this.getPagerContacts(group.children, page)
      this.$forceUpdate()
    },
    contactSelectChange (contact, indexPath) {
      this.currentSelectedContact = contact
      this.$emit('contactSelectChange', {contact, indexPath})
    },
    async changeTab (tab) {
      let loading = Loading.service({target: document.getElementById('nav_contact_panel'), text: '数据正在加载中...'})
      this.currentSelectedContact = ''
      this.currentSelectedMainAccount = tab.name
      let key = `${this.appCode} _ ${this.currentSelectedMainAccount}`
      // 加载js文件（联系人和群组）
      if (!window.globalJSData['im_contact'][key]) {
        await loadScriptAsync(`./static/data/im_contact/${this.appCode}/${this.$md5(this.currentSelectedMainAccount)}.js`)
      }
      if (!window.globalJSData['im_group'][key]) {
        await loadScriptAsync(`./static/data/im_group/${this.appCode}/${this.$md5(this.currentSelectedMainAccount)}.js`)
      }
      this.currentGroupList = window.globalJSData['im_group'][key]
      this.currentGroupList = this.currentGroupList.sort((a, b) => {
        return parseInt(b.messagedTimes) - parseInt(a.messagedTimes)
      })
      this.changeGroupPage(1)
      let currentContactGrouped = {}
      // 分组 contact
      for (let contact of window.globalJSData['im_contact'][key]) {
        if (!contact.groupName || contact.groupName === '') {
          contact.groupName = '未知分组'
        }
        if (!currentContactGrouped[contact.groupName]) {
          currentContactGrouped[contact.groupName] = {
            groupName: contact.groupName,
            times: 0,
            children: []
          }
        }
        currentContactGrouped[contact.groupName]['children'].push(contact)
        currentContactGrouped[contact.groupName]['times'] += contact.messagedTimes
      }
      // 重排分组
      let groups = []
      for (let groupName in currentContactGrouped) {
        this.contactPages[groupName] = 1
        groups.push(currentContactGrouped[groupName])
      }
      groups = groups.sort((a, b) => {
        return b.times - a.times
      })
      for (let group of groups) {
        group.children = group.children.sort((a, b) => {
          return parseInt(b.messagedTimes) - parseInt(a.messagedTimes)
        })
        this.contactShownLists[group.groupName] = this.getPagerContacts(group.children, 1)
      }
      this.currentContactGrouped = groups
      this.$emit('mainAccountChange', this.currentSelectedMainAccount)
      // 计算默认打开的菜单和默认选中的联系人
      if (this.currentContactGrouped.length > 0) {
        this.defaultOpenMenus = ['im-contact', this.currentContactGrouped[0].groupName]
        this.contactSelectChange(this.contactShownLists[this.currentContactGrouped[0].groupName][0].friendRelid)
        this.$emit('changePitch', {item: this.contactShownLists[this.currentContactGrouped[0].groupName][0], type: 'im-contact'})
      } else if (this.currentGroupList.length > 0) {
        this.defaultOpenMenus = ['im-group']
        this.contactSelectChange(this.currentShownGroupList[0].groupAccount, ['im-group'])
        this.$emit('changePitch', {item: this.currentShownGroupList[0], type: 'im-group'})
      }
      window.globalJSData['im_contact'][key] = null
      window.globalJSData['im_group'][key] = null
      loading.close()
    }
  },
  watch: {
    // appCode: {
    //   handler (val) {
    //     if (this.mainAccounts && this.mainAccounts.length > 0) {
    //       this.changeTab({name: this.mainAccounts[0].account})
    //     }
    //   }
    // },
    mainAccounts: {
      handler (val) {
        if (!val || val.length <= 0) {
          this.compMainAccounts = []
          this.currentContactGrouped = []
          this.$emit('contactSelectChange', {contact: undefined, indexPath: []})
        } else {
          this.compMainAccounts = val
          this.changeTab({name: val[0].friendRelid})
        }
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
.im_nav {
  width: 100%;
  height: 100%;
  .overflow {
    text-overflow: ellipsis; overflow: hidden; white-space: nowrap;
  }
  .menu-img {
    width: 18px; height: 18px; margin-right: 10px;
  }
}
</style>
