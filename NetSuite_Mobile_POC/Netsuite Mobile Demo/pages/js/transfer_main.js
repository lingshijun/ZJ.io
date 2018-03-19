function getParamFromURL(key) {
    var url_string = window.location.href;
    var url = new URL(url_string);
    var result = url.searchParams.get(key);
    //console.log(result);
    return result;
}

function makeMapMark(map) {

    // 创建标注对象并添加到地图

    // Sanyuanqiao
    markerSanyuanqiao(map);
    markerZhongguancun(map);
    markerWangjing(map);
}

function markerSanyuanqiao(map) {
    var point = new BMap.Point(116.469697, 39.963364);
    var model = getMapInfoSanyuanqiaoModel();
    marker(map, point, model);
}

function markerZhongguancun(map) {
    var point = new BMap.Point(116.350727, 39.97425);
    var model = getMapInfoZhongguancunModel();
    marker(map, point, model);
}

function markerWangjing(map) {
    var point = new BMap.Point(116.465838, 40.017314);
    var model = getMapInfoWangjingModel();
    marker(map, point, model);
}

function marker(map, point, model) {

    var myIcon = new BMap.Icon('http://api0.map.bdimg.com/images/marker_red_sprite.png', new BMap.Size(23, 25), {});
    var marker = new BMap.Marker(point, {icon: myIcon});

    var opts = {
        width : 450,     // 信息窗口宽度
        height: 180,     // 信息窗口高度
        title : buildMapInfoHeader(model),  // 信息窗口标题
        enableMessage: false
    };
    var infoWindow = new BMap.InfoWindow(
        buildMapInfo(model), opts);  // 创建信息窗口对象
    marker.addEventListener('click', function () {
        map.closeInfoWindow();
        marker.openInfoWindow(infoWindow, map.getCenter());      // 打开信息窗口
    });

    map.addOverlay(marker);
}

function buildScheduleBody(entity, id) {
    // build items
    var itemTemplate = $("#itemTemplate").html();
    //Mustache.parse(itemTemplate); // optional, speeds up future uses
    var itemRendered = Mustache.render(itemTemplate, entity);
    // build card body
    var cardBody = {
        cardBodyItems: itemRendered,
        actionBtn: entity.actionBtn,
        action: entity.action
    };

    var cardBodyTemplate = $("#cardBodyTemplate").html();
    var cardBodyRendered = Mustache.render(cardBodyTemplate, cardBody);

    $("#" + id).html(cardBodyRendered);
}

function buildCollapseOneBodyFromMapInfo(fun, countId) {
    var entity = eval(fun);
    var result = {};

    result.items = [];

    var data = {
        markIndex: entity.markIndex,
        address: entity.address,
        distance: entity.distance,
        count: $("#" + countId).html()
    };
    result.items.push(data);

    result.action = "submitTransfer(count, from)";
    result.actionBtn = "Submit Transfer Application";

    buildScheduleBody(result, "collapseOne");
    $("#collapseOne").collapse('toggle');
    $('#accordion').scrollTop(0);
}

function buildCollapseOneBody(fun) {
    var result = eval(fun);

    result.actionBtn = "Submit Transfer Application";

    buildScheduleBody(result, "collapseOne");
    $("#collapseOne").collapse('toggle');
    $('#accordion').scrollTop(0);
}

function getCollapseTwoModel(count) {
    var localIndex = [2, 1];
    var result = getItemModel(count, localIndex);
    result.action = "buildCollapseOneBody('getCollapseTwoModel(" + count + ")')";
    return result;
}

function getCollapseThreeModel(count) {
    var localIndex = [0, 1];
    var result = getItemModel(count, localIndex);
    result.action = "buildCollapseOneBody('getCollapseThreeModel(" + count + ")')";
    return result;
}

function getCollapseFourModel(count) {
    var localIndex = [2, 1];
    var result = getItemModel(count, localIndex);

    result.items[0].count = count;

    result.items.splice(1, 1);
    result.action = "buildCollapseOneBody('getCollapseFourModel(" + count + ")')";
    return result;
}

function getItemModel(count, localIndex) {
    var entity = getDataFromNS();
    var result = {};

    result.items = [];

    localIndex.forEach(function (index) {
        var data = {
            markIndex: entity[0].availableLocations[index].locationId,
            address: entity[0].availableLocations[index].locationAddress,
            distance: entity.distance[entity[0].availableLocations[index].locationId]
        };
        result.items.push(data);
    });

    var countOne = Math.round(Number(count) * 0.7);
    var countTwo = Number(count) - countOne;

    result.items[0].count = countOne;
    result.items[1].count = countTwo;

    result.actionBtn = "Use this Schedule";
    return result;
}

function buildMapInfo(entity) {
    var mapInfoItemTemplate = $("#mapInfoItemTemplate").html();
    var mapInfoItemRendered = Mustache.render(mapInfoItemTemplate, entity);

    var mapInfoTemplate = $("#mapInfoTemplate").html();
    entity.mapInfoItems = mapInfoItemRendered;
    var mapInfoRendered = Mustache.render(mapInfoTemplate, entity);
    return mapInfoRendered;
}

function buildMapInfoHeader(entity) {
    var headerTemplate = $("#mapInfoTemplateHeader").html();
    var headerRendered = Mustache.render(headerTemplate, entity);
    return headerRendered;
}

function getMapInfoZhongguancunModel() {
    var result =  getModel(5);
    result.addAction = "getMapInfoZhongguancunModel()";
    return result;
}

function getMapInfoSanyuanqiaoModel() {
    var result =  getModel(2);
    result.addAction = "getMapInfoSanyuanqiaoModel()";
    return result;
}

