<template>
  <div id="app">
    <keep-alive>
      <router-view/>
    </keep-alive>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style lang="scss">
  #app {
    height: 100%;
    min-width: 1300px;
    .title-text {
      width: 100%; height: 63px; font-weight: bold; display: flex; align-items: center;
    }
    .el-pagination__total {
      margin-left: 20px;
    }
  }
  @import "assets/common";
</style>
