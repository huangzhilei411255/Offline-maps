<template>
  <div id="video">
    <div class="title-text">视频：</div>
    <div class="vid_panel" v-if="withAttach">
      <div style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center;" v-show="currentShownVideoList.length <= 0">
        <el-empty description="暂无数据"></el-empty>
      </div>
      <template v-if="currentShownVideoList.length > 0">
        <div v-for="vid in currentShownVideoList" class="vid_item">
        <div class="vid_video_container">
          <video :src="vid.convertedPath ? `static/cloud_plus_converter/${vid.convertedPath}` : `static/attach${vid.filePath}`" controls="controls" class="vid_video"></video>
        </div>
        <div class="vid_detail">
          <div class="item">
            <div class="item_prop">文件名：</div>
            <div class="item_value"><div class="overflow" :title="vid.fileName">{{ vid.fileName }}</div></div>
          </div>
          <div class="item">
            <div class="item_prop">文件大小：</div>
            <div class="item_value"><div class="overflow" :title="vid.fileSize">{{ formatFileSize(vid.fileSize) }}</div></div>
          </div>
          <div class="item">
            <div class="item_prop">MD5：</div>
            <div class="item_value"><div class="overflow" :title="vid.md5">{{ vid.md5 }}</div></div>
          </div>
          <div class="item">
            <div class="item_prop">文件路径：</div>
            <div class="item_value"><div class="overflow" :title="vid.filePath">{{ vid.filePath }}</div></div>
          </div>
        </div>
      </div>
      </template>
    </div>
    <div v-else class="vid_table_panel">
      <el-table :data="currentShownVideoList" height="100%" max-height="100%">
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
      <el-pagination :total="videoList.length"
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
  name: 'Video',
  data () {
    return {
      currentShownVideoList: [],
      videoList: [],
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
      this.currentShownVideoList = this.videoList.filter((x, index) => {
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
    let loading = Loading.service({target: document.getElementById('video'), text: '数据正在加载中...'})
    loadScript('./static/data/phone_info/file/video.js', async () => {
      await loadScriptAsync('./static/data/meta_info.js')
      this.withAttach = window.globalJSData['meta_info']['withAttach']
      this.videoList = window.globalJSData['file']['video']
      // 筛选除pic
      this.getPage(1)
      loading.close()
    })
  }
}
</script>

<style scoped lang="scss">
#video {
  * {
    &::-webkit-scrollbar {
      display: none
    }
  }
  .overflow {
    text-overflow: ellipsis; overflow: hidden; white-space: nowrap;
  }
  width: calc(100% - 80px);
  height: calc(100% - 20px);
  padding: 10px 40px;
  .vid_panel {
    width: 100%;
    height: calc(100% - 63px - 50px);
    display: flex;
    justify-content: flex-start;
    align-items: flex-start;
    align-content: flex-start;
    flex-direction: row;
    flex-wrap: wrap;
    .vid_item {
      width: calc(25% - 4px);
      height: calc(33% - 1px);
      background: white;
      margin: 2px;
      box-shadow: 0 0 3px 2px #e5e5e5;
      transition: .5s ease all;
      position: relative;
      overflow: hidden;
      .vid_video_container {
        height: calc(100% - 90px);
        width: 100%;
        .vid_video {
          height: 100%;
          width: 100%;
          z-index: 1;
        }
      }
      .vid_detail {
        width: calc(100% - 20px);
        height: 70px;
        color: white;
        display: flex;
        flex-direction: column;
        justify-content: center;
        padding: 10px;
        background: #5f5f5f;
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
    .vid_item:hover {
      box-shadow: 0 0 25px 3px #cecece;
    }
  }
  .vid_table_panel {
    width: 100%;
    height: calc(100% - 63px - 50px);
  }
}
</style>
