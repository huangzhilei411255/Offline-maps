<template>
  <div id="app_his">
    <div class="title-text">应用列表：</div>
    <el-table
      height="calc(100% - 63px - 50px)"
      max-height="calc(100% - 63px - 50px)"
      :data="currentShownData"
      style="width: calc(100%);">
      <el-table-column
        type="index"
        label="序号"
        :index="getIndex"
        width="100">
      </el-table-column>
      <el-table-column label="应用名" prop="appName"></el-table-column>
      <el-table-column label="版 本" prop="version" width="120"></el-table-column>
      <el-table-column label="应用大小" prop="size" width="100"></el-table-column>
      <el-table-column label="包 名" prop="path" width="250"></el-table-column>
      <el-table-column label="安装日期" prop="installDate"></el-table-column>
      <el-table-column label="更新日期" prop="updateDate"></el-table-column>
      <el-table-column label="应用MD5" prop="md5"></el-table-column>
    </el-table>
    <div style="width: calc(100% - 80px); height: 50px; display: flex; justify-content: center; align-items: center;">
      <el-pagination :total="appList.length" @current-change="changePage" :current-page="currentPage" :page-size="pageSize"></el-pagination>
    </div>
  </div>
</template>

<script>
import {loadScript} from '../../util/util'
import {Loading} from 'element-ui'
export default {
  name: 'AppHis',
  data () {
    return {
      appList: [],
      pageSize: 15,
      currentShownData: [],
      currentPage: 1
    }
  },
  methods: {
    getIndex (index) {
      return index + 1
    },
    getPage (page) {
      page = page - 1
      this.currentShownData = this.appList.filter((x, index) => {
        return index >= page * this.pageSize && index < (page + 1) * this.pageSize
      })
    },
    changePage (page) {
      this.getPage(page)
    }
  },
  mounted () {
    let loading = Loading.service({target: document.getElementById("app_his"), text: '数据正在加载中...'})
    loadScript('./static/data/phone_info/app_his.js', () => {
      this.appList = window.globalJSData['app_his']
      this.getPage(1)
      loading.close()
    })
  }
}
</script>

<style lang="scss">
#app_his {
  * {
    &::-webkit-scrollbar {
      display: none
    }
  }
  .el-table__body-wrapper .is-scrolling-none::-webkit-scrollbar {
    display: none !important
  }
  width: calc(100% - 80px);
  height: calc(100% - 20px);
  overflow: auto;
  padding: 10px 40px;
}
</style>
