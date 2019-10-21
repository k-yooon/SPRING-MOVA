<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ include file="../include/header.jsp" %>
<style>
<style>
#chartdiv {
  width: 80%;
  height: 400px;
}
#chartdiv2 {
  width: 80%;
  height: 400px;
  margin-left: 10%;
}
#chartdiv3 {
  width: 100%;
  height: 600px
}
.starCount, .avgstar, .muchstar{
	border: 3px solid #2F8771;
	text-align: center;
	width: 150px;
	display: inline-block;
	margin-left: 18%;
}

</style>

<div class="inner-agile-w3l-part-head">
	<h3 class="w3l-inner-h-title">취향 분석 및 영화 추천</h3>
	<p class="w3ls_head_para">당신의 독심술사 MOVA</p>
</div>

<h3 class="agile_w3_title"> <span>별점</span> 분포</h3>			
<div id="chartdiv"></div>
<hr>
<div class="starCount">별점 개수 <br> <b>${total}</b></div>
<div class="avgstar">평균 별점 <br> <b>${avgstar}</b></div>
<div class="muchstar">많이 준 별점 <br> <b>${muchstar}</b></div>
<hr>

<h3 class="agile_w3_title"> <span>선호</span> 장르</h3>	
<div id="chartdiv2"></div>

<h3 class="agile_w3_title"> <span>선호</span> 국가</h3>	
<div id="chartdiv3"></div>

<h3 class="agile_w3_title"> <span>추천</span> 영화</h3>	
			<!--//movies-->
				 <div id="chartdiv"></div>
				<!--/requested-movies-->
				<c:forEach items="${list}" var="movie">
					<c:set var="genre" value="${movie.genre}"/>
				     <div class="wthree_agile-requested-movies">
							<div class="col-md-2 w3l-movie-gride-agile requested-movies">
								<a href="./movieInfo?mno=${movie.mno}"><div class="poster">
									<img src="../resources/images/movie/poster/${movie.fileName}" style="width: 250px; height: 330px">
								</div>
								<div class="mid-1 agileits_w3layouts_mid_1_home">
									<div class="w3l-movie-text">
											<h6>${movie.mname}</a></h6>							
									</div>
								<div class="mid-2 agile_mid_2_home">
									<p>${movie.year}</p>
										<div class="block-stars">
											<ul class="w3l-ratings">
												<c:set var="star" value="${movie.avgstar}"/>
												
												<c:set var="sosu" value="false"/>
												<c:if test="${star == 1.5 || star == 2.5 || star == 3.5 || star == 4.5}">
													<c:set var="sosu" value="true"/>
												</c:if>
												<c:set var="star" value="${star+((star%1>0.5)?(1-(star%1))%1:-(star%1))}"/>
												<fmt:parseNumber var="star" integerOnly="true" value="${star}"/>
												<c:choose>
													<c:when test="${sosu == true}">
														<c:forEach begin="1" end="${star}" step="1">
															<i class="fa fa-star" aria-hidden="true" style="color: red"></i>
														</c:forEach>
															<i class="fa fa-star-half-o" aria-hidden="true" style="color: red"></i>	
														<c:forEach begin="${star}" end="3" step="1">
															<i class="fa fa-star-o" aria-hidden="true" style="color: red"></i>
														</c:forEach>	
													</c:when>
													<c:otherwise>
														<c:forEach var="i" begin="0" end="4" step="1">
															<c:choose>
															<c:when test="${i < star}">
																<i class="fa fa-star" aria-hidden="true" style="color: red"></i>
															</c:when>
															<c:otherwise>
																<i class="fa fa-star-o" aria-hidden="true" style="color: red"></i>
															</c:otherwise>
															</c:choose>
														</c:forEach>
													</c:otherwise>
												</c:choose>
												<div class="star"></div>
											</ul>
										</div>
									<div class="clearfix"></div>
								</div>
								</div>							
							</div>				
					</div>
				</c:forEach> 
