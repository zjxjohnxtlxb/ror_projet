/*
 * @Date: 2021-09-02 11:40:50
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-09-02 12:05:34
 * @FilePath: /Frontend/app/javascript/packs/anchor.js
 */
document.addEventListener('turbolinks:load', () => {
    const click1 = document.getElementById("compte");
    click1.addEventListener('click', (event) => {
        window.parent.location.hash = "#compte";
    });
    const click2 = document.getElementById("cv");
    click2.addEventListener('click', (event) => {
        window.parent.location.hash = "#cv";
    });
    const click3 = document.getElementById("profil");
    click3.addEventListener('click', (event) => {
        window.parent.location.hash = "#profil";
    });
    const click4 = document.getElementById("resultat");
    click4.addEventListener('click', (event) => {
        window.parent.location.hash = "#resultat";
    });
});