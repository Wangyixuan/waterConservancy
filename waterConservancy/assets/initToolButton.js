/**
 * Created by lyuwei on 2017/11/2.
 */
define(function () {
    function initButtonClick() {
        $("a[name='coordinate-location']").click(function(){
            // 坐标定位
            require(['app/component/CoordinateLocation'],function (coordinateLocation) {
                coordinateLocation.init(mapDEMO.map);
            })
        })

        $("a[name='DrawAndDrag']").click(function () {
            // 绘制和拖拽
            require(['app/component/DrawAndDrag'],function (drawdrag) {
                drawdrag.init(mapDEMO.map);
            })
        })

        
        $("a[name='RollerShutter']").click(function () {
            //卷帘对比
            require(['app/component/RollerShutter'],function (rollershutter) {
                rollershutter.init(mapDEMO.map);
            })
        })

        $("a[name='SHPSelect']").click(function () {
            //SHP文件导入弹出框
            require(['app/component/SHPSelect'],function (shpselect) {
                shpselect.init(mapDEMO.map);
            })
        })

        $("a[name='SHPSelectDemo']").click(function () {
            //SHP文件导入弹出框
            require(['app/component/SHPSelectDemo'],function (shpselect) {
                shpselect.init();
             })
        })

        /* cj */
        $("a[name='Extent']").click(function () {
            // 移动显示
            require(['app/component/Extent'],function (extent) {
                extent.init(mapDEMO.map);
            })
        })
         $("a[name='ZoomTo']").click(function () {
            // 缩放
            require(['app/component/ZoomTo'],function (zoomto) {
                zoomto.init(mapDEMO.map);
            })
        })
         $("a[name='Mouse']").click(function () {
            // 鼠标事件
            require(['app/component/Mouse'],function (mouse) {
                mouse.init(mapDEMO.map);
            })
        })
         $("a[name='Transform']").click(function () {
            // 地名地址转换
            require(['app/component/Transform'],function (transform) {
                transform.init(mapDEMO.map);
            })
        })
        $("a[name='drawing']").click(function () {
            // 点线面渲染
            require(['app/component/drawing'],function (drawing) {
                drawing.init(mapDEMO.map);
            })
        })
        $("a[name='ElementsQuery']").click(function () {
            // 要素查询
            require(['app/component/ElementsQuery'],function (query) {
                query.init(mapDEMO.map);
            })
        })
        $("a[name='BoundaryAndCenter']").click(function () {
            // 区划边界中心点
            require(['app/component/BoundaryAndCenter'],function (query) {
                query.init(mapDEMO.map);
            })
        })
        $("a[name='TimePhase']").click(function () {
            // 多时相
            require(['app/component/TimePhase'],function (timephase) {
                timephase.init(mapDEMO.map);
            })
        })
        $("a[name='Pie_graph']").click(function () {
            //图标饼图
            require(['app/graphThemeLayer/GraphPie'],function (graphpie) {  //graphpie参数可作为引用js的一个实例对象
                graphpie.init(mapDEMO.map);
            })
        })
        $("a[name='Ext_Pie']").click(function () {
            //图标饼图
            require(['app/graphThemeLayer/ChartPie'],function (chartpie) {  //graphpie参数可作为引用js的一个实例对象
                chartpie.init(mapDEMO.map);
            })
        })
        $("a[name='HeatMap_graph']").click(function () {
            //热力饼图
            require(['app/graphThemeLayer/HeatMap'],function (heatmap) {
                heatmap.init(mapDEMO.map);
            })
        })
        $("a[name='drive_graph']").click(function () {
            //驾车线路
            require(['app/routePlanning/routePlanning'],function (driving) {
                driving.init(mapDEMO.map);
            })
        })
        $("a[name='Weather']").click(function () {
            // 天气查询
            require(['app/component/Weather'],function (weather) {
                weather.init(mapDEMO.map);
            })
        })
        $("a[name='Together']").click(function () {
            // 聚合
            require(['app/component/Together'],function (together) {
                together.init(mapDEMO.map);
            })
        })
        $("a[name='TogetherEx']").click(function () {
            // 聚合
            require(['app/component/TogetherEx'],function (togetherEx) {
                togetherEx.init(mapDEMO.map);
            })
        })
        
        
    }
    return {
        init: initButtonClick
    }
})