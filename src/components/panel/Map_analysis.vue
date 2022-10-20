<template>
  <div id="Map_analysis">
    <div class="header">
      <div>地理分析：</div>
    </div>
    <div id="map-analysis-chart"></div>
    <div
      :style="showPanel ? ' z-index: 10;' : ' z-index: -1;'"
      id="map-analysis-details"
    ></div>
    <div class="btn">
      <el-button
        v-show="showPanel"
        class="map-btn-back"
        size="small"
        @click="showPanel = false"
        >返 回</el-button
      >
    </div>
    <div class="checkout">
      <el-checkbox-group
        class="map-switch behavior-filter"
        v-model="chartType"
        size="small"
        @change="changeMapType"
      >
        <el-checkbox class="checkbox" border label="favorite-point"
          ><img
            src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAA3tJREFUSEutVU1oXGUUPed7k0zSpEk7eTOJIVFsFKJd+JeGMhFKFeNPoVIogbrUhV2J1GIpiq2ClaIWhW7EhUVwE7RQl3ERDOTXcSHS2lJ/01gn85PpJDHTduZ9R940qfmdGaoX3uJ9795z3j333u8SFZgETo2iho7bbvOYb8+nEtyNQgWhYCVOly8juCkTeiwg5wypb8X8e5Gu7B8kvHLxFRHEh5sjcryDhjhGIGug/TmvdrQ9OpX7Xwj+mghtNzL9AB5cBDwH4xxq3jH9638mSF50N3vXsMcQnwuo8gEJzHqenvpkIB07fhy2FElZiRIT4YdldQLEs8uBRH3mkCfDO1KX7phgJra18aYX2G+ojyXULQci8TfIV+ZY+KqjK5PdiOR2Brdasak1EEBrwLLeMzJGaJPMXsDuBRlYASIVCHNOtF+L+NOxtCDmRE5FupPxJV9Oj0V6/RcrOTR4hECXYFtIOgQaJLQBqF/3D4V5AlMymJXkUbhqHI5bmh+WpoSJcfeSwBCgagD+4xfSKdcdG3z35yJP4oaEHMGfmRgLH7XUPgKdJOokmDsEXwoT6WfEMScYfImDgwhsbwxHVdBrEHaRRVnKdleJomYFDMrz3mqJZn4sAqkfTmqb+5C1OkbxCW2kefnUFggMQd674cnMKPvg/dtFMVTNFEL352HeJ/Fceax1PYbk6Z080iPtURSvkRVSxGKousdz77XSURi+ABWLXokVrDBgC/Yj1tQMt3ZdXbjdpqujff3jY+4uGhwmsKcSdEHnCZ7OxPFF5/OpuRUDuR7A5HCkIxiwhwEcrJDgCqgPh36fOd3Xt/IKX9MtfgbJ78JPS/IJnqyEAFAewKlId/qN1TtiLUE/nOTdTa+LPATArYyg6HXqwkLqyO5Vm24NgT8XnZvckwbwCZbMv5LnAfxWbGuojeIWcNnEE5/O5Z037+uZTpSswZXzDaGq+eoTBF5edMyRmJR4AbRni2diD8DHJXWQqC2ekaMAP2juTtzyWbQ1GSQmws8AOiJhJ4BrJC5a8aw8O35XND3hx83GNrsL+eA+EAdIPABgC4CgqDMt3ekXSxJMT7hvQzgAIA7hG0kDP11Pf79a26KU9U2POjK9knoJbLPSly0706+WlmikIeRUO/UNhZs36uzWWZZZ7Bppq00GMo05BJtq8t715p7sL8sJ/gHdKHazIu32oQAAAABJRU5ErkJggg=="
            alt=""
          />
          收藏地点</el-checkbox
        >
        <el-checkbox class="checkbox" border label="favorite-route"
          ><img
            src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAA3tJREFUSEutVU1oXGUUPed7k0zSpEk7eTOJIVFsFKJd+JeGMhFKFeNPoVIogbrUhV2J1GIpiq2ClaIWhW7EhUVwE7RQl3ERDOTXcSHS2lJ/01gn85PpJDHTduZ9R940qfmdGaoX3uJ9795z3j333u8SFZgETo2iho7bbvOYb8+nEtyNQgWhYCVOly8juCkTeiwg5wypb8X8e5Gu7B8kvHLxFRHEh5sjcryDhjhGIGug/TmvdrQ9OpX7Xwj+mghtNzL9AB5cBDwH4xxq3jH9638mSF50N3vXsMcQnwuo8gEJzHqenvpkIB07fhy2FElZiRIT4YdldQLEs8uBRH3mkCfDO1KX7phgJra18aYX2G+ojyXULQci8TfIV+ZY+KqjK5PdiOR2Brdasak1EEBrwLLeMzJGaJPMXsDuBRlYASIVCHNOtF+L+NOxtCDmRE5FupPxJV9Oj0V6/RcrOTR4hECXYFtIOgQaJLQBqF/3D4V5AlMymJXkUbhqHI5bmh+WpoSJcfeSwBCgagD+4xfSKdcdG3z35yJP4oaEHMGfmRgLH7XUPgKdJOokmDsEXwoT6WfEMScYfImDgwhsbwxHVdBrEHaRRVnKdleJomYFDMrz3mqJZn4sAqkfTmqb+5C1OkbxCW2kefnUFggMQd674cnMKPvg/dtFMVTNFEL352HeJ/Fceax1PYbk6Z080iPtURSvkRVSxGKousdz77XSURi+ABWLXokVrDBgC/Yj1tQMt3ZdXbjdpqujff3jY+4uGhwmsKcSdEHnCZ7OxPFF5/OpuRUDuR7A5HCkIxiwhwEcrJDgCqgPh36fOd3Xt/IKX9MtfgbJ78JPS/IJnqyEAFAewKlId/qN1TtiLUE/nOTdTa+LPATArYyg6HXqwkLqyO5Vm24NgT8XnZvckwbwCZbMv5LnAfxWbGuojeIWcNnEE5/O5Z037+uZTpSswZXzDaGq+eoTBF5edMyRmJR4AbRni2diD8DHJXWQqC2ekaMAP2juTtzyWbQ1GSQmws8AOiJhJ4BrJC5a8aw8O35XND3hx83GNrsL+eA+EAdIPABgC4CgqDMt3ekXSxJMT7hvQzgAIA7hG0kDP11Pf79a26KU9U2POjK9knoJbLPSly0706+WlmikIeRUO/UNhZs36uzWWZZZ7Bppq00GMo05BJtq8t715p7sL8sJ/gHdKHazIu32oQAAAABJRU5ErkJggg=="
            alt=""
          />
          收藏路线</el-checkbox
        >
        <el-checkbox class="checkbox" border label="search-point"
          ><img
            src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAARdJREFUSEu1lbsRwjAMhmUKoKAhd7AAZBIoYQm6ZAnCEqRjCShhksACcBcaCkiBueRIEI7tyOfYrS190q+HGTg+jOJ/sEtG3ReEWQ+2j5V/o9iUb5QALz4fgfOZ0hljpzSYzptgUoC3TXiTYXmfhr5Whdolds5ZZ3kPJgcRNowvC8bfewrkD4CdN0WWO6e8rwBYc4rzMvoKoqjJD/DVXSWLqiZYLllgNYBJ9GIWSkDR50+45gY2gKwPY3FOigy8OFkDh8gWAAyiNPA3WM4C4DwD3HI2EpGK7K6L0O4xyYI8B9TJxAU0muTaZAIAdRfpus96m+KMtEUWV4HJf6CTqrUfTQUhAaifjwzSKkDWia0DxK3gBIAl/QB0k74Z7tDGtwAAAABJRU5ErkJggg=="
            alt=""
          />
          搜索地点</el-checkbox
        >
        <el-checkbox class="checkbox" border label="search-route"
          ><img
            src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAARdJREFUSEu1lbsRwjAMhmUKoKAhd7AAZBIoYQm6ZAnCEqRjCShhksACcBcaCkiBueRIEI7tyOfYrS190q+HGTg+jOJ/sEtG3ReEWQ+2j5V/o9iUb5QALz4fgfOZ0hljpzSYzptgUoC3TXiTYXmfhr5Whdolds5ZZ3kPJgcRNowvC8bfewrkD4CdN0WWO6e8rwBYc4rzMvoKoqjJD/DVXSWLqiZYLllgNYBJ9GIWSkDR50+45gY2gKwPY3FOigy8OFkDh8gWAAyiNPA3WM4C4DwD3HI2EpGK7K6L0O4xyYI8B9TJxAU0muTaZAIAdRfpus96m+KMtEUWV4HJf6CTqrUfTQUhAaifjwzSKkDWia0DxK3gBIAl/QB0k74Z7tDGtwAAAABJRU5ErkJggg=="
            alt=""
          />
          搜索路线</el-checkbox
        >
        <el-checkbox class="checkbox" border label="contact"
          ><img
            src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAMAAADXqc3KAAAAAXNSR0IB2cksfwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAJ9QTFRFAAAA2PTnVdGVSs6Ou+3Vv+7XMMd+pObG0fLi2/XpTs+RSM6NPsuH5vjv7vr0fdyujeC40PLiftyvPcuG4/ftoubFjuC5PMqGMsiA7Przwu/ZSc6OZdWfYtWdcNim3/brwO7YY9We5/nwrenMS86P6vnykOG62vXo3vbqQ8yKadahTc+Qwe7ZP8uHP8uIve3WgN2wUNCSQsyJVdGVzfLgPLHA4gAAADV0Uk5TAMPd5b+//8HBxOLn8HAMysXByvGVwcXy/Ca/5tTWz8W/1WXA5T/Ew8Xs0uO/7+6/yeHt3sGkiXRtAAAApElEQVR4nHXR2RKCMAwF0OByEVQUUNwF9333/79N2s44pU3z1N4z6aQTIvJq9QYx1URZvp23ICuwIFTQtqCjAF1HByITeirvW0/FMk+YcVMBAwaGAjIGaFTCeMLAVLTMuJa5kIXrMSwZyOGSQspKXaK1Jhsp21153APhwRRkQQJjPwUqpe30mOpw0kc4a3CpDHe9/cEz5vbvKn/YX4qfr/fnS/QDPB4JvwIdlswAAAAASUVORK5CYII="
            alt=""
          />
          联系人</el-checkbox
        >
        <!--            <el-checkbox border label="travel"><img src="../../assets/img/app/activity-travel.png" alt="">出行路线</el-checkbox>-->
        <el-checkbox class="checkbox" border label="photo"
          ><img
            src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAGLElEQVRIiYWWW2wU1xnHf3PZmdnrrNfr3XVt7DWtDWQNTgMlyME0NjFBlVqk3Izal77RiD7kvW+VKh55a0Vf+pCqxIRKDhAXqkZV4khQG6iDTTCXJrEdL6531+u92Hud2WqOMcFK1X7S0eicOef//+7nSI1Go8ETyefzU5lMxjJNs80wDJfzT5Ik/pc4xyVJkiqVSnVtbW0pHA67/H7/ga0jWwTVubm5yVgsdjifzztE1Ot1/h/4ljgQiqJgmiZ+v59UKjXR09PTDyiCYGZm5tNgMHg4mUpTtyy8uuYwPwWwbVuQybIs5pZlO7BP5zwhcZRyJBqNksvlJnp7ewekbDY7OT8//4PC+jrVe9No1TJqYj++cAv1ag1ddxEIBARYuVwSAIZhCBLH0lqtvo3IIalUKmJPPB6fUqempiy3x4PcsAhfHcWzkiR96lfYkRjNYS+VconLVy4xO3NXWOIYJssS+/p6OXp0CJ/fy2omh6JskqiqSq1Wo1AocOPGjYYyNDT0a6/X6zebWzCCTdjR76C++DKhcIiZmTv87rfniERiDAwcYe/efSQSCbq7e0guJRl97wKx1ijxrk7WiyVBvCXr6+skk0lblZ/Y16jXsA4OYh8cxG+o3Jm+zfvvj3H69Glu3rzJmTNnnAPieGtrK2+88TqnTp3i3Lnf89Ofwa5du8nniiLYWy6zbVtTRbScdJIkrEoZSZYo1IqMjV3h7bd/wdmzZxkf/wsuXQVLEptTqyvcvn2L48ePCwXe/eO7vPPOL4WbtnLDwXOGuj3dwOfRGR//iP7+lxgdvcDVq9cwgwG+15TgzRNv4XK7+PPYRe4m/8m1a38V1rzw/f18/PdPBGFhvbwtheVnJ05NVStlVlbSmGaAS5c+IGD6MY0wR5//IfHuFnZ0hnj1hUHCnhgBM8Dly1fweD0sfv01tVqZTRu/EfUbcCdANv9eWUHTNBYWFimXy6iKRiTYwkz6On/6zR+wbJvEd3uINoVZq2TEnuTSEpIkk0qtEDAj/53gCQ2FQlGkY6lUQlFUEbRSuUYyXyOVy4t/j/MF5A0NRZZRVUWQ2E5dFIqYwYjA2Uaw1RKc6CuySi63RmfnTnRdp9GwKZbXSVV3oHT/HEWV+dfyF0Tq88gK6IohiiqdXhEKOZaA9W0LNluSjC/gd8pc5HQkEmF1NQPWBjukLKVskgYK7sYqFbmIjEpzc7MAdazwev3f6l/bguxkrM9rEo3GuHXrFkNDQ+Kwrhk07Cy+2iz+6jQ00miKJtw3MHCY2dlZ2tt34PMFeKY5bxI4C5stYPPr0nT27HmO6elpstlVXhl+BW+Tj7adHRimH09zE+G2mFgbHBwknU7z6NFDUeWq6nqKtTVUl8uFrunC3y5VFXFwtOnre56xsQ84eOAAh/oPUSgWCbQEBYiua3i9Hu7N3efOZ9Oc+MkJuuI7BY7dsIVluqaJvqS6DbcUagoSaQmjuTThewdgaHBQaPPJ5Y+Y/NsEnbvimOEQyDbpbIa7j5LYssGbrw5x7Ngw8c4OXJpLaF2tVJ0+wePkY9R8Pm9VqzVs23KuH1Ftfr+Pvr692FID5eEGn1//mJWpKRa9IAehIMO6t4NE71F+/KNhehMJNN31NFnsRp1qteqkelk1DGMxu7bWFgoFcdzliGNiR0cH7qCP8oeLBK/PYfsylHsUtITC55Uyk8UuWvcd4aX+Q3gC5lZzE/dBqVQmm83i8XmT6vCxYdeF90YxA34UVcHtdgvfOSRt7W08F+nGTRiPLmN3ujD6ZaqrMLPUiq+9h3A4xEbVwrKcUWdjo0R6JcP9+w946+SIpoZCof2RaHRievqzgd17dtHcHELXDVGhqqVTrddwIRNQZFS3jBGUMJyLTXb6VoW1XI6NSl0QOLWQyWSZuzdHU6jp01AodFgU2muvv9Z//vz5iSsfjg/E43FxRTr9SPXqfLn8gFWyBKs2SqqO9kBmKQO1xynWlFn+MblGqbrp81w+x/xX8/T2JiZGTp58UXSJZ58ty8vLUxcvXrQWFhZijQZuRVco3c1U6l8t1Gulhx6pVZLUTokvSjW+zHfRYu7mSJdJzRKPglJ7e/vyyMiIGolENp8twH8AZFq/OTFJklEAAAAASUVORK5CYII="
            alt=""
          />拍摄行为</el-checkbox
        >
      </el-checkbox-group>
    </div>
  </div>
