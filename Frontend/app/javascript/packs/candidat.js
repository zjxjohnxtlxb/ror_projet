/*
 * @Date: 2021-07-31 15:38:35
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-09 12:03:45
 * @FilePath: /Frontend/app/javascript/packs/candidat.js
 */

window.addEventListener("turbolinks:load", function () {
    window.onload = function () {
        if (location.hash !== '') {
            let loc = 'candidat/partiel/' + location.hash.substring(1);
            window.frames['main'].src = loc;
        };
        window.onhashchange = function () {
            if (location.hash !== '') {
                let loc = 'candidat/partiel/' + location.hash.substring(1);
                window.frames['main'].src = loc;
            };
        };
    };
}, false);