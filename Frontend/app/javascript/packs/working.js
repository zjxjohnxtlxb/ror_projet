/*
 * @Date: 2021-07-31 08:45:42
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-09 12:34:43
 * @FilePath: /Frontend/app/javascript/packs/working.js
 */
function working(message) {
    let greeting = "Hello, " + message + " !";
    alert(greeting);
}

document.addEventListener('turbolinks:load', () => {
    const clickButtons = document.querySelectorAll(("#working"));
    clickButtons.forEach((clickButton) => {
        clickButton.addEventListener('click', (event) => {
            working('we are working on it')
        })
    });
});