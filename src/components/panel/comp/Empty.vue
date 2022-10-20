<template>
  <div style="width: 100%; height: 100%;">
    <el-empty :description="text"></el-empty>
  </div>
</template>

<script>
export default {
  name: 'Empty',
  props: {
   text: '无数据'
  },
  data () {
    return {
     
    }
  },
  methods: {
    
  },
  watch: {
   
  }
}
</script>

<style scoped lang="scss">

</style>
