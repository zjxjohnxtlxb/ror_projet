/*
 * @Date: 2021-08-09 15:04:06
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-19 12:07:44
 * @FilePath: /Frontend/app/javascript/packs/jeu.js
 */
document.addEventListener('turbolinks:load', () => {
    const identity = document.getElementById("identity");
    identity.addEventListener('click', (event) => {
        window.location.href = "/jeu/quizz"
    });
    const social = document.getElementById("social");
    social.addEventListener('click', (event) => {
        window.location.href = "/jeu/tower"
    });
    const logic = document.getElementById("logic");
    logic.addEventListener('click', (event) => {
        window.location.href = "/jeu/2048"
    });
    const bitch = document.getElementById("pitch");
    bitch.addEventListener('click', (event) => {
        window.location.href = "/jeu/air_guitar"
    });
});