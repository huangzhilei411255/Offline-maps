<template>
  <div style="width: 100%; height: 100%;">
    <div :style="`width: ${width}; height: ${height}; position: relative; background-color: #eeeeee; display: flex; justify-content: center; align-items: center; font-size: 15px;`"
         v-show="!isExist">
      <span :style="imgLoading ? 'color: grey;' : 'color: red;'">
        <i :class="imgLoading ? 'el-icon-loading' : 'el-icon-error'"></i> {{ imgLoading ? '图片正在加载中...' : '图片加载失败' }}
      </span>
    </div>
    <div v-show="isExist"
         :style="`width: ${width}; height: ${height}; position: relative;`">
      <img :src="src" @load="loaded" @error="loadError" class="pic_image"/>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CommonImage',
  props: {
    width: String,
    height: String,
    src: String
  },
  data () {
    return {
      isExist: false,
      imgLoading: true
    }
  },
  methods: {
    loaded () {
      this.imgLoading = false
      this.isExist = true
    },
    loadError () {
      this.imgLoading = false
      this.isExist = false
    }
  },
  watch: {
    src: {
      handler (val) {
        this.isExist = false
        this.imgLoading = true
      }
    }
  }
}
</script>

<style scoped lang="scss">
.pic_image {
  left: 50%;
  min-height: 100%;
  position: absolute;
  top: 50%;
  transform: translate(-50%,-50%);
  width: 100%;
  z-index: 1;
}
</style>