function getMapInfoWangjingModel() {
    var result =  getModel(3);
    result.addAction = "getMapInfoWangjingModel()";
    return result;
}

function getModel(index) {
    var entity = getDataFromNS();

    var shop = undefined;

    entity[0].availableLocations.forEach(function (location) {
        if (location.locationId === index) {
            shop = location;
        }
    });

    var result = {
        addressLocation: shop.locationAddress,
        markIndex: shop.locationId,
        address: shop.locationName,
        distance: entity.distance[shop.locationId],
        mapInfoItems: undefined
    };

    result.items = [
        {
            itemName: "Sofa #1",
            price: "1,200.00",
            size: entity[0].itemSize,
            quantity: "Quantity on hand: " + shop.quantityOnHand,
            uuid: guid()
        }
    ];

    return result;
}

function guid() {
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
        s4() + '-' + s4() + s4() + s4();
}

function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
        .toString(16)
        .substring(1);
}

function plus(id) {
    var element = $('#' + id);
    var value = element.html();
    value = Number(value) + 1;
    element.html(value);
}

function minus(id) {
    var element = $('#' + id);
    var value = element.html();
    if (value > 1) {
        value = Number(value) - 1;
        element.html(value);
    } else {
        element.html(0);
    }
}

function getDataFromNS() {
    var data = [
        {
            "itemId":13,
            "itemSize":"10x20x30",
            "availableLocations":[
                {
                    "locationId":2,
                    "locationName":"Qumei Furniture China",
                    "locationAddress":"Haidian District, Beijing SanYuan Qiao",
                    "latitude":"39.963364",
                    "longitude":"116.469697",
                    "quantityOnHand":866
                },
                {
                    "locationId":3,
                    "locationName":"Qumei Furniture China",
                    "locationAddress":"WangJing",
                    "latitude":"40.017314",
                    "longitude":"116.465838",
                    "quantityOnHand":134
                },
                {
                    "locationId":5,
                    "locationName":"Qumei Furniture China",
                    "locationAddress":"ZhongGuanCun",
                    "latitude":"39.97425",
                    "longitude":"116.350727",
                    "quantityOnHand":0
                },
                {
                    "locationId":6,
                    "locationName":"Qumei Furniture China",
                    "locationAddress":"Shangdi",
                    "latitude":"40.040748",
                    "longitude":"116.314974",
                    "quantityOnHand":0
                }
            ]
        }
    ];

    data.distance = {
        5: 11.5,
        3: 16.5,
        2: 19.7
    };

    return data;
}

function submitTransfer(count, from) {
    var data = [{
        "subsidaryId": 1,
        "fromLocation": from,
        "toLocation": 6,
        "items": [{
            "itemId": 13,
            "adjustCount": count
        }]
    }];
    // Using YQL and JSONP
    $.ajax({
        url: "https://forms.na3.netsuite.com/app/site/hosting/scriptlet.nl?script=361&deploy=1&compid=4761902&h=d6e54650721dae4679ff",

        // The name of the callback parameter, as specified by the YQL service
        jsonp: "callback",

        // Tell jQuery we're expecting JSONP
        dataType: "jsonp",

        // Tell YQL what we want and that we want JSON
        data: {
            "transfers": JSON.stringify(data)
        },
        success: function (result) {
            alert("Submit success;" + result);
        },
        error: function (result) {
            alert('Submit failed' + result);
        },
        complete: function (result) {
            //alert("ajax complete");
        }
    });

}

//根据原始数据计算中心坐标和缩放级别，并为地图设置中心坐标和缩放级别。
function setZoom(map) {
    var points = [
        {"lng":116.469697,"lat":39.963364,"status":1,"id":50},
        {"lng":116.465838,"lat":40.017314,"status":1,"id":2},
        {"lng":116.350727,"lat":39.97425,"status":0,"id":3},
        {"lng":116.314974,"lat":40.040748,"status":0,"id":4}
    ];

    if (points.length > 0) {
        var maxLng = points[0].lng;
        var minLng = points[0].lng;
        var maxLat = points[0].lat;
        var minLat = points[0].lat;
        var res;
        for (var i = points.length - 1; i >= 0; i--) {
            res = points[i];
            if (res.lng > maxLng) maxLng = res.lng;
            if (res.lng < minLng) minLng = res.lng;
            if (res.lat > maxLat) maxLat = res.lat;
            if (res.lat < minLat) minLat = res.lat;
        }

        var cenLng = (parseFloat(maxLng) + parseFloat(minLng)) / 2;
        var cenLat = (parseFloat(maxLat) + parseFloat(minLat)) / 2;
        var zoom = getZoom(map, maxLng, minLng, maxLat, minLat);
        map.centerAndZoom(new BMap.Point(cenLng, cenLat), 12);
    } else {
        //没有坐标，显示全中国
        map.centerAndZoom(new BMap.Point(103.388611, 35.563611), 5);
    }
}

//根据经纬极值计算绽放级别。
function getZoom (map, maxLng, minLng, maxLat, minLat) {
    var zoom = ["50","100","200","500","1000","2000","5000","10000","20000","25000","50000","100000","200000","500000","1000000","2000000"]//级别18到3。
    var pointA = new BMap.Point(maxLng,maxLat);  // 创建点坐标A
    var pointB = new BMap.Point(minLng,minLat);  // 创建点坐标B
    var distance = map.getDistance(pointA,pointB).toFixed(1);  //获取两点距离,保留小数点后两位
    for (var i = 0,zoomLen = zoom.length; i < zoomLen; i++) {
        if(zoom[i] - distance > 0){
            return 18-i+3;//之所以会多3，是因为地图范围常常是比例尺距离的10倍以上。所以级别会增加3。
        }
    }
}