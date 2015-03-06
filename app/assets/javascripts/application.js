// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require swiper

$(document).ready(function () {
  $(".tabs-nav").children().click(function() {
    var $active = $(this).parent().children(".active");
    $active.removeClass("active").animate({
      paddingLeft: 0
    });
    $(this).addClass("active").animate({
      paddingLeft: "10px"
    });
    $(".artical").removeClass("active");
    var $artical = $(".artical").eq($(this).parent().children().index(this));
    $artical.addClass("active");
  });
  $(".tabs-nav").children().first().click();

  var swiper = new Swiper('.swiper-container', {
    pagination: '.swiper-pagination',
    paginationClickable: true
  });

  if($("#map").length === 1) {
    //创建和初始化地图函数：
    function initMap(){
      createMap();//创建地图
      setMapEvent();//设置地图事件
      addMapControl();//向地图添加控件
    }

    //创建地图函数：
    function createMap(){
      var map = new BMap.Map("map");
      var point = new BMap.Point(116.395645,39.929986);//定义一个中心点坐标
      map.centerAndZoom(point,12);//设定地图的中心点和坐标并将地图显示在地图容器中
      window.map = map;//将map变量存储在全局
    }

    //地图事件设置函数：
    function setMapEvent(){
      map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
      map.enableScrollWheelZoom();//启用地图滚轮放大缩小
      map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
      map.enableKeyboard();//启用键盘上下左右键移动地图
    }

    //地图控件添加函数：
    function addMapControl(){
      //向地图中添加缩放控件
      var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
      map.addControl(ctrl_nav);
      //向地图中添加缩略图控件
      var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
      map.addControl(ctrl_ove);
      //向地图中添加比例尺控件
      var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
      map.addControl(ctrl_sca);
    }
    initMap();//创建和初始化地图
  }
});
