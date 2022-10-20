<template>
    <div>
       <div v-if="!pickerOptions" style="display: flex; align-items: center;">
            <el-date-picker  type="date" placeholder="开始日期" value-format="timestamp" :style="dateStyle" @change="changeDateStart" v-model="dateTimeFrom"  :size="size"></el-date-picker>
            <span class="excessive">-</span>
            <el-date-picker  type="date" placeholder="结束日期" value-format="timestamp" :style="dateStyle" @change="changeDateOver" v-model="dateTimeTo"  :size="size"></el-date-picker>
       </div>
       <div v-else style="display: flex; align-items: center;">
            <el-date-picker id="aa" type="date" :pickerOptions="pickerOptions" placeholder="开始日期" value-format="timestamp" :style="dateStyle" @change="changeDateStart" v-model="dateTimeFrom" :size="size"></el-date-picker>
            <span class="excessive">-</span>
            <el-date-picker id="bb" type="date" :pickerOptions="pickerOptions" placeholder="结束日期" value-format="timestamp" :style="dateStyle" @change="changeDateOver" v-model="dateTimeTo"  :size="size"></el-date-picker>
       </div>
    </div>
</template>
<script>
export default {
    props: {
        changeDate: Function,
        pickerOptions:Object,
        size:String,
        dateStyle:String,
        startTime:Number,
        endTime:Number,
    },
    data(){
        return{
            dateTimeFrom:null,
            dateTimeTo:null,

        }
    },
    computed: {
    },
    methods:{
        changeDateStart(){
            if (this.dateTimeFrom != null && this.dateTimeTo != null) {
                if (this.dateTimeTo > this.dateTimeFrom) {
                    this.changeDate([this.handleTime(this.dateTimeFrom),this.handleTime(this.dateTimeTo)]);
                }else if (this.dateTimeTo ==  this.dateTimeFrom) {
                    this.changeDate([this.handleTime(this.dateTimeFrom),this.handleTime(this.dateTimeTo)]);
                    // this.dateTimeTo = this.dateTimeTo + 86400000
                }else{
                    let dateTimeFroms = this.dateTimeFrom;
                    this.dateTimeFrom = this.dateTimeTo;
                    this.dateTimeTo = dateTimeFroms;
                    this.changeDate([this.handleTime(this.dateTimeFrom),this.handleTime(this.dateTimeTo)]);
                }
            }else if (this.dateTimeFrom == null) {
                this.changeDate();
            }
            this.$emit("dateTimeNumberChangeCallBack", {startTime: this.dateTimeFrom, endTime: this.dateTimeTo});
        },
        changeDateOver(){
            if (this.dateTimeFrom != null && this.dateTimeTo != null) {
                if (this.dateTimeTo > this.dateTimeFrom) {
                    this.changeDate([this.handleTime(this.dateTimeFrom),this.handleTime(this.dateTimeTo)]);
                }else if (this.dateTimeTo ==  this.dateTimeFrom) {
                    this.changeDate([this.handleTime(this.dateTimeFrom),this.handleTime(this.dateTimeTo)]);
                    // this.dateTimeTo = this.dateTimeTo + 86400000
                }else{
                    let dateTimeFroms = this.dateTimeFrom;
                    this.dateTimeFrom = this.dateTimeTo;
                    this.dateTimeTo = dateTimeFroms;
                    this.changeDate([this.handleTime(this.dateTimeFrom),this.handleTime(this.dateTimeTo)]);
                }
            }else if (this.dateTimeTo == null) {
                this.changeDate();
            }
            this.$emit("dateTimeNumberChangeCallBack", {startTime: this.dateTimeFrom, endTime: this.dateTimeTo});
        },
        handleTime(time) {
            const date = new Date(+time)
            const y = date.getFullYear() + '-'
            const mo = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-'
            const d = (date.getDate() < 10 ? '0' + (date.getDate()) : date.getDate()) + ''
            return y + mo + d
        },
        emptyTime() {
            this.dateTimeFrom = null
            this.dateTimeTo = null
        }

    },
    watch:{
        startTime:{
            immediate:true,
            handler:function(){
                if (this.startTime) {
                    this.dateTimeFrom = this.startTime
                } else {
                    this.dateTimeFrom = null
                }
                
            }

        },
        endTime:{
            immediate:true,
            handler:function(){
                if (this.endTime) {
                    this.dateTimeTo = this.endTime
                } else {
                    this.dateTimeTo = null
                }
                
            }
        },
    }
}
</script>
<style scoped lang="scss">
.excessive{
    font-weight: 700;
    margin: 0px 5px;

}
</style>
