/*
 * @Date: 2021-08-06 09:29:36
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-09 12:02:50
 * @FilePath: /Frontend/app/javascript/packs/redirect.js
 */
window.addEventListener("turbolinks:load", function () {
    var check_redirect_to = document.getElementById("container");
    window.onload = function () {
        if (check_redirect_to.dataset.source == "true") {
            window.parent.location.reload();
        };
        if (check_redirect_to.dataset.referrer == "true") {
            setTimeout(function(){
                window.parent.location.reload();
             }, 5000);
        };
    };
}, false);