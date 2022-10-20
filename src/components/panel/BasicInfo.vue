<template>
  <div id="basic_info">
    <div style="width: calc(100%);" v-for="(csInfo, index) in caseInfo">
      <div class="title-text" v-if="caseInfo.length > 1">{{`案件信息（${index + 1}）：`}}</div>
      <div class="title-text" v-else>{{`案件信息：`}}</div>
      <el-table
        :data="csInfo"
        style="width: 100%">
        <el-table-column
          label="序号"
          width="180">
          <template slot-scope="scope">
            {{ scope.row.index }}
          </template>
        </el-table-column>
        <el-table-column
          label="属性"
          width="180">
          <template slot-scope="scope">
            {{ scope.row.key }}
          </template>
        </el-table-column>
        <el-table-column
          label="内容">
          <template slot-scope="scope">
            {{ scope.row.value }}
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div style="width: calc(100%);">
      <div class="title-text">嫌疑人信息：</div>
      <el-table
        :data="suspectInfo"
        style="width: 100%">
        <el-table-column
          prop="index"
          label="序号"
          width="180">
        </el-table-column>
        <el-table-column
          prop="prop"
          label="属性"
          width="180">
        </el-table-column>
        <el-table-column
          prop="value"
          label="内容">
        </el-table-column>
      </el-table>
    </div>
    <div style="width: calc(100%); margin-bottom: 20px;">
      <div class="title-text">手机信息：</div>
      <el-table
        :data="phoneInfo"
        style="width: 100%">
        <el-table-column
          prop="index"
          label="序号"
          width="180">
        </el-table-column>
        <el-table-column
          prop="prop"
          label="属性"
          width="180">
        </el-table-column>
        <el-table-column
          prop="value"
          label="内容">
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>
import {loadScript, formatDate} from '../../util/util'
import {Loading} from 'element-ui'