<script>
	function showstar(dbstarr) {  
			//별점 출력
			var innerHtml = "";
			var dbstar = dbstarr;
			var sosu = false;
			console.log(dbstar);
			if(dbstar == 1.5 || dbstar == 2.5 || dbstar == 3.5 || dbstar == 4.5){
				sosu = true;
			} 
			var star = Math.round(dbstar);	
			console.log(star);
			console.log(sosu);
			
			if(sosu){
				for(var i =1 ; i < star; i++) {  
					  innerHtml  +=  '<i class="fa fa-star" aria-hidden="true" style="color: red"></i>';  
				} innerHtml  += '<i class="fa fa-star-half-o" aria-hidden="true" style="color: red"></i>';
				for(var j = 0; j < 5-star; j++){
					innerHtml  +=  '<i class="fa fa-star-o" aria-hidden="true" style="color: red"></i>';  
				}
			} else {
				for(var i =0 ; i < 5; i++) {  
					if(i < star){
					  innerHtml  +=  '<i class="fa fa-star" aria-hidden="true" style="color: red"></i>';  
						console.log(i);
					} else {
						innerHtml  +=  '<i class="fa fa-star-o" aria-hidden="true" style="color: red"></i>';  
					}
				} 
			} 
			$('.star').html(innerHtml);		
	}

</script> 

<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/maps.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/material.js"></script>
<script src="https://www.amcharts.com/lib/4/geodata/worldLow.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>

<!-- Chart code -->
<script>

