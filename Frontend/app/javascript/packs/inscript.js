/*
 * @Date: 2021-07-31 09:30:40
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-07-31 10:54:59
 * @FilePath: /Frontend/app/javascript/packs/inscript.js
 */
function checkForm(form) {
    
    let pwd1 = form.querySelector('input[id="mdp"]');
    let pwd2 = form.querySelector('input[id="co-mdp"]');
    if (pwd1.value != pwd2.value) {
        alert("Error: Please check that you've entered and confirmed your password!");
        pwd1.focus();
        return false;
    }
    return true;
}


document.addEventListener('turbolinks:load', () => {
    const inscript_form = document.getElementById("inscript_form");
    inscript_form.addEventListener('submit', (event) => {
        event.preventDefault()
        if (checkForm(event.target)){
            event.target.submit();
        }
        else {
            location.reload();
        }
    });
});