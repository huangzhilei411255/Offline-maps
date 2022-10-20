<template>
  <div id="audio">
    <div class="title-text">音频：</div>
    <div class="aud_panel" v-if="withAttach">
      <div style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center;" v-show="currentShownAudioList.length <= 0">
        <el-empty description="暂无数据"></el-empty>
      </div>
      <template v-if="currentShownAudioList.length > 0">
        <div v-for="aud in currentShownAudioList" class="aud_item">
          <div class="aud_audio_container">
            <audio :src="aud.convertedPath ? `static/cloud_plus_converter/${aud.convertedPath}` : `static/attach${aud.filePath}`" controls="controls" class="aud_audio"></audio>
          </div>
          <div class="aud_detail">
            <div class="item">
              <div class="item_prop">文件名：</div>
              <div class="item_value"><div class="overflow" :title="aud.fileName">{{ aud.fileName }}</div></div>
            </div>
            <div class="item">
              <div class="item_prop">文件大小：</div>
              <div class="item_value"><div class="overflow" :title="aud.fileSize">{{ formatFileSize(aud.fileSize) }}</div></div>
            </div>
            <div class="item">
              <div class="item_prop">MD5：</div>
              <div class="item_value"><div class="overflow" :title="aud.md5">{{ aud.md5 }}</div></div>
            </div>
            <div class="item">
              <div class="item_prop">文件路径：</div>
              <div class="item_value"><div class="overflow" :title="aud.filePath">{{ aud.filePath }}</div></div>
            </div>
          </div>
        </div>
      </template>
    </div>
    <div v-else class="aud_table_panel">
      <el-table :data="currentShownAudioList" height="100%" max-height="100%">
        <el-table-column
          type="index"
          label="序号"
          :index="getIndex"
          width="100">
        </el-table-column>
        <el-table-column label="文件名" prop="fileName" width="320"></el-table-column>
        <el-table-column label="文件大小" width="120">
          <template slot-scope="scope">
            {{ formatFileSize(scope.row.fileSize) }}
          </template>
        </el-table-column>
        <el-table-column label="MD5" prop="md5" width="300"></el-table-column>
        <el-table-column label="文件路径" prop="filePath"></el-table-column>
        <el-table-column label="提示" width="60">
          <el-tooltip content="附件未勾选，文件不存在" placement="top">
            <i style="font-size: 20px;" class="el-icon-warning-outline"></i>
          </el-tooltip>
        </el-table-column>
      </el-table>
    </div>
    <div style="width: calc(100% - 80px); height: 50px; display: flex; justify-content: center; align-items: center;">
      <el-pagination :total="audioList.length"
                     @current-change="changePage"
                     :current-page="currentPage"
                     :page-size="pageSize"
      ></el-pagination>
    </div>
  </div>
</template>

<script>
import {Loading} from 'element-ui'
import {loadScript, formatFileSize, loadScriptAsync} from '../../util/util'

export default {
  name: 'Audio',
  data () {
    return {
      currentShownAudioList: [],
      audioList: [],
      currentPage: 1,
      pageSize: 12,
      withAttach: false
    }
  },
  methods: {
    changePage (page) {
      this.getPage(page)
    },
    getPage (page) {
      page = page - 1
      this.currentShownAudioList = this.audioList.filter((x, index) => {
        return index >= page * this.pageSize && index < (page + 1) * this.pageSize
      })
    },
    formatFileSize (fileSize) {
      return formatFileSize(fileSize)
    },
    getIndex (index) {
      return index + 1
    }
  },
  mounted () {
    let loading = Loading.service({target: document.getElementById('audio'), text: '数据正在加载中...'})
    loadScript('./static/data/phone_info/file/audio.js', async () => {
      await loadScriptAsync('./static/data/meta_info.js')
      this.withAttach = window.globalJSData['meta_info']['withAttach']
      this.audioList = window.globalJSData['file']['audio']
      // 筛选除pic
      this.getPage(1)
      loading.close()
    })
  }
}
</script>

<style lang="scss">
#audio {
  * {
    &::-webkit-scrollbar {
      display: none
    }
  }
  .el-table__body-wrapper .is-scrolling-none::-webkit-scrollbar {
    display: none !important
  }
  .overflow {
    text-overflow: ellipsis; overflow: hidden; white-space: nowrap;
  }
  width: calc(100% - 80px);
  height: calc(100% - 20px);
  padding: 10px 40px;
  .aud_panel {
    width: 100%;
    height: calc(100% - 63px - 50px);
    display: flex;
    justify-content: flex-start;
    align-items: flex-start;
    align-content: flex-start;
    flex-direction: row;
    flex-wrap: wrap;
    .aud_item {
      width: calc(25% - 4px);
      height: calc(33% - 1px);
      background: white;
      margin: 2px;
      box-shadow: 0 0 3px 2px #e5e5e5;
      transition: .5s ease all;
      position: relative;
      overflow: hidden;
      .aud_audio_container {
        height: calc(100% - 90px);
        width: 100%;
        .aud_audio {
          height: 100%;
          width: 100%;
          z-index: 1;
          background: #f8f8f8;
        }
      }
      .aud_detail {
        width: calc(100% - 20px);
        height: 70px;
        color: #151515;
        display: flex;
        flex-direction: column;
        justify-content: center;
        padding: 10px;
        background: #ffffff;
        .item {
          display: flex;
          justify-content: center;
          align-content: center;
          .item_prop {
            width: 80px;
            font-size: 15px;
          }
          .item_value {
            display: flex;
            align-items: center;
            width: calc(100% - 80px);
            font-size: 15px;
          }
        }
      }
    }
    .aud_item:hover {
      box-shadow: 0 0 25px 3px #cecece;
    }
  }
  .aud_table_panel {
    width: 100%;
    height: calc(100% - 63px - 50px);
  }
}
</style>
