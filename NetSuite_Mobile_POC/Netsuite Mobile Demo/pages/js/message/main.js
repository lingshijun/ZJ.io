/**
 * Created by meiyu on 3/12/2018.
 */


var userId = 1;
var approvalMessageTitle = "Inventory Transfer | Require Your Approval";
var approvedMessageTitle = "Inventory Transfer | Approved";
var addMessageSuitelet = "https://forms.na3.netsuite.com/app/site/hosting/scriptlet.nl?script=365&deploy=1&compid=4761902&h=61a69ac5dcc90374a329";
var updateMessageStatusSuitelet = "https://forms.na3.netsuite.com/app/site/hosting/scriptlet.nl?script=364&deploy=1&compid=4761902&h=310ce2adb74f969a122b";
var queryMessageJSONPSuitelet="https://forms.na3.netsuite.com/app/site/hosting/scriptlet.nl?script=367&deploy=1&compid=4761902&h=8104bb94f477f099d404";

var unreadIcon = "btn-circle";
var readIcon = "btn-circle-gray";
var selectedMessageIndex = -1;

var currency="$";


var messageTitle = '<a href="#" class="list-group-item"  style="padding-top: 0rem;" onclick="selectMessage(_POC_MESSAGE_DATAS_INDEX_)">' +
    '<div class="left">' +
    '<button type="button" class="btn btn-danger _POC_MESSAGE_ICON_"><i class="glyphicon glyphicon-heart"></i> </button>' +
    '<label >_POC_MESSAGE_TITLE_</label>' +
    '</div>' +
    '<div class="right">' +
    '<div style="float: left"> from:<label>_POC_MESSAGE_SENDER_NAME_</label></div>' +
    '<div style="float: right;">_POC_MESSAGE_SENDER_TIME_</div>' +
    '</div>' +
    '</a>';

var itemImageDiv = ' <div class="col-xl-3">' +
    '     <div class="thumbnail" style = "border: none;display:flex;align-items:center;justify-content:left;" >' +
    '        <div style = "float: left;" >' +
    '          <img src = "https://system.na3.netsuite.com/core/media/media.nl?id=31178&c=4761902&h=1fd690faacfcc7e176f3"  >' +
    '        </div>' +
    '        <div style = "float:left;padding-left: 1rem;" >' +
    '          <label > X 1 < /label >' +
    '        </div >' +
    '     </div>' +
    '</div>';


var inventoryTransferCardBody = '<div class="card-body"  >' +
    '<div style="color: #496387;font-weight: bold;" id="divFromLocationName"> _POC_TRANSFER_FROM_LOCATION_NAME_</div>' +
    '<div class="row" style="padding-top: 1rem;">' +
    '<div class="col-xl-3">' +
    '<div class="thumbnail" style="border: none;display:flex;align-items:center;justify-content:left;">' +
    '<div style="float: left;">' +
    '<img id="itemImageSrc" src="_POC_TRANSFER_ITEM_IMAGE_SRC_" alt="">' +
    '</div>' +
    '<div style="float:left;padding-left: 1rem;">' +
    '<label>X <label id="lbItemTransferNum">_POC_TRANSFER_ITEM_NUM_</label></label>' +
    '</div>' +
    '</div>' +
    '</div>' +
    '</div>' +
    '</div>' +
    '</div>';


var approvalItemCardBody = '<div class="card-body" style="padding-bottom: 0rem;">' +
    '<div class="location-name" id="divRightApprovalFromLocationName">_POC_APPROVAL_FROM_LOCATION_NAME_</div>' +
    '<div class="location-address" id="divRightApprovalFromLocationAddress">_POC_APPROVAL_FROM_LOCATION_ADDRESS_</div>' +
    '<hr class="my-2">' +
    '<div class="thumbnail thumbnail-custom">' +
    '<div class="thumbnail-left">' +
    '<img id="divRightApprovalItemImageSrc" src="_POC_APPROVAL_ITEM_IMAGE_SRC_">' +
    '</div>' +
    '<div class="thumbnail-right">' +
    '<div id="divRightDetailItemName">' +
    '<p  class="item-name">_POC_APPROVAL_ITEM_NAME_</p>' +
    '<p class="item-size">_POC_APPROVAL_ITEM_SIZE_</p>' +
    '</div>' +
    '<div  class="approve-div-total-data">' +
    '<div class="left" >' +
    '<label>Required Quantity: <label>_POC_APPROVAL_ITEM_TRANSFER_COUNT_</label></label> <label style="padding-left: 1rem;">Quantity on Hand: <label>_POC_APPROVAL_ITEM_QUANTITY_ON_HAND_</label></label>' +
    '</div>' +
    '<div class="right" >' +
    '<label>Transfer Price: <label>_POC_APPROVAL_ITEM_TRANSFER_PRICE_</label></label>' +
    '</div>' +
    '</div>' +
    '</div>' +
    '</div>' +
    '</div>';


