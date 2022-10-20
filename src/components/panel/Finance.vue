<template>
  <div id="finance">
    <div class="header">
      <div>资金分析：</div>
      <!-- <div>
        <el-switch
          style="display: block"
          v-model="formType"
          active-color="#459FFC"
          inactive-color="#DCDFE6"
          active-text="关系"
          inactive-text="表格"
        >
        </el-switch>
      </div> -->
    </div>
    <div class="content">
      <div class="finance-left">
        <div class="div1">
          <div class="left-top-title-wrap">
            <div class="title">交易{{ radio }} TOP 10</div>
            <div class="typeBtn">
              <el-radio-group
                size="mini"
                @change="changeTypeBtnTop10"
                v-model="radio"
              >
                <el-radio-button label="次数"></el-radio-button>
                <el-radio-button label="金额"></el-radio-button>
              </el-radio-group>
            </div>
          </div>
          <div class="table">
            <div v-if="top10times.length" style="height: 100%">
              <div
                class="left-top-list"
                v-for="(i, index) in top10times"
                :style="{ background: (index + 1) % 2 == 0 ? '' : '#f7f7f7' }"
              >
                <div class="item-wrap">
                  <span
                    class="table-index-dot"
                    :class="{ 'dot-other': index + 1 > 3 }"
                  >
                    {{ index + 1 }}
                    <svg
                      v-if="index + 1 == 1"
                      style="fill: #ffe500; overflow: hidden"
                      viewBox="0 0 1191 1024"
                      version="1.1"
                      xmlns="http://www.w3.org/2000/svg"
                      p-id="4787"
                    >
                      <path
                        d="M26.065 297.89l3.724-11.17c11.171-37.236 52.131-59.578 93.091-48.407 18.618 7.447 33.513 18.618 40.96 37.236 14.895 26.066 11.17 59.578-7.447 81.92-3.724 0-3.724 3.724-7.448 7.447 55.855 33.513 107.986 67.026 160.117 96.815 18.618 11.17 40.96 26.065 59.578 37.236 7.447 7.448 18.618 3.724 22.342-3.723l3.723-3.724c63.302-111.71 122.88-223.418 186.182-338.85-26.065-11.172-44.683-37.237-44.683-67.026 0-22.342 7.447-40.96 22.341-55.855 29.79-29.789 74.473-26.065 104.262 0l3.724 3.724c29.789 37.236 18.618 81.92-29.79 115.432 14.895 29.79 29.79 59.579 48.408 85.644 44.684 81.92 89.367 163.84 134.051 242.036 11.17 18.619 18.618 22.342 33.513 11.171 70.749-40.96 137.774-85.643 208.523-126.603l11.171-7.448c-14.894-11.17-22.342-29.789-26.065-48.407-3.724-40.96 29.789-74.473 67.025-78.196 33.513-3.724 63.302 18.618 74.473 52.13 0 11.172 3.724 14.895 3.724 18.619v26.065c-11.171 37.237-37.237 59.579-78.197 59.579 0 3.723-3.723 7.447-3.723 14.894l-122.88 417.047c-3.724 18.619-11.171 22.342-29.79 22.342h-696.32c-18.618 0-26.065-3.723-29.789-22.342-33.512-111.709-67.025-223.418-96.814-338.85-7.447-29.79-18.618-59.579-26.066-93.091-29.789 0-55.854-14.895-70.749-37.237-3.723-11.17-7.447-14.894-11.17-22.342v-26.065z m584.611 610.677h327.68c29.79 0 55.855 22.342 55.855 52.131 0 26.066-18.618 52.131-44.684 55.855h-666.53c-22.342 0-44.684-14.895-52.132-37.237-7.447-22.341 0-48.407 18.619-59.578 11.17-7.447 22.341-11.17 37.236-11.17 107.985-3.724 215.97 0 323.956 0zM610.676 14.895c11.171 0 33.513 3.723 52.131 22.341l3.724 3.724c29.789 37.236 18.618 81.92-29.79 115.433 14.895 29.789 29.79 59.578 48.408 85.643 44.684 81.92 89.367 163.84 134.051 242.037 11.17 18.618 18.618 22.342 33.513 11.17 70.749-40.96 137.774-85.643 208.523-126.603l11.171-7.447c-14.894-11.171-22.342-29.79-26.065-48.408-3.724-40.96 29.789-74.472 67.025-78.196 33.513-3.724 63.302 18.618 74.473 52.131 0 3.724 3.724 7.447 3.724 11.17v26.066c-11.171 37.237-37.237 59.579-78.197 59.579 0 3.723-3.723 7.447-3.723 14.894l-122.88 417.047c-3.724 18.619-11.171 22.342-29.79 22.342H610.677V14.895z m0 893.672h327.68c29.79 0 55.855 22.342 55.855 52.131 0 26.066-18.618 52.131-44.684 55.855H614.4"
                        p-id="4788"
                      ></path>
                    </svg>
                    <svg
                      v-if="index + 1 == 2"
                      style="fill: #ccc; overflow: hidden"
                      viewBox="0 0 1191 1024"
                      version="1.1"
                      xmlns="http://www.w3.org/2000/svg"
                      p-id="4787"
                    >
                      <path
                        d="M26.065 297.89l3.724-11.17c11.171-37.236 52.131-59.578 93.091-48.407 18.618 7.447 33.513 18.618 40.96 37.236 14.895 26.066 11.17 59.578-7.447 81.92-3.724 0-3.724 3.724-7.448 7.447 55.855 33.513 107.986 67.026 160.117 96.815 18.618 11.17 40.96 26.065 59.578 37.236 7.447 7.448 18.618 3.724 22.342-3.723l3.723-3.724c63.302-111.71 122.88-223.418 186.182-338.85-26.065-11.172-44.683-37.237-44.683-67.026 0-22.342 7.447-40.96 22.341-55.855 29.79-29.789 74.473-26.065 104.262 0l3.724 3.724c29.789 37.236 18.618 81.92-29.79 115.432 14.895 29.79 29.79 59.579 48.408 85.644 44.684 81.92 89.367 163.84 134.051 242.036 11.17 18.619 18.618 22.342 33.513 11.171 70.749-40.96 137.774-85.643 208.523-126.603l11.171-7.448c-14.894-11.17-22.342-29.789-26.065-48.407-3.724-40.96 29.789-74.473 67.025-78.196 33.513-3.724 63.302 18.618 74.473 52.13 0 11.172 3.724 14.895 3.724 18.619v26.065c-11.171 37.237-37.237 59.579-78.197 59.579 0 3.723-3.723 7.447-3.723 14.894l-122.88 417.047c-3.724 18.619-11.171 22.342-29.79 22.342h-696.32c-18.618 0-26.065-3.723-29.789-22.342-33.512-111.709-67.025-223.418-96.814-338.85-7.447-29.79-18.618-59.579-26.066-93.091-29.789 0-55.854-14.895-70.749-37.237-3.723-11.17-7.447-14.894-11.17-22.342v-26.065z m584.611 610.677h327.68c29.79 0 55.855 22.342 55.855 52.131 0 26.066-18.618 52.131-44.684 55.855h-666.53c-22.342 0-44.684-14.895-52.132-37.237-7.447-22.341 0-48.407 18.619-59.578 11.17-7.447 22.341-11.17 37.236-11.17 107.985-3.724 215.97 0 323.956 0zM610.676 14.895c11.171 0 33.513 3.723 52.131 22.341l3.724 3.724c29.789 37.236 18.618 81.92-29.79 115.433 14.895 29.789 29.79 59.578 48.408 85.643 44.684 81.92 89.367 163.84 134.051 242.037 11.17 18.618 18.618 22.342 33.513 11.17 70.749-40.96 137.774-85.643 208.523-126.603l11.171-7.447c-14.894-11.171-22.342-29.79-26.065-48.408-3.724-40.96 29.789-74.472 67.025-78.196 33.513-3.724 63.302 18.618 74.473 52.131 0 3.724 3.724 7.447 3.724 11.17v26.066c-11.171 37.237-37.237 59.579-78.197 59.579 0 3.723-3.723 7.447-3.723 14.894l-122.88 417.047c-3.724 18.619-11.171 22.342-29.79 22.342H610.677V14.895z m0 893.672h327.68c29.79 0 55.855 22.342 55.855 52.131 0 26.066-18.618 52.131-44.684 55.855H614.4"
                        p-id="4788"
                      ></path>
                    </svg>
                    <svg
                      v-if="index + 1 == 3"
                      style="fill: #ffb343; overflow: hidden"
                      viewBox="0 0 1191 1024"
                      version="1.1"
                      xmlns="http://www.w3.org/2000/svg"
                      p-id="4787"
                    >
                      <path
                        d="M26.065 297.89l3.724-11.17c11.171-37.236 52.131-59.578 93.091-48.407 18.618 7.447 33.513 18.618 40.96 37.236 14.895 26.066 11.17 59.578-7.447 81.92-3.724 0-3.724 3.724-7.448 7.447 55.855 33.513 107.986 67.026 160.117 96.815 18.618 11.17 40.96 26.065 59.578 37.236 7.447 7.448 18.618 3.724 22.342-3.723l3.723-3.724c63.302-111.71 122.88-223.418 186.182-338.85-26.065-11.172-44.683-37.237-44.683-67.026 0-22.342 7.447-40.96 22.341-55.855 29.79-29.789 74.473-26.065 104.262 0l3.724 3.724c29.789 37.236 18.618 81.92-29.79 115.432 14.895 29.79 29.79 59.579 48.408 85.644 44.684 81.92 89.367 163.84 134.051 242.036 11.17 18.619 18.618 22.342 33.513 11.171 70.749-40.96 137.774-85.643 208.523-126.603l11.171-7.448c-14.894-11.17-22.342-29.789-26.065-48.407-3.724-40.96 29.789-74.473 67.025-78.196 33.513-3.724 63.302 18.618 74.473 52.13 0 11.172 3.724 14.895 3.724 18.619v26.065c-11.171 37.237-37.237 59.579-78.197 59.579 0 3.723-3.723 7.447-3.723 14.894l-122.88 417.047c-3.724 18.619-11.171 22.342-29.79 22.342h-696.32c-18.618 0-26.065-3.723-29.789-22.342-33.512-111.709-67.025-223.418-96.814-338.85-7.447-29.79-18.618-59.579-26.066-93.091-29.789 0-55.854-14.895-70.749-37.237-3.723-11.17-7.447-14.894-11.17-22.342v-26.065z m584.611 610.677h327.68c29.79 0 55.855 22.342 55.855 52.131 0 26.066-18.618 52.131-44.684 55.855h-666.53c-22.342 0-44.684-14.895-52.132-37.237-7.447-22.341 0-48.407 18.619-59.578 11.17-7.447 22.341-11.17 37.236-11.17 107.985-3.724 215.97 0 323.956 0zM610.676 14.895c11.171 0 33.513 3.723 52.131 22.341l3.724 3.724c29.789 37.236 18.618 81.92-29.79 115.433 14.895 29.789 29.79 59.578 48.408 85.643 44.684 81.92 89.367 163.84 134.051 242.037 11.17 18.618 18.618 22.342 33.513 11.17 70.749-40.96 137.774-85.643 208.523-126.603l11.171-7.447c-14.894-11.171-22.342-29.79-26.065-48.408-3.724-40.96 29.789-74.472 67.025-78.196 33.513-3.724 63.302 18.618 74.473 52.131 0 3.724 3.724 7.447 3.724 11.17v26.066c-11.171 37.237-37.237 59.579-78.197 59.579 0 3.723-3.723 7.447-3.723 14.894l-122.88 417.047c-3.724 18.619-11.171 22.342-29.79 22.342H610.677V14.895z m0 893.672h327.68c29.79 0 55.855 22.342 55.855 52.131 0 26.066-18.618 52.131-44.684 55.855H614.4"
                        p-id="4788"
                      ></path>
                    </svg>
                  </span>
                </div>
                <div class="item-wrap">
                  <span class="name" v-if="i.remarkName">{{
                    i.remarkName
                  }}</span>
                  <span class="name" v-else>{{
                    i.name ? i.name : i.viceAccount
                  }}</span>
                </div>
                <div class="item-wrap">
                  <span
                    @click="
                      getDealDetail({
                        bankCardId: i.bankCardId,
                        title: i.name,
                        name: i.viceAccount || i.name,
                        contactId: i.contactId,
                        time: true,
                      })
                    "
                    class="times"
                    >{{ radio == "次数" ? i.total : i.totalPrice }} 次</span
                  >
                </div>
              </div>
            </div>
            <div class="left-top-empty" v-if="top10times.length == 0">
              <Empty></Empty>
            </div>
          </div>
        </div>
        <div class="div2">
          <div class="left-top-title-wrap">
            <div class="title">单次交易金额 TOP10</div>
          </div>
          <div id="left-bottom"></div>
          <div id="left-Empty" v-if="onceTop10.length == 0">
            <Empty></Empty>
          </div>
        </div>
      </div>
      <div class="finance-right">
        <div class="header">
          <div class="cards-wrap">
            <div class="cards-title">
              <el-tag type="success"
                ><i class="el-icon-bottom-left"></i> 总收入:
                <span v-if="totalIncome !== 0"
                  >{{ totalIncome.toFixed(2) }} 元</span
                >
                <i v-else class="el-icon-loading"></i>
              </el-tag>
              <el-tag type="" style="margin-left: 10px"
                ><i class="el-icon-top-right"></i> 总支出:
                <span v-if="totalExpend !== ''"
                  >{{ totalExpend.toFixed(2) }} 元</span
                >
                <i v-else class="el-icon-loading"></i>
              </el-tag>
            </div>
            <el-carousel
              type="card"
              height="180px"
              :autoplay="false"
              @change="changeCarousel"
              indicator-position="none"
              v-if="cardData.length > 0"
            >
              <el-carousel-item
                v-for="item in cardData"
                :key="item.bank_card_id"
              >
                <div class="bank-card">
                  <div class="bank-name">{{ item.bankName }}</div>
                  <div class="bank-number">
                    <template v-if="item.contactId">
                      {{ item.sysAccount ? item.sysAccount : item.contactId }}
                    </template>
                    <template v-else>
                      {{
                        item.cardNum
                          ? item.cardNum.length == 4
                            ? `**** **** **** *${item.cardNum}`
                            : item.cardNum
                          : "未知"
                      }}
                    </template>
                  </div>
                  <div class="card-info">
                    <div class="name" :title="item.suspectName">
                      <i class="el-icon-user"></i> {{ item.suspectName }}
                    </div>
                    <div class="">
                      <i class="el-icon-bottom-left"></i> 收入{{
                        item.nooutFlow
                      }}条 {{ item.nooutFlowPrice }}
                    </div>
                    <div class="">
                      <i class="el-icon-top-right"></i> 支出{{ item.outflow }}条
                      {{ item.outFlowPrice }}
                    </div>
                    <div class="" @click="isBillsChart = true">
                      <i class="el-icon-data-analysis"></i> 统 计
                    </div>
                  </div>
                </div>
              </el-carousel-item>
            </el-carousel>
            <div v-else style="width: 100%; height: 100%">
              <Empty style="margin-top: 40px"></Empty>
            </div>
          </div>
        </div>
        <div class="activeCardData">
          <div class="detail-title">
            <div class="title-bankname">
              {{ activeNum.bankName }}
              <span v-if="!activeNum.contactId">
                ({{ activeNum.cardNum || "未知" }})</span
              >
            </div>
            <div class="title-overlook">
              <i class="el-icon-bottom-left"></i> 收入 {{ activeNum.nooutFlowPrice }};
              <i class="el-icon-top-right"></i> 支出 {{ activeNum.outFlowPrice }};
            </div>
          </div>
          <div class="detail-filter">
            <template v-if="!isBillsChart">
              <div style="display: flex; justify-content: space-between; width: 100%;align-items: center;">
                <div style="display: flex; align-items: center">
                  <el-input
                    :disabled="cardData.length == 0"
                    style="width: 170px"
                    size="mini"
                    v-model="finance.req.filter"
                    clearable
                    @change="filtrate({ filter: finance.req.filter, page: 1 })"
                    placeholder="按交易对象、详情过滤"
                  ></el-input>
                  &nbsp;
                  <ElDatePicker
                    :changeDate="changeDate"
                    :size="'mini'"
                    :dateStyle="'width: 130px'"
                    ref="ElDatePickerssChart"
                  ></ElDatePicker>
                  <!-- <el-date-picker :disabled="cardData.length == 0" style="width: 210px" v-model="dateFilter" @change="changeDate" type="daterange" size="mini" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" value-format="yyyy-MM-dd"></el-date-picker> -->
                  &nbsp;

                  <el-input
                    :disabled="cardData.length == 0"
                    style="width: 100px"
                    size="mini"
                    v-model="finance.req.min"
                    clearable
                    @change="filtrate({ min: finance.req.min, page: 1 })"
                    placeholder="最小金额"
                  ></el-input>
                  <span style="font-weight: 700; margin: 0px 5px">-</span>
                  <el-input
                    :disabled="cardData.length == 0"
                    style="width: 100px"
                    size="mini"
                    v-model="finance.req.max"
                    clearable
                    @change="filtrate({ max: finance.req.max, page: 1 })"
                    placeholder="最大金额"
                  ></el-input>
                  &nbsp;
                  <el-select
                    :disabled="cardData.length == 0"
                    style="width: 120px"
                    clearable
                    v-model="finance.req.dealType"
                    @change="filtrate({ dealType: finance.req.dealType })"
                    size="mini"
                    placeholder="按类型过滤"
                  >
                    <el-option label="全部" :value="0"></el-option>
                    <el-option label="支出" :value="1"></el-option>
                    <el-option label="收入" :value="2"></el-option>
                  </el-select>
                </div>
                <!-- <div>
                  <el-switch
                    class="btn-switch"
                    v-model="isBillsChart"
                    active-text="统计"
                    inactive-text="账单"
                    :disabled="cardData.length == 0"
                  ></el-switch>
                </div> -->
              </div>
            </template>
            <template v-else>
              <el-radio-group
                :disabled="cardData.length == 0"
                style="margin-top: 5px"
                v-model="timeType"
                @change="getBillsChart({ timeType: timeType })"
              >
                <el-radio label="day">日</el-radio>
                <el-radio label="week">周</el-radio>
                <el-radio label="month">月</el-radio>
                <el-radio label="year">年</el-radio>
              </el-radio-group>
              <el-switch
                class="btn-switch"
                v-model="isBillsChart"
                active-text="统计"
                inactive-text="账单"
                :disabled="cardData.length == 0"
              ></el-switch>
            </template>
          </div>
          <el-table
            v-if="!isBillsChart"
            :data="filterList"
            border
            height="430"
            v-loading="particularsLoading"
          >
            <el-table-column label=" " type="index"></el-table-column>
            <el-table-column
              label="金额(元)"
              prop="money"
              width="120"
            ></el-table-column>
            <el-table-column label="类型" width="70">
              <template slot-scope="scope">
                <el-tag size="small" v-if="scope.row.outFlow">支出</el-tag>
                <el-tag size="small" type="success" v-else>收入</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="日期" prop="date" width="160">
              <template slot-scope="scope">
                {{ filterTime(scope.row.date) }}
              </template>
            </el-table-column>
            <el-table-column label="详情" prop="content">
              <template slot-scope="scope">
                {{ scope.row.content.processLabel() }}
              </template>
            </el-table-column>
            <!-- <el-table-column label="交易来源" width="200">
              <template slot-scope="scope">
                {{
                  scope.row.bankcard
                    ? `${scope.row.bankcard.bankName}(${
                        scope.row.bankcard.sys_account
                          ? scope.row.bankcard.sys_account
                          : scope.row.bankcard.cardNum
                      })`
                    : ""
                }}
              </template>
            </el-table-column> -->
            <el-table-column label="交易对象" prop="viceAccount" width="130">
              <template slot-scope="scope">
                {{ scope.row.viceAccount ? scope.row.viceAccount : "未知" }}
              </template>
            </el-table-column>
          </el-table>
          <div class="page" v-if="!isBillsChart">
            <el-pagination
              background
              layout="prev, pager, total, next, jumper"
              :current-page="finance.req.page"
              @current-change="changepage"
              :pageSize="finance.req.pageSize"
              :total="particularsTotal"
            >
            </el-pagination>
          </div>
          <div id="bills-chart" :style="{visibility: isBillsChart ? 'visible' : ''}"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { loadScript, formatDate } from "../../util/util";
