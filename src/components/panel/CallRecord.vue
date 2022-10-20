<template>
  <div id="call_record">
    <div class="title-text">通话记录：</div>
    <div class="call_record_main_panel">
      <div class="left" :style="`width: calc(30% + (${left}px));`">
        <contact-nav :contact-list="contactList" :type="'callrecord'" @pageChange="getContactPage" @selectContact="selectContact"></contact-nav>
      </div>
      <div
        @mouseup="dragBar({e: $event, type: 'up'})"
        @mousedown.stop="dragBar({e: $event, type: 'down'})"
        @mousemove="dragBar({e: $event, type: 'move'})"
        class="drag_bar"
      >
        <div>.</div>
        <div>.</div>
        <div>.</div>
      </div>
      <div class="right" :style="`width: calc(70% - 10px - (${left}px));`">
        <el-table
          height="calc(100% - 50px)"
          :data="currentShownCallRecordList"
          style="width: 100%">
          <el-table-column
            type="index"
            label="序号"
            :index="getIndex"
            width="180">
          </el-table-column>
          <el-table-column
            label="类型"
            width="180">
            <template slot-scope="scope">
              {{ scope.row.received ? '接听' : '呼叫' }}
            </template>
          </el-table-column>
          <el-table-column
            label="通话时长">
            <template slot-scope="scope">
              {{scope.row.calledTime != -1 ? scope.row.calledTime + ' 秒' : ''}}
            </template>
          </el-table-column>
          <el-table-column
            label="日期">
            <template slot-scope="scope">
              {{ getCalledDate(scope.row.callDate) }}
            </template>
          </el-table-column>
          <el-table-column
            label="是否删除">
            <template slot-scope="scope">
              {{ scope.row.isDelMsg ? '是' : '否' }}
            </template>
          </el-table-column>
        </el-table>
        <div style="width: 100%; height: 50px; display: flex; justify-content: center; align-items: center;">
          <el-pagination :total="callRecordList.length"
                         @current-change="changeCallRecordPage"
                         :current-page="currentRecordPage"
                         :page-size="callRecordPageSize"
          ></el-pagination>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {loadScript, formatDate} from '../../util/util'
import {Loading} from 'element-ui'
import ContactNav from './comp/ContactNav'
export default {
  name: 'CallRecord',
  components: {ContactNav},
  data () {
    return {
      contactList: [],
      callRecordList: [],
      currentShownCallRecordList: [],
      callRecordPageSize: 30,
      currentRecordPage: 1,
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
    getCalledDate (date) {
      return formatDate(date, 'Y-M-D h:m:s')
    },
    selectContact (contact) {
      this.callRecordList = contact.callRecords
      this.getRecordPage(1)
    },
    getContactPage (activeObj) {
      this.callRecordList = activeObj.callRecords
      this.getRecordPage(1)
    },
    getRecordPage (page) {
      this.currentRecordPage = page
      page = page - 1
      this.currentShownCallRecordList = this.callRecordList.filter((x, index) => {
        return index >= page * this.callRecordPageSize && index < (page + 1) * this.callRecordPageSize
      })
    },
    changeCallRecordPage (page) {
      this.getRecordPage(page)
    },
    getIndex (index) {
      return index + 1
    }
  },
  mounted () {
    let loading = Loading.service({target: document.getElementById('call_record'), text: '数据正在加载中...'})
    loadScript('./static/data/phone_info/call_record.js', () => {
      this.contactList = window.globalJSData['call_record']
      loading.close()
    })
  }
}
</script>

<style lang="scss">
#call_record {
  * {
    &::-webkit-scrollbar {
      display: none !important;
    }
  }
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
  padding: 10px 40px;
  .el-table__body-wrapper .is-scrolling-none::-webkit-scrollbar {
    display: none !important
  }
  .call_record_main_panel {
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