var messageDatas = [
    {
        "messageId": "39c4",
        "createDate": "2018-03-13T06:23:05.045Z",
        "recevierId": 2,
        "recevierName": "manager",
        "senderId": 1,
        "senderName": "clerk",
        "type": 2,
        "title": "Inventory Transfer Application",
        "content": "",
        "status": 1,
        "approvalStatus": 0,
        "hasApproved": 0,
        "approvalComments": "",
        "inventoryTransfers": [
            {
                "fromLocation": "2",
                "fromLocationName": "Qumei Furniture China(SanYuan Qiao)",
                "fromLocationAddress": "1312 E Gebeva St, Haidian District, Beijing SanYuan Qiao China",
                "toLcation": "3",
                "toLcationName": "Qumei Furniture China(WangJing)",
                "items": [
                    {
                        "itemId": "13",
                        "itemName": "Red Whiteboard Marker - Nova",
                        "itemImage": "https://system.na3.netsuite.com/core/media/media.nl?id=31054&c=4761902&h=3544b0027c786194469e",
                        "itemDescription": "Red Whiteboard Marker - Nova",
                        "quantityOnHand": "2,816.0",
                        "adjustCount": "2.0",
                        "transfer Price": ""
                    }
                ]
            },
            {
                "fromLocation": "6",
                "fromLocationName": "Qumei Furniture China : ShangDi",
                "fromLocationAddress": "",
                "toLcation": "3",
                "toLcationName": "Qumei Furniture China(WangJing)",
                "items": [
                    {
                        "itemId": "13",
                        "itemName": "Red Whiteboard Marker - Nova",
                        "itemImage": "https://system.na3.netsuite.com/core/media/media.nl?id=31054&c=4761902&h=3544b0027c786194469e",
                        "itemDescription": "Red Whiteboard Marker - Nova",
                        "quantityOnHand": "-18.0",
                        "adjustCount": "4.0",
                        "transfer Price": ""
                    }
                ]
            }
        ]
    },
    {
        "messageId": "4",
        "createDate": "2018-03-12T06:23:05.045Z",
        "recevierId": 2,
        "recevierName": "manager",
        "senderId": 5,
        "senderName": "Meihua Yu",
        "type": 1,
        "title": "Stock Take Result",
        "content": "",
        "status": 2
    },
    {
        "messageId": "3",
        "createDate": "2018-03-12T06:23:05.045Z",
        "recevierId": 2,
        "recevierName": "manager",
        "senderId": 4,
        "senderName": "Sabrina Zhi",
        "type": 1,
        "title": "Company Notice",
        "content": "",
        "status": 1
    },
    {
        "messageId": "2",
        "createDate": "2018-03-12T06:23:05.045Z",
        "recevierId": 2,
        "recevierName": "manager",
        "senderId": "4",
        "senderName": "Sabrina Zhi",
        "type": 2,
        "title": "Inventory Transfer Request",
        "content": "",
        "status": 2,
        "approvalStatus": 0,
        "hasApproved": 0,
        "approvalComments": ""
    },
    {
        "messageId": "1",
        "createDate": "2018-03-12T05:23:05.045Z",
        "recevierId": 2,
        "recevierName": "manager",
        "senderId": 3,
        "senderName": "Chuan Tian",
        "type": 1,
        "title": "Company Notice",
        "content": "",
        "status": 2
    }
];


$(document).ready(function () {
    refreshUserId();
    queryMessage();
    //queryData();

    // alert("window.screen.availHeight:"+window.screen.availHeight);
    $('#btnDetail').click(function () {
        clickDetail();
    });

    $('#btnReject').click(function () {
        clickReject();
    });

    $('#btnApprove').click(function () {
        clickApprove();
    });


});


function refreshUserId() {
    var requestParam = getRequestParam();
    userId = requestParam["userId"];
}