am4core.ready(function() {
	var mapData="";
	showChart();
	showChart2();
	getNationList();
	

var total = "${totalNation}";
var str = ""
console.log(total);
function getList(param, callback, error){
	var userid = param.userid;
	$.getJSON("/movie/movieRecommend/genre/" + userid + ".json", function(response){
			if(callback){
				callback(response);		
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
}

function getStarList(param, callback, error){
	var userid = param.userid;
	$.getJSON("/movie/movieRecommend/comm/" + userid + ".json", function(response){
			if(callback){
				callback(response);		
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
}

//별점 Themes begin
am4core.useTheme(am4themes_material);
am4core.useTheme(am4themes_animated);
// Themes end

// Create chart instance
var chart = am4core.create("chartdiv", am4charts.XYChart);
chart.scrollbarX = new am4core.Scrollbar();

function showChart(){
	var userid = "${param.userid}";
	getStarList({
		  userid : userid  
	  	}, function(list){
	  		chart.data = list;
	  	}
	   ); 
	}

// Create axes
var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "star";
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 0.1;
categoryAxis.renderer.labels.template.horizontalCenter = "right";
categoryAxis.renderer.labels.template.verticalCenter = "middle";
categoryAxis.renderer.labels.template.rotation = 0;
categoryAxis.tooltip.disabled = true;
categoryAxis.renderer.minHeight = 0.1;

var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.minWidth = 50;

// Create series
var series = chart.series.push(new am4charts.ColumnSeries());
series.sequencedInterpolation = true;
series.dataFields.valueY = "count";
series.dataFields.categoryX = "star";
series.tooltipText = "[{categoryX}: bold]{valueY}[/]";
series.columns.template.strokeWidth = 0;

series.tooltip.pointerOrientation = "vertical";

series.columns.template.column.cornerRadiusTopLeft = 10;
series.columns.template.column.cornerRadiusTopRight = 10;
series.columns.template.column.fillOpacity = 0.8;

// on hover, make corner radiuses bigger
var hoverState = series.columns.template.column.states.create("hover");
hoverState.properties.cornerRadiusTopLeft = 0;
hoverState.properties.cornerRadiusTopRight = 0;
hoverState.properties.fillOpacity = 1;

series.columns.template.adapter.add("fill", function(fill, target) {
  return chart.colors.getIndex(target.dataItem.index);
});

// Cursor
chart.cursor = new am4charts.XYCursor();


 
// 장르 Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.PieChart);
// Add data

function showChart2(){
var userid = "${param.userid}";
getList({
	  userid : userid  
  	}, function(list){
  			chart2.data = list;
  	}
   ); 
}	


// Add and configure Series
var pieSeries = chart2.series.push(new am4charts.PieSeries());
pieSeries.dataFields.value = "count";
pieSeries.dataFields.category = "genre";
pieSeries.slices.template.stroke = am4core.color("#fff");
pieSeries.slices.template.strokeWidth = 2;
pieSeries.slices.template.strokeOpacity = 1;

// This creates initial animation
pieSeries.hiddenState.properties.opacity = 1;
pieSeries.hiddenState.properties.endAngle = -90;
pieSeries.hiddenState.properties.startAngle = -90; 

//국가 Themes begin
am4core.useTheme(am4themes_animated);
// Themes end


// Create map instance
var chart3 = am4core.create("chartdiv3", am4maps.MapChart);
	
var title = chart3.titles.create();
title.text = "[bold font-size: 20]지구별 영화 여행자[/]";
title.textAlign = "middle";

var latlong = {
  "AQ": {"latitude":-90, "longitude":0},
  "아랍에미레이트": {"latitude":24, "longitude":54},
  "아르헨티나": {"latitude":-34, "longitude":-64},
  "오스트리아": {"latitude":47.3333, "longitude":13.3333},
  "호주": {"latitude":-27, "longitude":133},
  "방글라데시": {"latitude":24, "longitude":90},
  "벨기에": {"latitude":50.8333, "longitude":4},
  "불가리아": {"latitude":43, "longitude":25},
  "볼리비아": {"latitude":-17, "longitude":-65},
  "브라질": {"latitude":-10, "longitude":-55},
  "캐나다": {"latitude":54, "longitude":-100},
  "스위스": {"latitude":47, "longitude":8},
  "칠레": {"latitude":-30, "longitude":-71},
  "중국": {"latitude":35, "longitude":105},
  "콜롬비아": {"latitude":4, "longitude":-72},
  "쿠바": {"latitude":21.5, "longitude":-80},
  "체코": {"latitude":49.75, "longitude":15.5},
  "독일": {"latitude":51, "longitude":9},
  "덴마크": {"latitude":56, "longitude":10},
  "에콰도르": {"latitude":-2, "longitude":-77.5},
  "이집트": {"latitude":27, "longitude":30},
  "스페인": {"latitude":40, "longitude":-4},
  "에티오피아": {"latitude":8, "longitude":38},
  "핀란드": {"latitude":62, "longitude":26},
  "프랑스": {"latitude":46, "longitude":2},
  "영국": {"latitude":54, "longitude":-2},
  "가나": {"latitude":8, "longitude":-2},
  "그리스": {"latitude":39, "longitude":22},
  "홍콩": {"latitude":22.25, "longitude":114.1667},
  "헝가리": {"latitude":47, "longitude":20},
  "인도네시아": {"latitude":-5, "longitude":120},
  "아일랜드": {"latitude":53, "longitude":-8},
  "이스라엘": {"latitude":31.5, "longitude":34.75},
  "인도": {"latitude":20, "longitude":77},
  "이라크": {"latitude":33, "longitude":44},
  "이란": {"latitude":32, "longitude":53},
  "아이슬란드": {"latitude":65, "longitude":-18},
  "이탈리아": {"latitude":42.8333, "longitude":12.8333},
  "자메이카": {"latitude":18.25, "longitude":-77.5},
  "요르단": {"latitude":31, "longitude":36},
  "일본": {"latitude":36, "longitude":138},
  "케냐": {"latitude":1, "longitude":38},
  "캄보디아": {"latitude":13, "longitude":105},
  "북한": {"latitude":40, "longitude":127},
  "한국": {"latitude":37, "longitude":127.5},
  "카자흐스탄": {"latitude":48, "longitude":68},
  "라오스": {"latitude":18, "longitude":105},
  "모로코": {"latitude":32, "longitude":-5},
  "몽골": {"latitude":46, "longitude":105},
  "멕시코": {"latitude":23, "longitude":-102},
  "말레이시아": {"latitude":2.5, "longitude":112.5},
  "네덜란드": {"latitude":52.5, "longitude":5.75},
  "노르웨이": {"latitude":62, "longitude":10},
  "네팔": {"latitude":28, "longitude":84},
  "뉴질랜드": {"latitude":-41, "longitude":174},
  "오만": {"latitude":21, "longitude":57},
  "파나마": {"latitude":9, "longitude":-80},
  "페루": {"latitude":-10, "longitude":-76},
  "필리핀": {"latitude":13, "longitude":122},
  "파키스탄": {"latitude":30, "longitude":70},
  "폴란드": {"latitude":52, "longitude":20},
  "포르투갈": {"latitude":39.5, "longitude":-8},
  "루마니아": {"latitude":46, "longitude":25},
  "러시아": {"latitude":60, "longitude":100},
  "사우디 아라비아": {"latitude":25, "longitude":45},
  "스웨덴": {"latitude":62, "longitude":15},
  "싱가포르": {"latitude":1.3667, "longitude":103.8},
  "슬로베니아": {"latitude":46, "longitude":15},
  "시리아": {"latitude":35, "longitude":38},
  "태국": {"latitude":15, "longitude":100},
  "터키": {"latitude":39, "longitude":35},
  "대만": {"latitude":23.5, "longitude":121},
  "우간다": {"latitude":1, "longitude":32},
  "미국": {"latitude":38, "longitude":-97},
  "우루과이": {"latitude":-33, "longitude":-56},
  "우즈베키스탄": {"latitude":41, "longitude":64},
  "베네수엘라": {"latitude":8, "longitude":-66},
  "베트남": {"latitude":16, "longitude":106},
  "예맨": {"latitude":15, "longitude":48},
  "남아프리카": {"latitude":-29, "longitude":24}
};
 
function getNationList(){
	var userid = "${param.userid}";
	$.getJSON("/movie/movieRecommend/nation/" + userid + ".json", function(response){
		console.log(response);
		mapData=response;
		// Add lat/long information to data
		for(var i = 0; i < mapData.length; i++) {
		  console.log("nation" + mapData[i].nation);
		  console.log("count" + mapData[i].count);
		  console.log("longitude" + latlong[mapData[i].nation].longitude);
		  console.log("latitude" + latlong[mapData[i].nation].latitude);
		  mapData[i].latitude = latlong[mapData[i].nation].latitude;
		  mapData[i].longitude = latlong[mapData[i].nation].longitude;
		  mapData[i].color = chart3.colors.getIndex(3);
		 
		}
		// Set map definition
		chart3.geodata = am4geodata_worldLow;

		// Set projection
		chart3.projection = new am4maps.projections.Miller();

		// Create map polygon series
		var polygonSeries = chart3.series.push(new am4maps.MapPolygonSeries());
		polygonSeries.exclude = ["AQ"];
		polygonSeries.useGeodata = true;
		polygonSeries.nonScalingStroke = true;
		polygonSeries.strokeWidth = 0.5;

		var imageSeries = chart3.series.push(new am4maps.MapImageSeries());
		imageSeries.data = mapData;
		imageSeries.dataFields.value = "count";

		var imageTemplate = imageSeries.mapImages.template;
		imageTemplate.propertyFields.latitude = "latitude";
		imageTemplate.propertyFields.longitude = "longitude";
		imageTemplate.nonScaling = true

		var circle = imageTemplate.createChild(am4core.Circle);
		circle.fillOpacity = 0.7;
		circle.propertyFields.fill = "color";
		circle.tooltipText = "{nation}: [bold]{count}[/]";

		imageSeries.heatRules.push({
		  "target": circle,
		  "property": "radius",
		  "min": 4,
		  "max": 20,
		  "dataField": "value"
		});
		}
	);
}

}); // end am4core.ready()


</script>

