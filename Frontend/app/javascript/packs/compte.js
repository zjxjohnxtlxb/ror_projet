/*
 * @Date: 2021-08-05 20:45:58
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-08 20:55:18
 * @FilePath: /Frontend/app/javascript/packs/compte.jS
 */
window.addEventListener("turbolinks:load", function () {
    var index = 0;
    var html = `<hr>
    <label>Métier</label>
    <input id='parcour[num][metier]' type="text">
    <label>Secteur</label>
    <input id='parcour[num][secteur]' type="text">
    <label>Experiences</label>
    <input id='parcour[num][experiences]' type="text" >`;
    var target = document.getElementById('parcours');
    var target_button = document.getElementById('add-parcours');
    var new_mdp = document.getElementById('newPassword');
    var c_mdp = document.getElementById('password_confirmation');


    function checkForm(form) {

        let pwd1 = document.getElementById('newPassword');
        let pwd2 = document.getElementById('password_confirmation');
        if (pwd1.value != pwd2.value) {
            alert("Error: Please check that you've entered and confirmed your new password!");
            pwd1.focus();
            return false;
        }
        return true;
    }

    var form = document.getElementById('main');
    var nodes = form.querySelectorAll("input");
    for (var i = 0; i < nodes.length; i++) {
        var node = nodes[i];
        node.addEventListener('change', (event) => {
            event.target.setAttribute('name', event.target.id);
            if (event.target.getAttribute('name') == 'utilisateur[password]') {
                if (event.target.value != '') {
                    new_mdp.setAttribute("required", "");
                    c_mdp.setAttribute("required", "");
                }
                else{
                    new_mdp.removeAttribute("required");
                    c_mdp.removeAttribute("required");
                }
            };
        });
    }

    target_button.addEventListener('click', () => {
        var div = document.createElement('div');
        div.setAttribute("id", "new" + index);
        index++;
        var remove_button = document.createElement('button');
        remove_button.className = "options-bouton";
        remove_button.innerHTML = "Remove"
        remove_button.addEventListener('click', () => {
            target.removeChild(div)
            target.removeChild(remove_button)
        });
        target.appendChild(div)
        div.innerHTML = html.replaceAll('[num]', '[' + div.id + ']');
        div.addEventListener("change", (event) => {
            event.target.setAttribute('name', event.target.id);
        });
        target.appendChild(remove_button)
    });

    form.addEventListener('submit', (event) => {
        event.preventDefault()
        if (checkForm(event.target)) {
            event.target.submit();
        } else {
            location.reload();
        }
    });

}, false);