function bindData() {

    console.log("messageDatas.length",messageDatas.length);

    for (var i in messageDatas) {
        var messageObj = messageDatas[i];

        var title = messageObj.title;
        var senderName = messageObj.senderName;
        var senderTime = messageObj.createDate;
        var status = messageObj.status;

        var messageTitileHtml = messageTitle;
        messageTitileHtml = messageTitileHtml.replace(/_POC_MESSAGE_DATAS_INDEX_/gi, i);
        messageTitileHtml = messageTitileHtml.replace(/_POC_MESSAGE_TITLE_/gi, title);
        messageTitileHtml = messageTitileHtml.replace(/_POC_MESSAGE_SENDER_NAME_/gi, senderName);

        var tiemForShow = getShowTime(senderTime);
        messageTitileHtml = messageTitileHtml.replace(/_POC_MESSAGE_SENDER_TIME_/gi, tiemForShow);

        var messageIcon = status.toString() == "1" ? unreadIcon : readIcon;
        messageTitileHtml = messageTitileHtml.replace(/_POC_MESSAGE_ICON_/gi, messageIcon);
        $("#divMessageTitleList").append(messageTitileHtml);

    }

    $("#divMessageTitleList").children("a.list-group-item").eq(0).click();
}

function queryMessage(){
    queryMessageFromOC();
}

function queryMessageFromOCCallBack(messages) {
    $("#divMessageTitleList").html("");
    messageDatas = JSON.parse(messages);
    bindData();
}

function queryData(){
    $("#divMessageTitleList").html("");
    $.ajax({
        type: "GET",
        url: queryMessageJSONPSuitelet,
        dataType: "JSON",
        data: {
            "userId":userId
        },
        success: function (result) {
           messageDatas = result;
           alert(messageDatas.length);
            bindData();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
           alert('Query textStatus' + textStatus);
           alert('Query errorThrown' + errorThrown);
           }
    });

}

function getShowTime(time) {
    var tiemForShow = "";
    try {
        var messageTime = new Date(time);
        console.log("messageTime", messageTime);

        var intervalTime = new Date().getTime() - messageTime.getTime();
        // alert("messageTime.getTime():"+messageTime.getTime());
        console.log("intervalTime", intervalTime);
        var intervalDays = Math.floor(intervalTime / (24 * 3600 * 1000));
        if (intervalDays >= 1) {
            tiemForShow = messageTime.toLocaleString();
        } else {
            var leave1 = intervalTime % (24 * 3600 * 1000);    //计算天数后剩余的毫秒数
            tiemForShow = Math.floor(leave1 / (3600 * 1000));

            if (tiemForShow <= 0) {
                tiemForShow = "just now";
            } else {
                tiemForShow += " hours ago";
            }
        }
    } catch (ex) {

    }

    console.log("tiemForShow", tiemForShow);

    return tiemForShow;
}


