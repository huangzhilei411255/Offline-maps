<template>
  <div>
    <template v-if="navMenu" v-for="nav in navMenu">
      <el-submenu v-if="nav.children" :index="nav.functionId">
        <template slot="title">
          <i v-if="!nav.functionId.startsWith('imapp--')" :class="nav.icon"></i>
          <img class="menu-img" v-else src="static/img/male.png" />
          <span>{{ nav.title }}</span>
        </template>
        <nav-menu :nav-menu="nav.children"></nav-menu>
      </el-submenu>
      <el-menu-item v-else :index="nav.functionId">
        <template slot="title">
          <i v-if="!nav.functionId.startsWith('imapp--') && nav.functionId != 'finance'  && nav.functionId != 'map_analy'" :class="nav.icon"></i>
          <img class="menu-img" v-else :src="`static/img/logo/${nav.functionId == 'map_analy' ? 'map' : nav.functionId.replace('imapp--', '')}.png`" />
          <span>{{ nav.title }}</span>
        </template>
      </el-menu-item>
    </template>
  </div>
</template>

<script>
export default {
  name: 'NavMenu',
  props: {
    navMenu: Array
  }
}
</script>

<style scoped>
.menu-img {
  width: 18px; height: 18px; margin-right: 10px;
}
</style>
