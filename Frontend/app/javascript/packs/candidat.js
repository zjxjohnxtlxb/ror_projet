/*
 * @Date: 2021-07-31 15:38:35
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-09-02 12:09:57
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
    const click1 = document.getElementById("profil");
    click1.addEventListener('click', (event) => {
        window.parent.location.hash = "";
        window.parent.location.hash = "#profil";
    });
}, false);