function selectMessage(messageIndex) {
    // alert(messageIndex);

    try {

        updataLastSelectMessageListIcon(selectedMessageIndex);
        selectedMessageIndex = messageIndex;
        var selectedMessage = messageDatas[messageIndex];

        $("#divMessageTitleList").children(".list-group-item").removeClass("selected");

        $("#divMessageTitleList").children(".list-group-item").eq(messageIndex).addClass("selected");


        $("#divRightApproval").css("display", "none");
        $("#divRightDetail").css("display", "block");
        if (!selectedMessage.inventoryTransfers) {
            $("#divTest").css("display", "block");
            $("#divMessageDetail").css("display", "none");

            return;
        } else {
            $("#divMessageDetail").css("display", "block");
            $("#divTest").css("display", "none");

        }
        showApprovalButton(selectedMessage.hasApproved);

        // alert(selectedMessage);

        $("#divMessageCard").children(".card-body").remove("");

        //var messageTitle = selectedMessage.title;
        var senderTime = selectedMessage.createDate;

        $("#divRightMessageTime").html(new Date(senderTime).toLocaleString());

        var messageTitle = selectedMessage.hasApproved == 1 ? approvedMessageTitle:approvalMessageTitle;
        $("#divRightMessageTitle").html(messageTitle);

        var inventoryTransfers = selectedMessage.inventoryTransfers;

        //  alert("inventoryTransfers:"+inventoryTransfers.length);

        var totalCount = 0;
        var totalPrice = 0;

        for (var j in inventoryTransfers) {
            var inventoryTrandferObject = inventoryTransfers[j];

            var fromLocationName = inventoryTrandferObject.fromLocationName;

            // alert("fromLocationName:"+fromLocationName);

            var items = inventoryTrandferObject.items;
            var item1 = items[0];
            var itemImageSrc = item1.itemImage;
            var adjustCount = item1.adjustCount;
            var transferPrice = parseFloat(item1.transferPrice);

            adjustCount = parseInt(adjustCount);

            totalCount += adjustCount;
            totalPrice += transferPrice;

            var inventoryTransferCardBodyhHTML = inventoryTransferCardBody;
            inventoryTransferCardBodyhHTML = inventoryTransferCardBodyhHTML.replace(/_POC_TRANSFER_FROM_LOCATION_NAME_/gi, fromLocationName);
            inventoryTransferCardBodyhHTML = inventoryTransferCardBodyhHTML.replace(/_POC_TRANSFER_ITEM_IMAGE_SRC_/gi, itemImageSrc);
            inventoryTransferCardBodyhHTML = inventoryTransferCardBodyhHTML.replace(/_POC_TRANSFER_ITEM_NUM_/gi, adjustCount);

            // alert("inventoryTransferCardBodyhHTML:"+inventoryTransferCardBodyhHTML);

            $("#divCardFooter").before(inventoryTransferCardBodyhHTML);
        }

        if(!totalPrice){
            totalPrice = "0.0";
        }

        $("#lbTotalTransferCount").html(totalCount);
        $("#lbTotalPrice").html(currency+totalPrice);

    } catch (ex) {

    }
}

function updataLastSelectMessageListIcon(){

    console.log("updataLastSelectMessageListIcon selectedMessageIndex",selectedMessageIndex);
    if(selectedMessageIndex < 0){
        return;
    }

    var lastSelectedMessage = messageDatas[selectedMessageIndex];

    $("#divMessageTitleList").children(".list-group-item.selected").eq(0).children().eq(0).children().eq(0).removeClass("btn-circle").addClass("btn-circle-gray");

    if(lastSelectedMessage.status == 1){
        lastSelectedMessage.status = 2; // 1:unreand;2:read
        updateMessageToRead(lastSelectedMessage);
    }else{
      //  alert("no need to updated");
    }
}

function showApprovalButton(hasApproved) {
    var visibility = "visible";
    hasApproved = (hasApproved == 1) ? true:false;
    if (hasApproved ) {
        visibility = "hidden";
    }
    // alert("visibility:"+visibility);
    $('#divApprovalButton').css("visibility", visibility);
}

function clickDetail() {
    // alert("come in ");
    $("#divRightApproval").css("display", "block");
    $("#divRightDetail").css("display", "none");
    $("#divApprovalCard").children(".card-body").remove("");

    var displayStatus = "none";


    showApprovalDIV();

}


//approval div related

