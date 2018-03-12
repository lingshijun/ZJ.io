function getParamFromURL(key) {
    alert(1234)
    var url_string = window.location.href;
    var url = new URL(url_string);
    var result = url.searchParams.get(key);
    //console.log(result);
    return result;
}