export default {
  name: 'BasicInfo',
  data () {
    return {
      caseInfo: [],
      suspectInfo: [],
      phoneInfo: [],
      companyMap: {
        '0': '拓 界',
        '1': '美 亚',
        '2': '平 航',
        '3': '睿 海',
        '4': '歆 仁'
      }
    }
  },
  methods: {
    loadCaseInfo () {
      for (let csInfo of window.globalJSData['basic_info']['caseDetails']) {
        this.caseInfo.push(
          [
            {index: 1, key: '案件名称', value: csInfo.caseName},
            {index: 2, key: '创建时间', value: formatDate(csInfo.createTime, 'Y-M-D h:m:s')}
          ]
        )
      }
    },
    loadSuspectInfo () {
      this.suspectInfo.push({
        index: 1,
        prop: '嫌疑人姓名',
        value: window.globalJSData['basic_info']['suspectDetail']['label']
      })
      this.suspectInfo.push({
        index: 2,
        prop: '身份证',
        value: window.globalJSData['basic_info']['suspectDetail']['cardId']
      })
      // this.suspectInfo.push({
      //   index: 3,
      //   prop: '创建时间',
      //   value: formatDate(window.globalJSData['basic_info']['suspectDetail']['createDateTime'], 'Y-M-D h:m:s')
      // })
      this.suspectInfo.push({
        index: 3,
        prop: '曾用名',
        value: window.globalJSData['basic_info']['suspectDetail']['priviousName']
      })
      this.suspectInfo.push({
        index: 4,
        prop: '性别',
        value: window.globalJSData['basic_info']['suspectDetail']['sex']
      })
      this.suspectInfo.push({
        index: 5,
        prop: '住址',
        value: window.globalJSData['basic_info']['suspectDetail']['homeAddr']
      })
      this.suspectInfo.push({
        index: 6,
        prop: '籍贯',
        value: window.globalJSData['basic_info']['suspectDetail']['birthPlace']
      })
      // this.suspectInfo.push({
      //   index: 8,
      //   prop: '生日',
      //   value: formatDate(window.globalJSData['basic_info']['suspectDetail']['birthDate'], 'Y-M-D h:m:s')
      // })
      this.suspectInfo.push({
        index: 7,
        prop: '婚姻状况',
        value: window.globalJSData['basic_info']['suspectDetail']['married'] ? '已婚' : '未婚'
      })
    },
    loadPhoneInfo () {
      this.phoneInfo.push({
        index: 1,
        prop: '手机名称',
        value: window.globalJSData['basic_info']['name']
      })
      this.phoneInfo.push({
        index: 2,
        prop: '手机号码',
        value: window.globalJSData['basic_info']['phoneNo']
      })
      this.phoneInfo.push({
        index: 3,
        prop: '构件版本',
        value: window.globalJSData['basic_info']['structVersion']
      })
      this.phoneInfo.push({
        index: 4,
        prop: '设备ID',
        value: window.globalJSData['basic_info']['devName']
      })
      this.phoneInfo.push({
        index: 5,
        prop: 'MAC地址',
        value: window.globalJSData['basic_info']['macAddr']
      })
      this.phoneInfo.push({
        index: 6,
        prop: '蓝牙地址',
        value: window.globalJSData['basic_info']['bluetoothAddress']
      })
      this.phoneInfo.push({
        index: 7,
        prop: '物证手机生产厂商',
        value: window.globalJSData['basic_info']['phoneManuFacturer']
      })
      this.phoneInfo.push({
        index: 8,
        prop: '物证手机内部型号',
        value: window.globalJSData['basic_info']['phoneInterModel']
      })
      this.phoneInfo.push({
        index: 9,
        prop: '物证手机型号',
        value: window.globalJSData['basic_info']['phoneModel']
      })
      this.phoneInfo.push({
        index: 10,
        prop: '系统版本',
        value: window.globalJSData['basic_info']['sysVersion']
      })
      this.phoneInfo.push({
        index: 11,
        prop: '物证手机取证日期',
        value: window.globalJSData['basic_info']['reportTime']
      })
      this.phoneInfo.push({
        index: 12,
        prop: '物证手机目标标识',
        value: window.globalJSData['basic_info']['targetIdentification']
      })
      this.phoneInfo.push({
        index: 13,
        prop: '物证手机目标类型',
        value: window.globalJSData['basic_info']['targetType']
      })
      this.phoneInfo.push({
        index: 14,
        prop: '物证手机唯一标识符',
        value: window.globalJSData['basic_info']['uniqueName']
      })
      this.phoneInfo.push({
        index: 15,
        prop: 'GUID',
        value: window.globalJSData['basic_info']['guId']
      })
      this.phoneInfo.push({
        index: 16,
        prop: 'ICCID',
        value: window.globalJSData['basic_info']['iccId']
      })
      this.phoneInfo.push({
        index: 17,
        prop: '物证手机标签',
        value: window.globalJSData['basic_info']['buildLabel']
      })
      this.phoneInfo.push({
        index: 18,
        prop: '物证手机指纹信息',
        value: window.globalJSData['basic_info']['fingerPrint']
      })
      this.phoneInfo.push({
        index: 19,
        prop: '物证手机内置存储',
        value: window.globalJSData['basic_info']['totalCapacity']
      })
      this.phoneInfo.push({
        index: 20,
        prop: '物证手机外部存储',
        value: window.globalJSData['basic_info']['notUseCapacity']
      })
      this.phoneInfo.push({
        index: 21,
        prop: '物证手机备份日期',
        value: window.globalJSData['basic_info']['backupDate']
      })
      this.phoneInfo.push({
        index: 22,
        prop: '物证手机导入日期',
        value: window.globalJSData['basic_info']['addDate']
      })

      this.phoneInfo.push({
        index: 23,
        prop: '品牌',
        value: window.globalJSData['basic_info']['phoneBrandChineseName']
      })
      this.phoneInfo.push({
        index: 24,
        prop: '导入来源',
        value: this.companyMap[window.globalJSData['basic_info']['dataSourceFactory']]
      })
      this.phoneInfo.push({
        index: 25,
        prop: '系带版本',
        value: window.globalJSData['basic_info']['baseVersion']
      })
      this.phoneInfo.push({
        index: 26,
        prop: '颜色',
        value: window.globalJSData['basic_info']['color']
      })
      this.phoneInfo.push({
        index: 27,
        prop: '固件版本',
        value: window.globalJSData['basic_info']['firmwareVersion']
      })
      this.phoneInfo.push({
        index: 28,
        prop: 'MEID',
        value: window.globalJSData['basic_info']['meid']
      })
      this.phoneInfo.push({
        index: 29,
        prop: 'IMEI',
        value: window.globalJSData['basic_info']['imei']
      })
      this.phoneInfo.push({
        index: 30,
        prop: 'IMEI2',
        value: window.globalJSData['basic_info']['imei2']
      })
      this.phoneInfo.push({
        index: 31,
        prop: 'IMSI',
        value: window.globalJSData['basic_info']['imsi']
      })
      this.phoneInfo.push({
        index: 32,
        prop: 'MLB序列号',
        value: window.globalJSData['basic_info']['sequenceCode']
      })
      this.phoneInfo.push({
        index: 33,
        prop: '备注',
        value: window.globalJSData['basic_info']['remark']
      })
      this.phoneInfo.push({
        index: 34,
        prop: 'Root状态',
        value: window.globalJSData['basic_info']['rooted'] ? '是' : '否'
      })
      this.phoneInfo.push({
        index: 35,
        prop: '是否激活',
        value: window.globalJSData['basic_info']['activated'] ? '是' : '否'
      })
    }
  },
  mounted () {
    let loading = Loading.service({target: document.getElementById('basic_info'), text: '数据正在加载中...'})
    loadScript('./static/data/phone_info/basic_info.js', () => {
      loading.close()
      // 加载案件信息、嫌疑人信息、手机信息
      // 案件信息
      this.loadCaseInfo()
      // 嫌疑人信息
      this.loadSuspectInfo()
      // 手机信息
      this.loadPhoneInfo()
    })
  }
}
</script>

<style lang="scss">
#basic_info {
  width: calc(100% - 80px);
  height: calc(100% - 20px);
  padding: 10px 40px;
  display: flex;
  justify-content: flex-start;
  flex-wrap: wrap;
  align-content: flex-start;
  overflow: auto;
  * {
    &::-webkit-scrollbar {
      display: none
    }
  }
  .el-table__body-wrapper .is-scrolling-none::-webkit-scrollbar {
    display: none !important
  }
  .suspect_card {
    width: 50%;
    height: 40%;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .case_card {
    width: 50%;
    height: 40%;
  }
  .phone_card {
    width: 100%;
    height: 60%;
  }
}
</style>
