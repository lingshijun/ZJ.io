 /** commodity search result page js. qiang.li.li@oracle.com **/
 
 var total_count = 20;
 var selectCount = 0;
 var comoditySelected = "                            <div id=\"commodity_1\" class=\"mt-lg-2 mt-xl-2 mt-md-2\">\n" +
     "                                <div style=\"width: 70%; float:left \">\n" +
     "                                    <!--\n" +
     "                                        <img src=\"../image/penimage250.svg\" class=\"p-0 m-0\"/>\n" +
     "                                     -->\n" +
     "                                    <img class=\"float-left  img-modaldialog-size \"\n" +
     "                                         src=\"https://system.na3.netsuite.com/core/media/media.nl?id=31358&c=4761902&h=eb5857aad80f780cd508&_xt=.svg\"/>\n" +
     "\n" +
     "                                    <div style=\"background: #FFFFFF; height: 80px;  margin-left: 1rem  ; font-size: 14px\">\n" +
     "                                        <div style=\"font-family: Helvetica-Bold ; color:#4D5F79  \">Whiteboard Marker\n" +
     "                                        </div>\n" +
     "                                        <div style=\"font-family: Helvetica ; color:#888888 \" class=\"mb-lg-3 mt-xl-3 \">\n" +
     "                                            <div>\n" +
     "                                                150*30*80\n" +
     "                                            </div>\n" +
     "                                            <div id=\"quantity_modal\">\n" +
     "                                                Quantity: &nbsp;" + total_count + "\n" +
     "                                            </div>\n" +
     "                                        </div>\n" +
     "                                    </div>\n" +
     "                                </div>\n" +
     "                                <div style=\"width: 30%; float: right\" class=\"ml-lg-0 ml-xl-0  pl-lg-0 pl-xl-0 \">\n" +
     "                                    <!--\n" +
     "<img src=\"../image/minus24@2x.png\"  height=\"24px\" width=\"24px\" disabled data-type=\"minus\" data-field=\"quant\"  onclick=\"minus-main()\"/>\n" +
     "-->\n" +
     "                                    <img id=\"minus_modal\"\n" +
     "                                         src=\"https://system.na3.netsuite.com/core/media/media.nl?id=31561&c=4761902&h=add124084d1be6dbb959\"\n" +
     "                                         height=\"24px\" width=\"24px\" onclick=\"clickMinusmodal()\"/>\n" +
     "                                    <span id=\"quant_modal\" class=\"px-md-2 px-lg-2 px-xl-2 pr-md-2 pr-lg-2 pr-xl-2\"\n" +
     "                                          style=\"color: #F56223;\"><span id=\"selected_cnt_per_commodity\">" + 0 + "</span></span>\n" +
     "                                    <!--\n" +
     "                                <img src=\"../image/plus24@2x.png\" height=\"24px\" width=\"24px\"  data-type=\"plus\" data-field=\"quant\"  onclick=\"plus-main()\"/>\n" +
     "                                -->\n" +
     "                                    <img id=\"plus_modal\"\n" +
     "                                         src=\"https://system.na3.netsuite.com/core/media/media.nl?id=31560&c=4761902&h=6ecc4bbd1d3e0d409970\"\n" +
     "                                         height=\"24px\" width=\"24px\" onclick=\"clickPlusmodal()\"/>\n" +
     "                                </div>\n" +
     "\n" +
     "                            </div>";
 
 function clickMinus() {
     selectCount--;
     refreshView()
 }
 
 function clickPlus() {
     selectCount++;
     refreshView()
 }
 
 function clickMinusmodal() {
     selectCount--;
     refreshViewWithmodal()
 }
 
 function clickPlusmodal() {
     selectCount++;
     refreshViewWithmodal()
 }
 
 function removeAllChild() {
     var div = document.getElementById("selected_list");
     while (div.hasChildNodes()) //当div下还存在子节点时 循环继续
     {
         div.removeChild(div.firstChild);
     }
 }
 
 function cleanShoppingCart() {
     selectCount = 0;
     refreshViewWithmodal();
     removeAllChild();
 }
 
 function clickShoppingcart() {
 
 
     if (selectCount > 0) {
         document.getElementById("selected_list").innerHTML = comoditySelected;
         document.getElementById("selected_cnt_per_commodity").innerText = selectCount;
 
         event.preventDefault();
     }
     /** should diaplay the total selected count even it is 0 **/
     document.getElementById("total_selected_modal").innerText = selectCount;
 }
 
 
 function refreshView() {
     if (selectCount <= 0) {
         selectCount = 0;
         document.getElementById("minus").setAttribute("hidden", true);
         document.getElementById("quant").setAttribute("hidden", true);
         document.getElementById("shopcart_badge").setAttribute("hidden", true);
     } else {
         document.getElementById("minus").removeAttribute("hidden");
         document.getElementById("quant").removeAttribute("hidden");
         document.getElementById("shopcart_badge").removeAttribute("hidden");
         document.getElementById("quant").innerHTML = selectCount;
         document.getElementById("shopcart_badge").innerHTML = selectCount;
     }
     event.preventDefault();
 }
 
 function refreshViewWithmodal() {
     if (selectCount <= 0) {
         selectCount = 0;
         document.getElementById("minus_modal").setAttribute("hidden", true);
         document.getElementById("quant_modal").setAttribute("hidden", true);
     } else {
         document.getElementById("minus_modal").removeAttribute("hidden");
         document.getElementById("quant_modal").removeAttribute("hidden");
         document.getElementById("quant_modal").innerHTML = selectCount;
     }
     document.getElementById("total_selected_modal").innerText = selectCount;
     refreshView()
 }
 
<<<<<<< HEAD
=======
 /** navigate to transfer page**/
 function transfer() {
     if (selectCount > 0) {
         goto_transfer_page(selectCount);
     }else{
         alert("Nothing to transfer!");
     }
 }
>>>>>>> 80b07e320c5066d074b1151233768180005ecfdd