import { Loading } from "element-ui";
import * as echarts from "echarts";
import Empty from "./comp/Empty.vue";
import ElDatePicker from "./comp/ElDatePicker.vue";
// 处理红包转账
function handlePayment(content) {
  if (content.startsWith("<?xml") || content.startsWith("<msg")) {
    return {
      money: getTagContent(content, "feedesc")
        .replace(/\<\!\[CDATA\[/g, "")
        .replace(/]]/g, "")
        .replace(/\>/g, ""),
      moneyType: getTagContent(content, "paysubtype"),
    };
  } else if (content.includes("{")) {
    return {
      money: JSON.parse(content).des,
    };
  } else {
    return {
      money: content,
    };
  }
}
export default {
  name: "Finance",
  data() {
    return {
      formType: false, // 关系表格type
      dealType: false, // 交易金额type
      radio: "次数", // 次数type
      top10times: [], // 交易top10数组
      onceTop10: [], // 单次交易金额top10
      cardData: [], // 交易卡片数据
      totalIncome: 0,
      totalExpend: 0,
      activeNum: {}, // 当前选中卡片
      isBillsChart: false,
      finance: {
        income: 0,
        outflow: 0,
        req: {
          page: 1,
          pageSize: 20,
          phoneId: "",
          bankCardId: "",
          dateTimeFrom: "",
          dateTimeTo: "",
          filter: "",
          max: "",
          min: "",
          contactId: "",
          dealType: 0,
        },
      },
      particularsLoading: false, // 卡片详情数据loading
      particularsList: [], // 卡片详情过滤数据
      filterList: [], // 过滤后的数据
      particularsTotal: 0, // 总数
      timeType: 'day',
    };
  },
  components: {
    Empty,
    ElDatePicker,
  },
  methods: {
    getLeftButtom() {
      // 绘制交易top10
      loadScript(
        "./static/data/senior_function/finance/top10ofeach.js",
        () => {
          let data = [];
          function setName(name) {
            if (name == null) {
              return " ";
            } else if (name.toString().length > 5) {
              return `(${name.substr(0, 5)}...)`;
            } else {
              return `(${name})`;
            }
          }
          this.onceTop10 = window.globalJSData["finance"]["top10ofeach"];
          this.onceTop10.forEach((i) => {
            data.push({
              value: i.money,
              name: setName(
                i.name || i.viceRemark || i.viceNickname || i.viceAccount
              ),
              oriData: i,
            });
          });
          let max = data.length > 0 ? data[0].value * 1.7 : 0;
          let option = {
            title: {
              text: "单次交易金额 TOP10",
              top: 10,
              left: 10,

              textStyle: {
                fontSize: 14,
                fontWeight: "bold",
              },
            },
            tooltip: {
              trigger: "axis",
              axisPointer: {
                type: "shadow",
              },
              position: "top",
              formatter: function (a) {
                let p = a[0];
                if (handlePayment(p.data.oriData.content).moneyType == "1") {
                  return `交易对象: ${
                    p.data.oriData.viceRemark ||
                    p.data.oriData.viceNickname ||
                    p.data.oriData.viceAccount ||
                    "未知"
                  }<br/>交易内容: 向您转账${
                    handlePayment(p.data.oriData.content).money
                  }<br/>交易金额: ${p.data.oriData.money}元<br/>交易日期: ${
                    p.data.oriData.date
                  }<br/>交易来源: ${
                    p.data.oriData.bankcard
                      ? `${p.data.oriData.bankcard.bankName}`
                      : ""
                  }`; // (${p.data.oriData.bankcard.sys_account ? p.data.oriData.bankcard.sys_account :p.data.oriData.bankcard.cardNum})
                } else if (
                  handlePayment(p.data.oriData.content).moneyType == "3"
                ) {
                  return `交易对象: ${
                    p.data.oriData.viceRemark ||
                    p.data.oriData.viceNickname ||
                    p.data.oriData.viceAccount ||
                    "未知"
                  }<br/>交易内容: 已收款${
                    handlePayment(p.data.oriData.content).money
                  }<br/>交易金额: ${p.data.oriData.money}元<br/>交易日期: ${
                    p.data.oriData.date
                  }<br/>交易来源: ${
                    p.data.oriData.bankcard
                      ? `${p.data.oriData.bankcard.bankName}`
                      : ""
                  }`; // (${p.data.oriData.bankcard.sys_account ? p.data.oriData.bankcard.sys_account :p.data.oriData.bankcard.cardNum})
                } else {
                  return `交易对象: ${
                    p.data.oriData.viceRemark ||
                    p.data.oriData.viceNickname ||
                    p.data.oriData.viceAccount ||
                    "未知"
                  }<br/>交易内容: ${
                    handlePayment(p.data.oriData.content).money
                  }<br/>交易金额: ${p.data.oriData.money}元<br/>交易日期: ${
                    p.data.oriData.date
                  }<br/>交易来源: ${
                    p.data.oriData.bankcard
                      ? `${p.data.oriData.bankcard.bankName}`
                      : ""
                  }`; // (${p.data.oriData.bankcard.sys_account ? p.data.oriData.bankcard.sys_account :p.data.oriData.bankcard.cardNum})
                }

                // return `交易对象: ${p.data.oriData.viceAccount || '未知'}<br/>交易内容: ${p.data.oriData.content.trim()}<br/>交易金额: ${p.data.oriData.money}元<br/>交易日期: ${p.data.oriData.date}`
              },
              extraCssText: `width: ${
                document.getElementById("left-bottom").offsetWidth / 2 - 40
              }px;white-space: normal`,
            },
            xAxis: [
              {
                max: max,
                splitLine: { show: false },
                axisLabel: { show: false },
                name: "金额(元)",
                nameTextStyle: {
                  padding: [-30, 0, 0, -45],
                },
              },
            ],
            yAxis: [
              {
                type: "category",
                gridIndex: 0,
                axisLabel: { show: false },
                data: JSON.parse(JSON.stringify(data)).map((i) => i.name),
              },
            ],
            grid: { top: 40, right: 20, bottom: 20, left: 20 },
            series: [
              {
                type: "bar",
                label: {
                  show: true,
                  position: "right",
                  fontWeight: "bold",
                  formatter: "{c} 元 {money|{b}}",
                  rich: {
                    money: {
                      color: "#333",
                    },
                  },
                },
                data: data.sort((a, b) => a.value - b.value),
                itemStyle: {
                  color: "#459FFC",
                  barBorderRadius: [0, 10, 10, 0],
                  opacity: 0.9,
                },
                barWidth: "60%",
              },
            ],
          };
          if (data.length > 0) {
            let mychart = echarts.init(document.getElementById("left-bottom"));
            mychart.setOption(option);
          }
        }
      );
    },
    filterTime(items) {
      let item = new Date(items);
      const Y = item.getFullYear(); // 年
      const M =
        item.getMonth() + 1 < 10
          ? "0" + (item.getMonth() + 1)
          : item.getMonth() + 1; //月
      const D = item.getDate() < 10 ? "0" + item.getDate() : item.getDate(); //日
      const HH = item.getHours() < 10 ? "0" + item.getHours() : item.getHours(); //时
      const MM =
        item.getMinutes() < 10 ? "0" + item.getMinutes() : item.getMinutes(); //分
      return `${Y}-${M}-${D} ${HH}:${MM}`;
    },
    changeDate(date) {
      if (date) {
        this.finance.req.dateTimeFrom = date[0];
        this.finance.req.dateTimeTo = date[1];
      } else {
        this.finance.req.dateTimeFrom = "";
        this.finance.req.dateTimeTo = "";
      }
      this.filtrate({page: 1});
    },
    getCardData() {
      this.totalIncome = 0;
      this.totalExpend = 0;
      // 获取卡片数据
      loadScript(
        "./static/data/senior_function/finance/bankcardInfo.js",
        () => {
          this.cardData = window.globalJSData["dig"]["bankcardInfo"];
          this.cardData.forEach((i) => {
            // 总收入支出
            this.totalIncome += i.inNumber * 1;
            this.totalExpend += i.outNumber * 1;
            this.activeNum = this.cardData[0];
          });
        }
      );
    },
    changepage(page) {
      this.filtrate({page: page})
    },
    filtrate(req) {
      this.particularsLoading = true;
      let _this = this;
      this.finance.req = Object.assign(this.finance.req, req);
      let data = [];
      if (_this.finance.req.filter) {
        data = this.particularsList.filter(function (item) {
          if (!item.viceAccount) {
            item.viceAccount = "未知";
          }
          if (
            item.viceAccount.indexOf(_this.finance.req.filter) != -1 ||
            item.content.indexOf(_this.finance.req.filter) != -1
          ) {
            return item;
          }
        });
      } else {
        data = _this.particularsList;
      }
      if (_this.finance.req.dateTimeFrom && _this.finance.req.dateTimeTo) {
        let dateTimeFrom = new Date(_this.finance.req.dateTimeFrom).getTime();
        let dateTimeTo = new Date(_this.finance.req.dateTimeTo).getTime();
        console.log(data, dateTimeFrom, dateTimeTo);
        data = data.filter(function (item) {
          if (item.date > dateTimeFrom && item.date < dateTimeTo) {
            return item;
          }
        });
      } else {
        data = data;
      }
      if (_this.finance.req.min) {
        data = data.filter(function (item) {
          if (item.money >= _this.finance.req.min) {
            return item;
          }
        });
      } else {
        data = data;
      }
      if (_this.finance.req.max) {
        data = data.filter(function (item) {
          if (item.money <= _this.finance.req.max) {
            return item;
          }
        });
      } else {
        data = data;
      }
      if (_this.finance.req.min) {
        data = data.filter(function (item) {
          if (item.money >= _this.finance.req.min) {
            return item;
          }
        });
      } else {
        data = data;
      }
      if (_this.finance.req.dealType == 1) {
        data = data.filter(function (item) {
          if (item.outFlow) {
            return item;
          }
        });
      } else if (_this.finance.req.dealType == 2) {
        data = data.filter(function (item) {
          if (!item.outFlow) {
            return item;
          }
        });
      } else {
        data = data;
      }
      data = data.filter(function (item, index) {
        let num = _this.finance.req.page * _this.finance.req.pageSize;
        if (index < num && index >= (_this.finance.req.page - 1) * _this.finance.req.pageSize) {
          return item;
        }
      });
      this.filterList = data;
      this.particularsLoading = false;
    },
    changeCarousel(item) {
      this.activeNum = this.cardData[item];
      this.getParticularsList();
    },
    getParticularsList() {
      // 获取表格数据
      loadScript("./static/data/senior_function/finance/deal.js", () => {
        this.particularsList =
          window.globalJSData["finance"]["deal"][
            this.activeNum.bankName + "_" + this.activeNum.bank_card_id
          ];
        this.particularsTotal = this.particularsList.length;
        this.filtrate({ page: 1 });
      });
    },
    changeTypeBtnTop10() {
      if (this.radio == "次数") {
        loadScript(
          "./static/data/senior_function/finance/top10oftimes.js",
          () => {
            this.top10times = window.globalJSData["finance"]["top10oftimes"];
          }
        );
      } else {
        loadScript(
          "./static/data/senior_function/finance/top10ofamount.js",
          () => {
            this.top10times = window.globalJSData["finance"]["top10ofamount"];
          }
        );
      }
    },
  },
  mounted() {
    loadScript(
      "./static/data/senior_function/finance/top10oftimes.js",
      () => {
        this.top10times = window.globalJSData["finance"]["top10oftimes"];
      }
    );
    this.getLeftButtom();
    this.getCardData();
    this.getParticularsList();
  },
};
</script>