</template>

<script>
import { Loading } from "element-ui";
import {
  loadScript,
  formatFileSize,
  loadScriptAsync,
  toBase64,
} from "../../util/util";
import * as echarts from "echarts";
import china from "../../assets/map.china.json";
echarts.registerMap("china", china);

export default {
  name: "Map_analysis",
  data() {
    return {
      map: undefined,
      panel: undefined,
      panelTitle: "",
      showPanel: false,
      contactList: [],
      contactListAll: [],
      photoList: [],
      currentZoom: 0,
      chart: {
        mychart: undefined,
        currentMax: 0,
        traveldetail: [],
        cities: [
          {
            name: "nanjin",

            contacts: [],
            photos: [],
            travel: [],
          },
          {
            name: "beijin",

            contacts: [],
            photos: [],
            travel: [],
          },
          {
            name: "shanghai",

            contacts: [],
            photos: [],
            travel: [],
          },
        ],
        option: undefined,
        optionOri: undefined,
        lines: [
          {
            source: "beijin",
            target: "shanghai",
          },
        ],
      },
      chartType: [
        "contact",
        "favorite-point",
        "favorite-route",
        "photo",
        "search-point",
        "search-route",
      ],
    };
  },
  methods: {
    changeMapType(type) {
      this.chartType = type;
      if (this.showPanel) {
        this.showMapOverlook(this.currentZoom);
      } else {
        this.setOptionData();
      }
      var checkbox = document.getElementsByClassName("checkbox");
      for (let i = 0; i < checkbox.length; i++) {
        // console.log(checkbox[i].classList.contains('is-checked'));
        if (checkbox[i].classList.contains("is-checked")) {
          // checkbox[i].style="background-image: radial-gradient(circle, #FF4040, #FEA0A0) !important;"
          checkbox[i].style = "background-color: #459FFC !important;";
        } else {
          checkbox[i].style = "";
        }
      }
    },
    async showChart({ dateTimeFrom, dateTimeTo } = {}) {
      let _this = this;
      this.chart.mychart = echarts.init(
        document.getElementById("map-analysis-chart")
      );
      this.chart.mychart.showLoading();
      // let { data } = await this.ajax.post("/region/travel", {
      //   dateTimeFrom: "" || dateTimeFrom,
      //   dateTimeTo: "" || dateTimeTo,
      //   mobileId: _this.id,
      // });
      this.chart.mychart.hideLoading();
      loadScript("./static/data/senior_function/map/travel.js", () => {
        _this.chart.cities = window.globalJSData["map"]["travel"].data.cities;
        this.setOptionData();
        this.changeMapType(this.chartType);
      });
    },
    showMapAnalysisDetails() {
      let _this = this;
      loadScript("./static/data/senior_function/map/traveldetail.js", () => {
        _this.chart.traveldetail =
          window.globalJSData["map"]["traveldetail"].data;
        _this.map = new BMap.Map("map-analysis-details", {
          minZoom: 1,
          maxZoom: 9,
        });
        let point = new BMap.Point(121.557237, 29.876976);
        _this.map.centerAndZoom(point, 5);
        _this.map.enableScrollWheelZoom();
        _this.map.enableKeyboard();
        new BMapLib.CurveLine([], {});
        _this.map.clearOverlays();
        _this.showMapOverlook();
        this.map.addEventListener("click", (e) => {
          // this.map.centerAndZoom(new BMap.Point(e.overlay.info.longitude, e.overlay.info.latitude), 13);
          if (e.overlay) {
            if (e.overlay.info.isContact) {
              this.panel = "contact";
              this.panelTitle = e.overlay.info.city + "联系人";
              this.showPanel = true;
              this.contactList = e.overlay.info.children;
              this.contactListAll = e.overlay.info.children;
            }

            if (e.overlay.info.isPhoto) {
              this.panel = "photo";
              this.panelTitle = "照片";
              this.showPanel = true;
              this.photoList = e.overlay.info.children;
            }

            // 聚合点，展开
            if (
              e.overlay.info.pointType &&
              e.overlay.info.pointType.endsWith("-group-point")
            ) {
              // 定位
              this.map.centerAndZoom(
                new BMap.Point(e.overlay.info.lng, e.overlay.info.lat),
                13
              );
            }

            // 普通的点
            if (e.overlay.info.pointType == "search-point") {
              this.showPanel = true;
              this.panel = "point";
              this.panelTitle = "搜索地点";
              this.pointList = [e.overlay.info];
              this.pointListAll = JSON.parse(JSON.stringify(this.pointList));
            }

            if (e.overlay.info.pointType == "favorite-point") {
              this.showPanel = true;
              this.panel = "point";
              this.panelTitle = "收藏地点";
              this.pointList = [e.overlay.info];
              this.pointListAll = JSON.parse(JSON.stringify(this.pointList));
            }

            // 线
            if (e.overlay.info.edgeType == "search-route") {
              console.log(e.overlay.info);
              this.showPanel = true;
              this.panel = "route";
              this.panelTitle = "搜索路线";
              this.routeList = [...e.overlay.info.lines];
              this.routeListAll = JSON.parse(JSON.stringify(this.routeList));
            }

            if (e.overlay.info.edgeType == "favorite-route") {
              console.log(e.overlay.info);
              this.showPanel = true;
              this.panel = "route";
              this.panelTitle = "收藏路线";
              this.routeList = [...e.overlay.info.lines];
              this.routeListAll = JSON.parse(JSON.stringify(this.routeList));
            }

            if (e.overlay.info.pointType == "favorite-route-point") {
              console.log(e.overlay.info);
              this.showPanel = true;
              this.panel = "point";
              this.panelTitle = "地点";
              this.pointList = [e.overlay.info.extra];
              this.pointListAll = JSON.parse(JSON.stringify(this.pointList));
            }

            if (e.overlay.info.pointType == "search-route-point") {
              console.log(e.overlay.info);
              this.showPanel = true;
              this.panel = "point";
              this.panelTitle = "地点";
              this.pointList = [e.overlay.info.extra];
              this.pointListAll = JSON.parse(JSON.stringify(this.pointList));
            }
          }
        });

        this.map.addEventListener("zoomend", () => {
          let zoom = _this.map.getZoom();
          if (zoom >= 14) {
            _this.map.clearOverlays();
            _this.showMapOverlook(0.01);
          } else if (zoom == 13) {
            _this.map.clearOverlays();
            _this.showMapOverlook(0.01);
          } else if (zoom == 12) {
            _this.map.clearOverlays();
            _this.showMapOverlook(0.01);
          } else if (zoom == 11) {
            _this.map.clearOverlays();
            _this.showMapOverlook(0.01);
          } else if (zoom == 10) {
            _this.map.clearOverlays();
            _this.showMapOverlook(0.05);
          } else if (zoom == 9) {
            _this.map.clearOverlays();
            _this.showMapOverlook(0.1);
          } else if (zoom == 8) {
            _this.map.clearOverlays();
            _this.showMapOverlook(0.15);
          } else if (zoom == 7) {
            _this.map.clearOverlays();
            _this.showMapOverlook(0.5);
          } else if (zoom == 6) {
            _this.map.clearOverlays();
            _this.showMapOverlook(1);
          } else if (zoom == 5) {
            _this.map.clearOverlays();
            _this.showMapOverlook();
          } else if (zoom <= 4) {
          }
        });
      });
    },
    // 新的画点的方法
    drawMapPoint(position, rawData, appCode, label, pointType, extra) {
      let pt = new BMap.Point(position[0], position[1]);
      let myIcon;
      if (pointType.startsWith("search-")) {
        myIcon = new BMap.Icon(toBase64("search"), new BMap.Size(27, 27));
      } else if (pointType.startsWith("favorite-")) {
        myIcon = new BMap.Icon(toBase64("favorite"), new BMap.Size(27, 27));
      }
      let marker = new BMap.Marker(pt, {
        icon: myIcon,
        offset: new BMap.Size(0, -13),
      });
      marker.info = {
        ...rawData,
        label,
        pointType,
        lat: position[1],
        lng: position[0],
        extra,
      };
      this.map.addOverlay(marker);
      if (label != "" && label) {
        let labelPoint = new BMap.Label(label, {
          offset: new BMap.Size(22, 2),
        });
        // marker.setLabel(labelPoint);
      }
      this.points.push(marker); // 添加到points中用于筛选
    },
    setMapPoint(lng, lat, info, icon) {
      let pt = new BMap.Point(lat, lng);
      let myIcon = new BMap.Icon(
        icon || toBase64("photo"),
        new BMap.Size(24, 24)
      );
      let marker = new BMap.Marker(pt, {
        icon: myIcon,
        offset: new BMap.Size(0, -13),
      });
      marker.info = info;

      this.map.addOverlay(marker);
      var label = new BMap.Label(info.children.length, {
        offset: new BMap.Size(22, 2),
      });
      marker.setLabel(label);
      this.points.push(marker); // 添加到points中用于筛选
    },
    // 归纳显示
    showMapOverlook(zoom = 1.5) {
      this.points = [];
      this.lines = [];
      this.map.clearOverlays();
      let _this = this;
      let mapData = JSON.parse(JSON.stringify(_this.chart.traveldetail));
      // 1 = 6a + b
      // 0.01 = 13a + b
      //                let offset = -.1414 * zoom + 1.8484;
      let offset = zoom;
      this.currentZoom = zoom;
      let isInRange = function (a, b) {
        return (
          a.longitude * 1 < b.longitude * 1 + offset &&
          a.longitude * 1 > b.longitude * 1 - offset &&
          a.latitude * 1 < b.latitude * 1 + offset &&
          a.latitude * 1 > b.latitude * 1 - offset
        );
      };

      // 直接传入坐标计算相似度
      let isInRangeNew = function (
        aLongitude,
        bLongitude,
        aLatitude,
        bLatitude
      ) {
        return (
          aLongitude * 1 < bLongitude * 1 + offset &&
          aLongitude * 1 > bLongitude * 1 - offset &&
          aLatitude * 1 < bLatitude * 1 + offset &&
          aLatitude * 1 > bLatitude * 1 - offset
        );
      };

      // 联系人
      if (this.chartType.indexOf("contact") != -1) {
        let contacts = [];
        mapData.contacts.forEach((i) => {
          i.children = [];
          if (
            !contacts.some((j) => {
              return j.city == i.city;
            })
          ) {
            contacts.push(i);
          }
        });
        contacts.forEach((j) => {
          mapData.contacts.forEach((k) => {
            if (k.city == j.city) {
              j.children.push(k);
            }
          });
        });
        contacts.forEach((i) => {
          _this.setMapPoint(
            i.latitude * 1,
            i.longitude * 1,
            {
              isContact: true,
              ...i,
              type: "contact",
            },
            toBase64("contact")
          );
        });
      }

      // 清空
      this.lineGroup = {};

      // 搜索
      {
        // 根据zoom判断是否需要缩放
        if (offset == 0.01) {
          // 不执行缩放
          // 搜索路线、搜索地点
          if (this.chartType.indexOf("search-route") != -1) {
            for (let appCode in mapData.map.searchRecord.route) {
              let records = mapData.map.searchRecord.route[appCode];
              records.forEach((record) => {
                // 搜索路线是两个点（存的经纬度0经、1纬）
                let fromPoint = [
                  record.strStartLongitude * 1,
                  record.strStartLatitude * 1,
                ];
                let toPoint = [
                  record.strEndLongitude * 1,
                  record.strEndLatitude * 1,
                ];
                // 两个点之间连一条线
                _this.drawMapPoint(
                  fromPoint,
                  record,
                  appCode,
                  record.strStartName,
                  "search-route-point",
                  {
                    strPointName: record.strStartName,
                    strAddress: record.strStartAddr,
                    time: record.searchTime,
                    appCode: record.appCode,
                    strLongitude: record.strStartLongitude,
                    strLatitude: record.strStartLatitude,
                  }
                );
                _this.drawMapPoint(
                  toPoint,
                  record,
                  appCode,
                  record.strEndName,
                  "search-route-point",
                  {
                    strPointName: record.strEndName,
                    strAddress: record.strEndAddr,
                    time: record.searchTime,
                    appCode: record.appCode,
                    strLongitude: record.strEndLongitude,
                    strLatitude: record.strEndLatitude,
                  }
                );
                _this.drawMapCurveLineNew(
                  fromPoint,
                  toPoint,
                  record,
                  "search-route"
                );
              });
            }
          }

          if (this.chartType.indexOf("search-point") != -1) {
            for (let appCode in mapData.map.searchRecord.point) {
              let records = mapData.map.searchRecord.point[appCode];
              records.forEach((record) => {
                // 搜索路线是两个点（存的经纬度0经、1纬）
                let curPoint = [
                  record.strLongitude * 1,
                  record.strLatitude * 1,
                ];
                _this.drawMapPoint(
                  curPoint,
                  record,
                  appCode,
                  record.strPointName,
                  "search-point"
                );
              });
            }
          }
        } else {
          // 搜索路线
          let points = [];
          if (this.chartType.indexOf("search-route") != -1) {
            for (let appCode in mapData.map.searchRecord.route) {
              let records = mapData.map.searchRecord.route[appCode];
              records.forEach((record) => {
                let fromPoint = [
                  record.strStartLongitude * 1,
                  record.strStartLatitude * 1,
                ];
                let toPoint = [
                  record.strEndLongitude * 1,
                  record.strEndLatitude * 1,
                ];
                points.push(
                  {
                    longitude: fromPoint[0],
                    latitude: fromPoint[1],
                  },
                  { longitude: toPoint[0], latitude: toPoint[1] }
                );
              });
              let pointToDraw = [];
              for (let point of points) {
                if (!point.marked) {
                  point.marked = true;
                  for (let p of points) {
                    if (
                      !p.marked &&
                      isInRangeNew(
                        point.longitude,
                        p.longitude,
                        point.latitude,
                        p.latitude
                      )
                    ) {
                      p.marked = true;
                    }
                  }
                  pointToDraw.push(point);
                }
              }
              for (let p of pointToDraw) {
                _this.drawMapPoint(
                  [p.longitude, p.latitude],
                  null,
                  appCode,
                  null,
                  "search-group-point"
                );
              }
            }
          }

          // 搜索地点
          if (this.chartType.indexOf("search-point") != -1) {
            for (let appCode in mapData.map.searchRecord.point) {
              let records = mapData.map.searchRecord.point[appCode];
              records.forEach((record) => {
                let point = [record.strLongitude * 1, record.strLatitude * 1];
                points.push({ longitude: point[0], latitude: point[1] });
              });
              let pointToDraw = [];
              for (let point of points) {
                if (!point.marked) {
                  point.marked = true;
                  for (let p of points) {
                    if (
                      !p.marked &&
                      isInRangeNew(
                        point.longitude,
                        p.longitude,
                        point.latitude,
                        p.latitude
                      )
                    ) {
                      p.marked = true;
                    }
                  }
                  pointToDraw.push(point);
                }
              }
              for (let p of pointToDraw) {
                _this.drawMapPoint(
                  [p.longitude, p.latitude],
                  null,
                  appCode,
                  null,
                  "search-group-point"
                );
              }
            }
          }
        }
      }

      // 收藏
      {
        // 根据zoom判断是否需要缩放
        if (offset == 0.01) {
          // 不执行缩放
          // 搜索路线、搜索地点
          if (this.chartType.indexOf("favorite-route") != -1) {
            for (let appCode in mapData.map.favorite.route) {
              let records = mapData.map.favorite.route[appCode];
              records.forEach((record) => {
                // 搜索路线是两个点（存的经纬度0经、1纬）
                let fromPoint = [
                  record.strStartLongitude * 1,
                  record.strStartLatitude * 1,
                ];
                let toPoint = [
                  record.strEndLongitude * 1,
                  record.strEndLatitude * 1,
                ];
                // 两个点之间连一条线
                _this.drawMapPoint(
                  fromPoint,
                  record,
                  appCode,
                  record.strStartName,
                  "favorite-route-point",
                  {
                    strPointName: record.strStartName,
                    strAddress: record.strStartAddr,
                    time: record.time,
                    appCode: record.appCode,
                    strLongitude: record.strStartLongitude,
                    strLatitude: record.strStartLatitude,
                  }
                );
                _this.drawMapPoint(
                  toPoint,
                  record,
                  appCode,
                  record.strEndName,
                  "favorite-route-point",
                  {
                    strPointName: record.strEndName,
                    strAddress: record.strEndAddr,
                    time: record.time,
                    appCode: record.appCode,
                    strLongitude: record.strEndLongitude,
                    strLatitude: record.strEndLatitude,
                  }
                );
                _this.drawMapCurveLineNew(
                  fromPoint,
                  toPoint,
                  record,
                  "favorite-route"
                );
              });
            }
          }

          if (this.chartType.indexOf("favorite-point") != -1) {
            for (let appCode in mapData.map.favorite.point) {
              let records = mapData.map.favorite.point[appCode];
              records.forEach((record) => {
                // 搜索路线是两个点（存的经纬度0经、1纬）
                let curPoint = [
                  record.strLongitude * 1,
                  record.strLatitude * 1,
                ];
                _this.drawMapPoint(
                  curPoint,
                  record,
                  appCode,
                  record.strPointName,
                  "favorite-point"
                );
              });
            }
          }
        } else {
          // 收藏路线
          let points = [];
          if (this.chartType.indexOf("favorite-route") != -1) {
            for (let appCode in mapData.map.favorite.route) {
              let records = mapData.map.favorite.route[appCode];
              records.forEach((record) => {
                if (
                  !record.strStartLongitude ||
                  record.strStartLongitude == ""
                ) {
                  record.strStartLongitude = 0;
                }
                if (!record.strStartLatitude || record.strStartLatitude == "") {
                  record.strStartLatitude = 0;
                }
                if (!record.strEndLongitude || record.strEndLongitude == "") {
                  record.strEndLongitude = 0;
                }
                if (!record.strEndLatitude || record.strEndLatitude == "") {
                  record.strEndLatitude = 0;
                }
                let fromPoint = [
                  record.strStartLongitude * 1,
                  record.strStartLatitude * 1,
                ];
                let toPoint = [
                  record.strEndLongitude * 1,
                  record.strEndLatitude * 1,
                ];
                console.log(fromPoint, toPoint);
                points.push(
                  {
                    longitude: fromPoint[0],
                    latitude: fromPoint[1],
                  },
                  { longitude: toPoint[0], latitude: toPoint[1] }
                );
              });
              let pointToDraw = [];
              for (let point of points) {
                if (!point.marked) {
                  point.marked = true;
                  for (let p of points) {
                    if (
                      !p.marked &&
                      isInRangeNew(
                        point.longitude,
                        p.longitude,
                        point.latitude,
                        p.latitude
                      )
                    ) {
                      p.marked = true;
                    }
                  }
                  pointToDraw.push(point);
                }
              }
              for (let p of pointToDraw) {
                console.log("p", p);
                _this.drawMapPoint(
                  [p.longitude, p.latitude],
                  {},
                  appCode,
                  null,
                  "favorite-group-point"
                );
              }
            }
          }

          // 收藏地点
          if (this.chartType.indexOf("favorite-point") != -1) {
            for (let appCode in mapData.map.favorite.point) {
              let records = mapData.map.favorite.point[appCode];
              records.forEach((record) => {
                if (!record.strLatitude || record.strLatitude == "") {
                  record.strLatitude = 0;
                }
                if (!record.strLongitude || record.strLongitude == "") {
                  record.strLongitude = 0;
                }
                let point = [record.strLongitude * 1, record.strLatitude * 1];
                console.log(point, appCode);
                points.push({ longitude: point[0], latitude: point[1] });
              });
              let pointToDraw = [];
              for (let point of points) {
                if (!point.marked) {
                  point.marked = true;
                  for (let p of points) {
                    if (
                      !p.marked &&
                      isInRangeNew(
                        point.longitude,
                        p.longitude,
                        point.latitude,
                        p.latitude
                      )
                    ) {
                      p.marked = true;
                    }
                  }
                  pointToDraw.push(point);
                }
              }
              for (let p of pointToDraw) {
                console.log("p", p);
                _this.drawMapPoint(
                  [p.longitude, p.latitude],
                  {},
                  appCode,
                  null,
                  "favorite-group-point"
                );
              }
            }
          }
        }
      }

      // // 画线的实际方法
      if (zoom == 0.01) {
        console.log(_this.lineGroup);
        for (let key in _this.lineGroup) {
          let parts = key.split("|");
          let startParts = parts[0].split(",");
          let endParts = parts[1].split(",");
          let edgeType = parts[2];

          let points = [
            new BMap.Point(startParts[0] * 1, startParts[1] * 1),
            new BMap.Point(endParts[0] * 1, endParts[1] * 1),
          ];

          let w = 2;
          let curve = new BMapLib.CurveLine(points, {
            strokeColor: edgeType == "search-route" ? "blue" : "red",
            strokeWeight: 2 + w,
            strokeOpacity: 0.4,
          }); //创建弧线对象
          curve.info = { lines: _this.lineGroup[key], isEdge: true, edgeType };
          this.map.addOverlay(curve); //添加到地图中
          this.lines.push(curve); // 添加到lines中用于筛选
        }
      }

      // 照片
      if (this.chartType.indexOf("photo") != -1) {
        let photos = [];
        mapData.photos.forEach((i) => {
          let la = i.latitude * 1;
          let lo = i.longitude * 1;

          if (!i.added && la != 0 && lo != 0) {
            i.added = true;
            let target = {
              ...i,
              children: [i],
            };

            mapData.photos.forEach((j) => {
              if (!j.added && isInRange(j, target)) {
                j.added = true;
                target.children.push(j);
              }
            });
            photos.push(target);
          }
        });
        photos.forEach((i) => {
          _this.setMapPoint(i.latitude * 1, i.longitude * 1, {
            isPhoto: true,
            ...i,
            type: "photo",
          });
        });
      }
    },
    setOptionData() {
      let option = {
        backgroundColor: "#fff",
        tooltip: {
          trigger: "item",
          formatter: (p) => {
            if (p.data) {
              let {
                name,
                value,
                contacts,
                didis,
                photos,
                searchPoint,
                searchRoute,
                favoritePoint,
                favoriteRoute,
              } = p.data;
              return `联系人: ${contacts}<br>拍摄行为: ${photos}<br>搜索地点: ${searchPoint}<br>搜索路线: ${searchRoute}<br>收藏地点: ${favoritePoint}<br>收藏路线: ${favoriteRoute}<br>`;
            } else {
              return `联系人: 0<br>拍摄行为: 0<br>搜索地点: 0<br>搜索路线: 0<br>收藏地点: 0<br>收藏路线: 0<br>`;
            }
          },
        },
        visualMap: {
          show: true,
          min: 0.5,
          max: 1000,
          left: "right",
          top: "bottom",
          text: ["高", "低"],
          calculable: true,
          seriesIndex: [0],
          inRange: {
            color: ["#FFFFFF", "#4AA0FA"],
          },
          textStyle: {
            color: "#fff",
          },
        },
        series: [
          {
            name: "地理分析",
            type: "map",
            map: "china",
            roam: true,
            zoom: 1.1,
            label: {
              normal: {
                show: true,
              },
            },
            itemStyle: {
              emphasis: {
                areaColor: "#f3dacf",
              },
            },
            data: [
              {
                name: "台湾",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "河北",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "山西",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "内蒙古",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "安徽",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "澳门",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "北京",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "重庆",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "福建",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "甘肃",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "广东",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "广西",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "贵州",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "海南",
                value: 6.1,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "黑龙江",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "河南",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "湖北",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "湖南",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "江苏",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "江西",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "吉林",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "辽宁",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "宁夏",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "青海",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "山东",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "上海",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "四川",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "天津",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "香港",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "新疆",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "西藏",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "云南",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "浙江",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "陕西",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
              {
                name: "南海诸岛",
                value: 0,
                contacts: 0,
                favoritePoint: 0,
                searchRoute: 0,
                photos: 0,
                favoriteRoute: 0,
                searchPoint: 0,
              },
            ],
          },
        ],
      };
      let _this = this;
      if (_this.chart.cities.length > 0) {
        _this.chart.cities.forEach((item) => {
          let province = item.name.trim().split(" ")[0];
          if (province.endsWith("市")) {
            province = province.split("市")[0];
          }
          if (province.endsWith("省")) {
            province = province.split("省")[0];
          }
          if (province.startsWith("新疆")) {
            province = "新疆";
          }
          let contactLength = _this.chartType.includes("contact")
            ? item.contacts.length
            : 0;
          let photoLength = _this.chartType.includes("photo")
            ? item.photos.length
            : 0;
          let searchRouteLength = 0;
          let searchPointLength = 0;
          let favoritePointLength = 0;
          let favoriteRouteLength = 0;
          if (option.series[0].data.some((i) => i.name === province)) {
            let targetProvince = option.series[0].data.find(
              (i) => i.name === province
            );
            targetProvince.value +=
              contactLength +
              searchRouteLength +
              searchPointLength +
              photoLength +
              favoritePointLength +
              favoriteRouteLength;
            targetProvince.contacts += contactLength;
            targetProvince.photos += photoLength;
            targetProvince.favoriteRoute += favoriteRouteLength;
            targetProvince.favoritePoint += favoritePointLength;
            targetProvince.searchRoute += searchRouteLength;
            targetProvince.searchPoint += searchPointLength;
          } else {
            option.series[0].data.push({
              name: province,
              value:
                contactLength +
                searchRouteLength +
                searchPointLength +
                photoLength +
                favoriteRouteLength +
                favoritePointLength,

              contacts: contactLength,
              // didis: didiLength,
              photos: photoLength,
              favoriteRoute: favoriteRouteLength,
              favoritePoint: favoritePointLength,
              searchRoute: searchRouteLength,
              searchPoint: searchPointLength,
              level: "province",
            });
          }
        });
        _this.chart.option = JSON.parse(JSON.stringify(option));
        _this.chart.optionOri = JSON.parse(JSON.stringify(option));
        _this.chart.mychart.setOption(option);
        _this.chart.mychart.on("click", async function (a) {
          if (a.name) {
            _this.showPanel = true;
            _this.showMapAnalysisDetails();
          }
        });
      }
    },
  },
  mounted() {
    this.showChart();
  },
};
</script>
<style lang="scss" scoped>
#Map_analysis {
  width: 100%;
  height: 100%;
  padding: 10px 40px;
  box-sizing: border-box;
  position: relative;
  .btn {
    position: absolute;
    top: 60px;
    left: 60px;
    z-index: 10;
  }
  .checkout {
    position: absolute;
    top: 60px;
    right: 60px;
    z-index: 10;
    .map-switch {
      // background: red;

      display: inline-block;
      /*margin-top: 5px;*/
      // margin-right: 5px;
      text-indent: 3px;
      /deep/ .el-checkbox__input.is-checked + .el-checkbox__label {
        color: white !important;
      }
      /deep/ .el-checkbox__input {
        display: none;
      }
      img {
        display: inline-block;
        position: absolute;

        width: 12px;

        margin-top: 1px;
        margin-left: -16px;
      }
    }
  }
  .header {
    width: 100%;
    height: 40px;
    display: flex;
    font-weight: bold;
    justify-content: space-between;
    align-items: center;
  }
  #map-analysis-chart {
    width: 100%;
    height: calc(100% - 40px);
  }
  #map-analysis-details {
    box-sizing: border-box;
    width: calc(100% - 80px);
    height: calc(100% - 60px);
    position: absolute;
    top: 50px;
    z-index: -1;
  }
}
</style>