function showApprovalDIV(selectedMessage) {

    var selectedMessage = messageDatas[selectedMessageIndex];

    var messageTitle = selectedMessage.title;
    var senderTime = selectedMessage.createDate;

    $("#divRightApprovalTime").html(new Date(senderTime).toLocaleString());
    $("#divRighApprovalTitle").html($("#divRightMessageTitle").html());
    $("#lbApprovalResult").html("");

    var inventoryTransfers = selectedMessage.inventoryTransfers;

    var approvalComments = selectedMessage.approvalComments;
    approvalComments = approvalComments.replace(/<br\/>/g,"\n").replace(/\&nbsp\;/g," ");
    $("#txtApproval").val(approvalComments);

    for (var j in inventoryTransfers) {
        var inventoryTrandferObject = inventoryTransfers[j];

        var fromLocationName = inventoryTrandferObject.fromLocationName;
        var fromLocationAddress = inventoryTrandferObject.fromLocationAddress;
        console.log("fromLocationAddress",fromLocationAddress);

        var approvalItemCardBodyhHTML = approvalItemCardBody;
        approvalItemCardBodyhHTML = approvalItemCardBodyhHTML.replace(/_POC_APPROVAL_FROM_LOCATION_NAME_/gi, fromLocationName);
        approvalItemCardBodyhHTML = approvalItemCardBodyhHTML.replace(/_POC_APPROVAL_FROM_LOCATION_ADDRESS_/gi, fromLocationAddress);

        var items = inventoryTrandferObject.items;
        var item1 = items[0];
        var itemImageSrc = item1.itemImage;
        var itemName = item1.itemName;
        var itemSize = item1.itemDescription;
        var adjustCount = item1.adjustCount;
        var quantityOnHand = item1.quantityOnHand;
        var transferPrice = item1.transferPrice;
        if(!transferPrice){
            transferPrice = "0.0";
        }

        adjustCount = parseInt(adjustCount);
        approvalItemCardBodyhHTML = approvalItemCardBodyhHTML.replace(/_POC_APPROVAL_ITEM_IMAGE_SRC_/gi, itemImageSrc);
        approvalItemCardBodyhHTML = approvalItemCardBodyhHTML.replace(/_POC_APPROVAL_ITEM_NAME_/gi, itemName);
        approvalItemCardBodyhHTML = approvalItemCardBodyhHTML.replace(/_POC_APPROVAL_ITEM_SIZE_/gi, itemSize);
        approvalItemCardBodyhHTML = approvalItemCardBodyhHTML.replace(/_POC_APPROVAL_ITEM_TRANSFER_COUNT_/gi, adjustCount);
        approvalItemCardBodyhHTML = approvalItemCardBodyhHTML.replace(/_POC_APPROVAL_ITEM_QUANTITY_ON_HAND_/gi, quantityOnHand);
        approvalItemCardBodyhHTML = approvalItemCardBodyhHTML.replace(/_POC_APPROVAL_ITEM_TRANSFER_PRICE_/gi, currency+transferPrice);

        $("#divApprovalCardFooter").before(approvalItemCardBodyhHTML);

    }
}


function clickReject() {
    var rejectReason = $("#txtApproval").val();
    if (!rejectReason) {
        $("#lbApprovalResult").html("Please write reject reason");
    } else {
        $("#lbApprovalResult").html("rejected");
    }
}


function clickApprove() {

    var approvalReason = $("#txtApproval").val();

    var selectedMessage = messageDatas[selectedMessageIndex];

    var approvalStatus=1;

    var newMessage = {
        "recevierId": selectedMessage.senderId,
        "recevierName": selectedMessage.senderName,
        "senderId": selectedMessage.recevierId,
        "senderName": selectedMessage.recevierName,
        "type": 2,
        "title": approvedMessageTitle,
        "content": "",
        "status": 1,
        "hasApproved": 1,
        "approvalStatus":approvalStatus,
        "approvalComments": approvalReason,
        "inventoryTransfers":selectedMessage.inventoryTransfers
    };

    var newMessageData = JSON.stringify(newMessage);
    console.log("dataToSend", newMessageData);
    addMessage(newMessageData);

    selectedMessage.status =2;
    selectedMessage.hasApproved = 1;
    selectedMessage.approvalComments = approvalReason;
    selectedMessage.approvalStatus = approvalStatus;
    updateMessageToRead(selectedMessage);

    $("#lbApprovalResult").html("approved");

}

function addMessage(newMessageData){
    var  newMessage = {
        "messageData": newMessageData
    }
    sendAjax(addMessageSuitelet,newMessage,'add');
}
function updateMessageToRead(message){

    var updateMessage = {
        "messageId": message.messageId,
        "status":2, // 1:unreand;2:read
        "hasApproved":message.hasApproved,
        "approvalStatus":message.approvalStatus,
        "approvalComments":message.approvalComments
    };
    sendAjax(updateMessageStatusSuitelet, updateMessage,'update');
}

function sendAjax(url, data,operateType) {
    $.ajax({
        type: "GET",
        url: url,
        //dataType: 'jsonp',
        //jsonpCallback: operateType+'callback',
        data: data,
        success: function (result) {
           //alert(operateType+" "+result);
        },
        error: function (result) {
            alert(operateType +' Error' + result);
        }
    });
}



function getRequestParam() {

    var requestParam = new Array();

    var url = window.location.search;
    //alert("window.location.search:"+window.location.href);
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for (var i = 0; i < strs.length; i++) {

            if (strs.length - 1 == i) {
                requestParam[strs[i].split("=")[0]] = unescape(
                    strs[i].split("=")[1]).split(".html")[0];
            } else {
                requestParam[strs[i].split("=")[0]] = unescape(strs[i]
                    .split("=")[1]);
            }
        }
    }
    return requestParam;
}
