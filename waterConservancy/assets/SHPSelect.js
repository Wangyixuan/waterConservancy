/**
 * created by yuanchen on 2018/04/03
 */
define(['jquery.layer'],function (layer) {

    var _thisSHPSelectID = "___ThisSHPSelect";
    var _thisSHPSelectLayer = null;
    var _thismap = null;


    function init(map) {
        // 检查弹出层是否存在，不存在则弹出，存在则直接返回
        if( !!document.getElementById(_thisSHPSelectID) )
            return;
        _thismap = map;
        _thisSHPSelectLayer = null;
        // 检查是否存在导入需要的图层，如果存在则直接清除并使用
        var getLayers = _thismap.getLayersBy( 'id', _thisSHPSelectID );
        if(getLayers.length > 0)
            _thisSHPSelectLayer = getLayers[0];

        if(!_thisSHPSelectLayer){
            // 不存在则初始化相关导入需要使用的图层
            var vectorSource = new ol.source.Vector({
                wrapX: false
            });
            _thisSHPSelectLayer = new ol.layer.Vector({
                source: vectorSource,
            });
            _thisSHPSelectLayer.set('id', _thisSHPSelectID);
            _thismap.getCustomLayerGroup().addLayer(_thisSHPSelectLayer);
        }
        _layerClear();

        // var contentHTML = '<form class="form-group">'
        //     + '<div class="col-xs-12 col-sm-4 col-md-4">'
        //     + '<div class="col-xs-6"><input readonly="readonly"/></div>'
        //     + '<div class="file-container col-xs-6" style="display:inline-block;position:relative;overflow: hidden;vertical-align:middle">'
        //     + '<button class="btn btn-success fileinput-button" type="button" id="fileImport">导入</button>'
        //     + '<input type="file" id="files" style="position:absolute;top:0;left:0;font-size:34px; opacity:0">'
        //     + '</div>'
        //     + '</div>'
        //     + '</form>';
        var contentHTML = '<form class="form-group">'
            + '<div class="col-xs-12">'
            + '<input id="lefile" type="file" style="display:none">'
            + '<div class="input-append col-xs-12 col-sm-12 col-lg-12 col-md-12">'
            + '<input id="fileInput" class="input-large col-xs-8 col-sm-8 col-lg-8 col-md-8" type="text" style="height:33px;" readonly="readonly">'
            + '<a class="btn btn-success " id="fileImport">导入</a>'
            + '</div>'
            + '</div>'
            + '</form>';

        layer.open({
            title: 'GeoJson导入',
            id: _thisSHPSelectID,
            type: 1,
            area: ['500px','300px'],
            resize: false,
            shade: 0,
            offset: ['75px' , '290px'],
            content: contentHTML,
            cancel: _poplayerClose,
            success: _poplayerSuccess
        })
    }

    function _layerClear() {
        _thisSHPSelectLayer.getSource().clear();
    }

    function _poplayerClose(index, layero){
        _layerClear();
        _thismap.getCustomLayerGroup().removeLayer(_thisSHPSelectLayer);
        _thisSHPSelectLayer = null;
        return true;
    }

    function _poplayerSuccess(index, layero) {
        console.log(index, layero);

        $("#lefile").on("change",function () {
            $('#fileInput').val($(this).val());
            //获取读取我文件的File对象
            var selectedFile = document.getElementById('lefile').files[0];
            var name = selectedFile.name;//读取选中文件的文件名
            var size = selectedFile.size;//读取选中文件的大小
            console.log("文件名:"+name+"大小:"+size);

            var reader = new FileReader();//这是核心,读取操作就是由它完成.
            reader.readAsText(selectedFile);
            reader.onload = function () {
                //当读取完成后回调这个函数,然后此时文件的内容存储到了result中,直接操作即可
                // console.log(this.result);
                _getGeoJsonFile(this.result);
            }
        })

        $("#fileImport").click(function () {
            $("#lefile").click();
        });

        // var maptest = new AJMap.Map('maptest',{
        //     ThemeLayers: {
        //         ZWW_BJFW: false
        //     }
        // });
    }

    function _getGeoJsonFile(geojsonString) {
        var geojson = JSON.parse(geojsonString);
        _thisSHPSelectLayer.getSource().addFeatures((new ol.format.GeoJSON()).readFeatures(geojson));
    }

    return {
        init: init
    }
})