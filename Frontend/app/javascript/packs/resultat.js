/*
 * @Date: 2021-07-31 20:38:07
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-19 08:19:34
 * @FilePath: /Frontend/app/javascript/packs/resultat.js
 */
document.addEventListener('turbolinks:load', () => {
    const click1 = document.getElementById("a_per");
    click1.addEventListener('click', (event) => {
        remove_default();
        window.frames['option'].src='per';
    });
    const click2 = document.getElementById("a_cog");
    click2.addEventListener('click', (event) => {
        remove_default();
        window.frames['option'].src='cog';
    });
    const click3 = document.getElementById("a_soc");
    click3.addEventListener('click', (event) => {
        remove_default();
        window.frames['option'].src='soc';
    });
});

function remove_default(){
    const label = document.getElementById("a_cog").nextElementSibling;
    label.classList.remove("default-label");
}