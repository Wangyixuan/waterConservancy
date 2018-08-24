/**
 * Created by lyuwei on 2017/10/26.
 */
requirejs.config({
//     define– 该函数用户创建模块。每个模块拥有一个唯一的模块ID，它被用于RequireJS的运行时函数，define函数是一个全局函数，不需要使用requirejs命名空间.
//     require– 该函数用于读取依赖。同样它是一个全局函数，不需要使用requirejs命名空间.
//     config– 该函数用于配置RequireJS.     require.config配置参数选项
//      baseUrl——用于加载模块的根路径。
//      paths——用于映射不存在根路径下面的模块路径。
//      shims——配置在脚本/模块外面并没有使用RequireJS的函数依赖并且初始化函数。假设underscore并没有使用  RequireJS定义，但是你还是想通过RequireJS来使用它，那么你就需要在配置中把它定义为一个shim。
//      deps——加载依赖关系数组
    paths: {
        // 定义项目主目录入口
        app: 'app',
        data: 'data',
        // es6模块引入相关
        es6: 'libs/requirePlugins/es6',
        babel: 'libs/requirePlugins/babel-5.8.34.min',
        // 定义框架库相关路径
        "jquery": "libs/jquery-2.1.1",
        "jquery.bootstrap": "libs/bootstrap.min",
        "jquery.inspinia": "libs/inspinia",
        "jquery.pace": "libs/plugins/pace/pace.min",
        "jquery.metisMenu": "libs/plugins/metisMenu/jquery.metisMenu",
        "jquery.slimscroll": "libs/plugins/slimscroll/jquery.slimscroll.min",
        "jquery.jsTree": "libs/plugins/jsTree/jstree",
        "jquery.layer": "libs/plugins/layer/layer",
        "jquery.bootstrap.switch": "libs/plugins/bootstrap-switch/bootstrap-switch",

        "openlayer": "libs/ol-debug",
        "supermap.AJ": "libs/supermap/AJLib.min",
        "supermap.iclient9D": "libs/supermap/iclient9-openlayers.min",
    },
    map: {
        '*': {
            'css': 'libs/requirePlugins/css'
        }
    },
    shim: {
        "jquery.bootstrap": { deps: ["jquery"] },
        "jquery.metisMenu": { deps: ["jquery"] },
        "jquery.inspinia": { deps: ["jquery","jquery.bootstrap","jquery.metisMenu"] },
        "jquery.pace": { deps: ["jquery"] },
        "jquery.slimscroll": { deps: ["jquery"] },
        "jquery.jsTree": { deps: ["jquery","css!libs/plugins/jsTree/themes/default/style.css"] },
        "jquery.layer": { deps: ["jquery","css!libs/plugins/layer/theme/default/layer.css"] },
        "jquery.bootstrap.switch": { deps: ["jquery","jquery.bootstrap","css!libs/plugins/bootstrap-switch/bootstrap-switch.css"] },
        "supermap.iclient9D": { deps:["openlayer",'css!libs/supermap/iclient9-openlayers.min.css'] },
        "supermap.AJ": { deps:["supermap.iclient9D",'css!libs/supermap/AJLib.min.css'] }
    }
});