<style lang="scss" scoped>
#finance {
  width: 100%;
  height: 100%;
  padding: 10px 40px;
  box-sizing: border-box;
  .header {
    width: 100%;
    height: 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
  }
  .content {
    margin-top: 20px;
    height: calc(100% - 60px);
    display: flex;
    justify-content: space-between;
    align-items: center;
    .finance-left {
      height: 100%;
      width: 30%;
      display: grid;
      grid-template-columns: 1fr;
      grid-template-rows: repeat(2, 1fr);
      grid-column-gap: 0px;
      grid-row-gap: 20px;
      .div1 {
        grid-area: 1 / 1 / 2 / 2;
        border-radius: 10px;
        border: 1px solid silver;
        padding: 10px 10px;
        .left-top-title-wrap {
          height: 28px;
          display: flex;
          justify-content: space-between;
          align-items: center;
        }
        .table {
          box-sizing: border-box;
          margin-top: 10px;
          height: calc(100% - 28px);
          .left-top-list {
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            /*border-bottom: 1px solid #f7f7f7;*/
            font-size: 13px;
            height: 10%;

            /*padding: 8px 0;*/

            .item-wrap {
              width: 33%;
              height: 100%;

              position: relative;

              span {
                display: inline-block;
                height: 18px;
                width: 100%;
                text-align: center;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -9px);

                &.name {
                  text-overflow: ellipsis;
                  white-space: nowrap;
                  overflow: hidden;
                }
                &.times {
                  cursor: pointer;
                  text-decoration: underline;
                }
              }

              .table-index-dot {
                display: inline-block;
                width: 18px;
                height: 18px;
                border-radius: 9px;
                text-align: center;
                color: #fff;
                font-size: 12px !important;
                font-weight: bold;
                line-height: 18px;

                svg {
                  display: inline-block;
                  width: 26px;
                  height: 26px;
                  font-size: 26px;

                  position: absolute;
                  top: 50%;
                  left: 50%;
                  z-index: -1;
                  margin-top: -15px;
                  margin-left: -13px;
                }

                &.dot-other {
                  background: #ccc;
                }
              }
            }
          }
        }
      }
      .div2 {
        border-radius: 10px;
        border: 1px solid silver;
        padding: 10px 10px;
        grid-area: 2 / 1 / 3 / 2;
        position: relative;
        .left-top-title-wrap {
          height: 28px;
          display: flex;
          justify-content: space-between;
          align-items: center;
        }
        #left-bottom {
          box-sizing: border-box;
          margin-top: 10px;
          height: calc(100% - 38px);
        }
        #left-Empty {
          width: 100%;
          height: calc(100% - 38px);
          position: absolute;
          bottom: 0px;
          left: 0px;
        }
      }
    }
    .finance-right {
      box-sizing: border-box;
      width: 69%;
      height: 100%;
      padding: 10px;
      border-radius: 10px;
      border: 1px solid silver;
      .header {
        width: 100%;
        height: 240px;
        .cards-wrap {
          width: 100%;
          height: 100%;
          margin: 0 auto;

          .cards-title {
            height: 40px;
            line-height: 50px;
            margin-left: 20px;
            margin-bottom: 10px;

            font-size: 20px;
            font-weight: bold;
          }

          .bank-card {
            width: 480px;
            height: 180px;
            border-radius: 8px;

            background: #607d8b;

            color: #fff;

            margin: 0 auto;

            .bank-name {
              font-size: 24px;
              font-weight: bold;
              line-height: 2.5em;
              padding: 0 20px;

              border-bottom: 10px solid #fff;
            }

            .bank-number {
              font-size: 28px;
              font-weight: bold;
              margin-top: 24px;
              padding: 0 20px;

              overflow: hidden;
              white-space: nowrap;
              text-overflow: ellipsis;
            }

            .card-info {
              font-size: 12px;
              line-height: 2em;
              font-weight: bold;
              padding: 0 20px;
              margin-top: 15px;

              display: flex;
              justify-content: space-between;
            }
          }
        }
      }
      .activeCardData {
        box-sizing: border-box;
        width: 100%;
        height: calc(100% - 240px);
        .detail-title {
          .title-bankname {
            font-size: 24px;
            font-weight: bold;
            display: inline-block;

            span {
              display: inline-block;
              /*width: 70px;*/
              font-size: 18px;
              font-weight: bold;
            }
          }

          .title-overlook {
            font-size: 12px;
            display: inline-block;
            margin-right: 10px;
            /*width: 280px;*/
          }
        }
        #bills-chart {
          width: 100%;
          height: 480px;
        }
        .detail-filter {
          height: 28px;
          display: flex;
          align-items: center;
          justify-content: space-between;
        }
        .page {
          display: flex;
          justify-content: space-around;
          align-items: center;
          margin-top: 10px;
        }
      }
    }
  }
}
</style>
