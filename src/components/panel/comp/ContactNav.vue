<template>
  <div style="width: 100%; height: 100%;">
    <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;" v-show="contactList.length <= 0">
      <el-empty description="暂无数据"></el-empty>
    </div>
    <div v-show="contactList.length > 0" style="width: 100%; height: calc(100% - 42px); overflow: auto;">
      <div :class="currentActive === contact.targetPhoneNumber ? 'contact_item active' : 'contact_item'"
           v-for="contact in currentShownContactList"
           @click="selectContact(contact)">
        <div style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: calc(100% - 130px);" :title="(contact.contactName && contact.contactName != '' ? `${contact.contactName}-` : '') + contact.targetPhoneNumber + `（${contact.calledTimes}次）`">
          <i :class="type == 'message' ? 'el-icon-chat-dot-square' : 'el-icon-phone'" style="margin-left: 8px;"></i>
          <span>{{ (contact.contactName && contact.contactName != '' ? `${contact.contactName}-` : '') + contact.targetPhoneNumber + `（${contact.calledTimes}次）` }}</span>
        </div>
        <div style="width: 130px;"><span style="margin-right: 8px; font-size: 13px; color: #939393;">{{contact.lastChatTime }}</span></div>
      </div>
    </div>
    <div style="width: 100%; height: 42px; display: flex; justify-content: center; align-items: center;">
      <el-pagination :total="contactList.length"
                     @current-change="changeContactPage"
                     :current-page="currentContactPage"
                     :page-size="contactPageSize"
                     layout="prev, pager, next, total" :pager-count="4">
      </el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ContactNav',
  data () {
    return {
      currentContactPage: 1,
      contactPageSize: 19,
      currentActive: '',
      currentShownContactList: []
    }
  },
  props: {
    contactList: Array,
    type: String
  },
  methods: {
    changeContactPage (page) {
      this.currentContactPage = page
      page = page - 1
      this.currentShownContactList = this.contactList.filter((x, index) => {
        return index >= page * this.contactPageSize && index < (page + 1) * this.contactPageSize
      })
      this.currentActive = this.currentShownContactList[0].targetPhoneNumber
      this.$emit('pageChange', this.currentShownContactList[0])
    },
    selectContact (contact) {
      this.currentActive = contact.targetPhoneNumber
      this.$emit('selectContact', contact)
    }
  },
  watch: {
    contactList: {
      handler (val) {
        this.changeContactPage(1)
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
.contact_item {
  width: 100%;
  display: flex;
  justify-content: space-between;
  height: 41px;
  align-items: center;
  cursor: pointer;
  transition: .5s ease all;
}
.contact_item:hover {
  background: #bee5ff;
}
.active {
  background: #bee5ff;
}
</style>
