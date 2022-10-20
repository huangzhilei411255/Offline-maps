<template>
  <div id="contact">
    <div class="title-text">手机通讯录：</div>
    <el-table
      height="calc(100% - 50px - 63px)"
      max-height="calc(100% - 50px - 63px)"
      :data="currentShownList"
      style="width: 100%;">
      <el-table-column
        type="index"
        label="序号"
        :index="getIndex"
        width="180">
      </el-table-column>
      <el-table-column
        prop="contactName"
        label="姓名"
        width="180">
      </el-table-column>
      <el-table-column
        prop="contactNum"
        label="号码">
      </el-table-column>
      <el-table-column
        prop="city"
        label="归属地">
      </el-table-column>
      <el-table-column
        prop="contactEmail"
        label="邮箱">
      </el-table-column>
      <el-table-column
        prop="contactAddr"
        label="地址">
      </el-table-column>
      <el-table-column
        label="是否删除">
        <template slot-scope="scope">
          {{ scope.row.isDelMsg ? '是' : '否' }}
        </template>
      </el-table-column>
    </el-table>
    <div style="width: calc(100% - 80px); height: 50px; display: flex; justify-content: center; align-items: center;">
      <el-pagination :total="contactList.length" @current-change="changePage" :current-page="currentPage" :page-size="pageSize"></el-pagination>
    </div>
  </div>
</template>

<script>
import {loadScript} from '../../util/util'
import {Loading} from 'element-ui'

export default {
  name: 'Contact',
  data () {
    return {
      currentPage: 0,
      contactList: [],
      currentShownList: [],
      pageSize: 15
    }
  },
  methods: {
    changePage (page) {
      page = page - 1
      this.currentShownList = this.contactList.filter((x, index) => {
        return index >= page * this.pageSize && index < (page + 1) * this.pageSize
      })
    },
    getIndex (index) {
      return index + 1
    }
  },
  mounted () {
    let loading = Loading.service({target: document.getElementById('contact'), text: '数据正在加载中...'})
    loadScript('./static/data/phone_info/contact.js', () => {
      this.contactList = window.globalJSData['contact']
      this.changePage(1)
      loading.close()
    })
  }
}
</script>

<style lang="scss">
#contact {
  width: calc(100% - 80px);
  height: calc(100% - 20px);
  overflow: auto;
  padding: 10px 40px;
  * {
    &::-webkit-scrollbar {
      display: none
    }
  }
  .el-table__body-wrapper .is-scrolling-none::-webkit-scrollbar {
    display: none !important
  }
}
</style>