// require(["module/name", ...], function(params){ ... });
require([
    "jquery",
    "openlayer",
    "jquery.pace",
    "supermap.AJ",
    "jquery.bootstrap",
    "jquery.inspinia",
    "jquery.metisMenu",
    "jquery.slimscroll",
    "jquery.jsTree",
    "jquery.bootstrap.switch"], function ($,ol,pace) {
    // 初始化将jquery 和 bootstrap等必须的框架加入系统
    // 初始化进度条组件
    pace.start({
        document: false
    });

    // 初始化全局地图变量
    window.mapDEMO = window.mapDEMO || {};
    // 初始化地图分辨率、比例尺等地图必要数据
    mapDEMO.mapOption = mapDEMO.mapOption || {};

    if(!mapDEMO.map){
        mapDEMO.map = new AJMap.Map('mapdiv',{
            // BaseLayer: AJMap,
            ThemeLayers: {
                ZWW_HLHP: false
            },
            defaultControl:{
                layerswitch:true
            }
        });
    }


    // 刷新jstree的方法
    // $('#selectBaseServiceTree_jsTreeDiv').jstree(true).settings.core.data=[{"text":"Root node5"}];
    // $('#selectBaseServiceTree_jsTreeDiv').jstree(true).refresh();

    // 开始主程序
    // 底图树 和 底图树的相关操作方法 开始
    $('#baseMapLayerTree_jsTreeDiv').jstree({
        'core' : {
            "multiple": false,
            'data': [
                {
                    'text' : '公网天地图矢量',
                    'state': {
                        "selected": false
                    },
                    'data': 'DMZ_TDTSL'
                },
                {
                    'text' : '公网天地图影像',
                    'state': {
                        "selected": false
                    },
                    'data': 'DMZ_TDTYX'
                },
                {
                    'text' : '公网天地图地形',
                    'state': {
                        "selected": true
                    },
                    'data': 'DMZ_TDTDX'
                },
                {
                    'text' : '政务网16年遥感影像',
                    'state': {
                        "selected": false
                    },
                    'data': 'ZWW_YGYX'
                },
                {
                    'text' : '集中办公点测试底图',
                    'state': {
                        "selected": false
                    },
                    'data': 'ZWW_CSDT'
                },
                {
                    'text' : '政务网白底底图',
                    'state': {
                        "selected": false
                    },
                    'data': 'ZWW_BDDT'
                }
            ]
        },
        "plugins" : ["checkbox"],
    });
    $('#baseMapLayerTree_jsTreeDiv').jstree(true).getCheckNode = function(full) {
        var tmp = [];
        var checkNodeIdArr = this.get_checked();
        for(var i in checkNodeIdArr){
            var tempNode = this.get_node( checkNodeIdArr[i] );
            if(tempNode.data != null)
                tmp.push( tempNode );
        }
        return tmp;
    };
    // 选中事件
    $('#baseMapLayerTree_jsTreeDiv').on('select_node.jstree', function(event, obj) {
        mapDEMO.map.setBaseLayer(obj.node.data);
    });
    // 取消选中事件
    $('#baseMapLayerTree_jsTreeDiv').on('deselect_node.jstree', function(event, obj) {

    });
    // 初始化树之后使用默认勾选的数据加载对应的底图图层
    // 只有初始化底图图层完成之后才进行初始化专题初始化，专题初始化前提必须要有底图类型
    $("#baseMapLayerTree_jsTreeDiv").on('loaded.jstree',function () {
        initThemesLayerTree();
    })
    // 底图树 和 底图树的相关操作方法 结束
    function initThemesLayerTree() {
        // 加载专题图层
        $('#layer_jstree_div').jstree({
            'core' : {
                'data' : [
                    {
                        'text' : '集中办公点行政区划',
                        'state': {
                            "selected": false
                        },
                        'data': 'ZWW_XZQH'
                    },
                    {
                        'text' : '集中办公点河流湖泊',
                        'state': {
                            "selected": true
                        },
                        'data': 'ZWW_HLHP'
                    },
                    {
                        'text' : '对比用专题图层',
                        'state': {
                            "selected": false
                        },
                        'data': 'ZWW_BJFW'
                    }
                ]
            },
            "plugins" : ["checkbox"],
        });
        $('#layer_jstree_div').jstree(true).getCheckNode = function(full) {
            var tmp = [];
            var checkNodeIdArr = this.get_checked();
            for(var i in checkNodeIdArr){
                var tempNode = this.get_node( checkNodeIdArr[i] );
                if(tempNode.data != null)
                    tmp.push( tempNode );
            }
            return tmp;
        };
        // 选中图层事件
        $('#layer_jstree_div').on('select_node.jstree', function(event, obj) {
            mapDEMO.map.addThemeLayer(obj.node.data, true);
        });
        // 取消选图层中事件
        $('#layer_jstree_div').on('deselect_node.jstree', function(event, obj) {
            mapDEMO.map.removeThemeLayer(obj.node.data);
        });
    }

    //矢量数据
    $('#VectorLayer_jstree_div').jstree({
        'core' : {
            'data' : [
                {
                    'text' : '安监数据',
                    'data': 'AJSJ'
                },
                 {
                    'text' : '流域区划数据',
                    'data': 'LYQH',
					'id': 'LYQH'
                },
                  {
                    'text' : '行政区划数据',
                    'data': 'XZQH',
					'id': 'XZQH'
                }
            ]
        },
        "plugins" : ["checkbox"],
    });

    // 初始化相关工具按钮
    require(['app/initToolButton'],function (initToolButton) {
        initToolButton.init();
    });

    // 行政区划相关功能
     $('#VectorLayer_jstree_div').on('select_node.jstree', function(event, obj) {
        var da = obj.node.data;
        switch( da ){
            case 'AJSJ':
                mapDEMO.map.addVectorThemeLayer( AJMap.VECTORTHEMESLAYER.AJSJ,true);
                break;
            case 'LYQH':
                mapDEMO.map.addQHVectorLayer(
                    AJMap.QHVECTORLAYER.LYQH,
                    [{
                        ids: /\d{6}/,
                        style: {
                            normal: {
                                lineColor: [123,123,123,0.5],
                                fillColor: [123,123,123,0.5],
                                textColor:[0,0,0,1]
                            },
                            mouseon: {
                                lineColor: [123,123,123,1],
                                fillColor: [123,123,123,1],
                                textColor:[0,0,0,1]
                            },
                            selected: {
                                lineColor: [123,123,123,1],
                                fillColor: [123,123,123,1],
                                textColor:[0,0,0,1]
                            }
                        }
                    }]
                );
                break;
            case 'XZQH':
                mapDEMO.map.addQHVectorLayer(
                    AJMap.QHVECTORLAYER.XZQH,
                    [{
                        ids: /\d{6}/,
                        style: {
                            normal: {
                                lineColor: [123,123,123,0.5],
                                fillColor: [123,123,123,0.5],
                                textColor:[0,0,0,1]
                            },
                            mouseon: {
                                lineColor: [123,123,123,1],
                                fillColor: [123,123,123,1],
                                textColor:[0,0,0,1]
                            },
                            selected: {
                                lineColor: [123,123,123,1],
                                fillColor: [123,123,123,1],
                                textColor:[0,0,0,1]
                            }
                        }
                    }]
                );
                break;
        }
     });

     $('#VectorLayer_jstree_div').on('deselect_node.jstree', function(event, obj) {
         var da=obj.node.data;
         switch(da){
            case 'AJSJ':
                mapDEMO.map.removeVectorThemeLayer(AJMap.VECTORTHEMESLAYER.AJSJ);
                break;
            case 'LYQH':
                mapDEMO.map.removeQHVectorLayer(AJMap.QHVECTORLAYER.LYQH);
                break;
            case 'XZQH':
                mapDEMO.map.removeQHVectorLayer(AJMap.QHVECTORLAYER.XZQH);
                break;
         }
     });
    
    var _popup_tips = null;
    function setPopUpTips(pixelEv,featureName) {
        if(!_popup_tips){
            _popup_tips = $('<div id="info" style="position: absolute;"></div>');
            _popup_tips.tooltip({
                animation: false,
                trigger: 'manual'
            });
            $(document.body).append(_popup_tips);
        }
        if (featureName) {
            _popup_tips.css({
                left: pixelEv.originalEvent.x + 'px',
                top: pixelEv.originalEvent.y - 5 + 'px'
            });
            _popup_tips.tooltip('hide')
                .attr('data-original-title', featureName)
                .tooltip('fixTitle')
                .tooltip('show');
        } else {
            _popup_tips.tooltip('hide');
        }
    }

    // --------------测试用-------------------
    var vectorSource = new ol.source.Vector({
        wrapX: false
    });
    var templayer = new ol.layer.Vector({
        source: vectorSource,
    });
    var tempFeature = new ol.Feature({
        geometry: new ol.geom.Point([120.0567808,29.45708631]),
        name: '你好'
    });
    tempFeature.setId('hello1');
    var tempFeature2 = new ol.Feature({
        geometry: new ol.geom.Point([120.3567808,29.55708631]),
        name: '你好2'
    });
    tempFeature.setStyle( new ol.style.Style({
        image: new ol.style.Icon(({
            src: './images/component/coordinatePnt.png'
        }))
    }));



    vectorSource.addFeature(tempFeature);
    mapDEMO.map.getCustomLayerGroup().addLayer(templayer);

    var mouseEvent = mapDEMO.map.getMapMouseEvent();
    mouseEvent.on("AJMouseClick",test);
    function test(e) {
        var features = e.target.data.customFeature;
            var element = '<form class="form-horizontal">' +
                '<div>1</div>'+
                '<div>2</div>'+
                '<div>3</div>'+
                '<div>4</div>'+
                '<div>5</div>'+
                '<div>6</div>'+
                '<div>7</div>'+
            '</form>';
            for(var i=0;i<features.length;i++){
                var feature = features[i];
                var id = feature.id_;
                if(id == undefined) return;
                //此处应该加判断是否存在弹窗
                var overlay = mapDEMO.map.getOverlayById(id);
                if(overlay){
                    if(!overlay.getVisible()){
                        overlay.setVisible(true);
                    }
                }else{
                    overlay = new AJMap.Overlay({
                        id:id,
                        // title:"你好",
                        positioning: 'bottom-center',
                        // positioning:'bottom-left',
                        offset:[-5,-5],
                        content:element,
                        stopEvent: true
                    });
                }
                overlay.setPosition(feature.getGeometry().getCoordinates());
                mapDEMO.map.addOverlay(overlay);
            }
    }

    // --------------测试用-------------------
    // var img = new ol.style.Circle({
    //     radius: 5,
    //     stroke: new ol.style.Stroke({
    //         color:"rgba(0,255,255,1)",
    //         width:1
    //     }),
    //     fill: new ol.style.Fill({
    //         color:"rgba(0,255,255,0.3)"
    //     })
    // });
    // var style = new ol.style.Style({
    //     image: img,
    //     stroke: new ol.style.Stroke({
    //         color:"#fff",
    //         width:1
    //     })
    // });
    // var jhLayer = new ol.layer.jhVectorLayer({
    //     name:'jh',
    //     source:new ol.source.Vector(),
    //     style:style
    // });
    // var feature = new ol.Feature(new ol.geom.Point([118.0567808,30.45708631]));
    // var feature2 = new ol.Feature(new ol.geom.Point([119.0567808,28.45708631]));
    // jhLayer.getSource().addFeature(feature);
    // jhLayer.getSource().addFeature(feature2);
    // mapDEMO.map.addJHLayer(jhLayer);
    //
    // mapDEMO.map.getLayers().getArray()[6].expandPoints(feature,10);
    // mapDEMO.map.getLayers().getArray()[6].expandPoints(feature2,10);

    /*var img = new ol.style.Circle({
        radius: 5,
        stroke: new ol.style.Stroke({
            color:"rgba(0,255,255,1)",
            width:1
        }),
        fill: new ol.style.Fill({
            color:"rgba(0,255,255,0.3)"
        })
    });
    var style = new ol.style.Style({
        image: img,
        stroke: new ol.style.Stroke({
            color:"#fff",
            width:1
        })
    });
    var VectorSource = new ol.source.Vector({

    });
    var VectorLayer = new ol.layer.Vector({
        name:'jh',
        source:vectorSource,
        animationDuration: 700,
        style:style
    });
    mapDEMO.map.addLayer(VectorLayer);
    addFeatures(2000);
    function addFeatures(nb)
    {	var ext = mapDEMO.map.getView().calculateExtent(mapDEMO.map.getSize());
        var feature = new ol.Feature(new ol.geom.Point([118.0567808,30.45708631]));
        var features=[];
        for (var i=0; i<nb; ++i)
        {	features[i]=new ol.Feature(new ol.geom.Point([ext[0]+(ext[2]-ext[0])*Math.random(), ext[1]+(ext[3]-ext[1])*Math.random()]));
            features[i].set('id',i);
        }
        feature.features = features;
        VectorLayer.getSource().clear();
        VectorLayer.getSource().addFeature(feature);
    }
    console.log(VectorLayer);
    var select = new ol.interaction.Select({});
    mapDEMO.map.addInteraction(select);
    select.on("select", selectCluster, select);
    function selectCluster(e) {
        console.log(e);
        if (!e.selected.length) {
            this.clear();
            return;
        }
        var source = mapDEMO.map.getAllAjLayers()[4].getSource();
        var feature = e.selected[0];
        var features = feature.features;
        if (!features || features.length==1) return;
        var center = feature.getGeometry().getCoordinates();
        // Pixel size in map unit
        var pix = mapDEMO.map.getView().getResolution();
        var r = pix * 7 * (0.5 + features.length / 4);
        if (false || features.length <= 10){
            var max = Math.min(features.length, 10);
            for (var i=0; i<max; i++) {
                var a = 2*Math.PI*i/max;
                if (max==2 || max == 4) a += Math.PI/4;
                var p = [ center[0]+r*Math.sin(a), center[1]+r*Math.cos(a) ];
                var cf = new ol.Feature({ 'selectclusterfeature':true, 'features':[features[i]], geometry: new ol.geom.Point(p) });
                source.addFeature(cf);
                var lk = new ol.Feature({ 'selectclusterlink':true, geometry: new ol.geom.LineString([center,p]) });
                source.addFeature(lk);
            }
        }else{
            var max = Math.min (10, features.length);
            var a = 0;
            var r;
            var d = 2*7;
            var fs = new Array();
            var links = new Array();
            var max = Math.min (60, features.length);
            // Feature on a spiral
            for (var i=0; i<max; i++)
            {	// New radius => increase d in one turn
                r = d/2 + d*a/(2*Math.PI);
                // Angle
                a = a + (d+0.1)/r;
                var dx = pix*r*Math.sin(a)
                var dy = pix*r*Math.cos(a)
                var p = [ center[0]+dx, center[1]+dy ];
                var cf = new ol.Feature({ 'selectclusterfeature':true, 'features':[features[i]], geometry: new ol.geom.Point(p) });
                cf.setStyle(features[i].getStyle());
                source.addFeature(cf);
                var lk = new ol.Feature({ 'selectclusterlink':true, geometry: new ol.geom.LineString([center,p]) });
                source.addFeature(lk);
            }
        }
    }*/
    /*var clusterSource=new ol.source.Cluster({
        distance: 40,
        source: new ol.source.Vector()
    });
    console.log(clusterSource);
    var clusterLayer = new ol.layer.AnimatedCluster({
        name: 'Cluster',
        source: clusterSource,
        animationDuration: 700,
        style: getStyle
    });
    console.log(clusterLayer);
    mapDEMO.map.addLayer(clusterLayer);
    addFeatures(2000);
    function addFeatures(nb)
    {	var ext = mapDEMO.map.getView().calculateExtent(mapDEMO.map.getSize());
        var features=[];
        for (var i=0; i<nb; ++i)
        {	features[i]=new ol.Feature(new ol.geom.Point([ext[0]+(ext[2]-ext[0])*Math.random(), ext[1]+(ext[3]-ext[1])*Math.random()]));
            features[i].set('id',i);
        }
        clusterSource.getSource().clear();
        clusterSource.getSource().addFeatures(features);
    }

    var styleCache = {};
    function getStyle (feature, resolution)
    {
        var size = feature.get('features').length;
        var style = styleCache[size];
        if (!style) {
            var color = size>25 ? "192,0,0" : size>8 ? "255,128,0" : "0,128,0";
            var radius = Math.max(8, Math.min(size*0.75, 20));
            var dash = 2*Math.PI*radius/6;
            var dash = [ 0, dash, dash, dash, dash, dash, dash ];
            style = styleCache[size] = new ol.style.Style({
                image: new ol.style.Circle({
                    radius: radius,
                    stroke: new ol.style.Stroke({
                        color: "rgba("+color+",0.5)",
                        width: 15 ,
                        lineDash: dash,
                        lineCap: "butt"
                    }),
                    fill: new ol.style.Fill({
                        color:"rgba("+color+",1)"
                    })
                }),
                text: new ol.style.Text({
                    text: size.toString(),
                    fill: new ol.style.Fill({
                        color: '#fff'
                    })
                })
            });
        }
        return [style];
    }
    var img = new ol.style.Circle({
        radius: 5,
        stroke: new ol.style.Stroke({
            color:"rgba(0,255,255,1)",
            width:1
        }),
        fill: new ol.style.Fill({
            color:"rgba(0,255,255,0.3)"
        })
    });
    var style1 = new ol.style.Style({
        image: img,
        stroke: new ol.style.Stroke({
            color:"#fff",
            width:1
        })
    });
    var selectCluster = new ol.interaction.SelectCluster({});
    /*var selectCluster = new ol.interaction.SelectCluster({
        // Point radius: to calculate distance between the features
        pointRadius:7,
        animate: true,
        // Feature style when it springs apart
        featureStyle: function() {
            return [ style1 ]
        },
        // selectCluster: false,	// disable cluster selection
        // Style to draw cluster when selected
        style: function(f,res) {
            var cluster = f.get('features');
            if (cluster.length>1) {
                var s = getStyle(f,res);
                if ($("#convexhull").prop("checked") && ol.coordinate.convexHull) {
                    var coords = [];
                    for (i=0; i<cluster.length; i++)
                        coords.push(cluster[i].getGeometry().getFirstCoordinate());
                    var chull = ol.coordinate.convexHull(coords);
                    s.push (new ol.style.Style({
                        stroke: new ol.style.Stroke({ color: "rgba(0,0,192,0.5)", width:2 }),
                        fill: new ol.style.Fill({ color: "rgba(0,0,192,0.3)" }),
                        geometry: new ol.geom.Polygon([chull]),
                        zIndex: 1
                    }));
                }
                return s;
            }else {
                return [
                    new ol.style.Style({
                        image: new ol.style.Circle ({
                            stroke: new ol.style.Stroke({ color: "rgba(0,0,192,0.5)", width:2 }),
                            fill: new ol.style.Fill({ color: "rgba(0,0,192,0.3)" }),
                            radius:5
                        })
                    })
                ];
            }
        }
    });*/
    // mapDEMO.map.addInteraction(selectCluster);
});