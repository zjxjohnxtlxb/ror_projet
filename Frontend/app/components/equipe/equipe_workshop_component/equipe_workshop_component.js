/*
 * @Date: 2021-08-21 19:33:36
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-25 16:58:52
 * @FilePath: /Frontend/app/components/equipe/equipe_workshop_component/equipe_workshop_component.js
 */

$(window).on('turbolinks:load', function () {
    $(() => {
        $('<i class="bi bi-x-square-fill"></i>').appendTo($('.equipe-emp > div'));
        $('.equipe-emp > div > i[class~= "bi-x-square-fill"]').on('click', (event) => {
            event.target.parentNode.remove();
        });
        $('<i class="bi bi-x-square"></i>').appendTo($('.eqp > .card-header'));
        $('.eqp > .card-header > i[class~= "bi-x-square"]').on('click', (event) => {
            let id = $(event.target.parentNode.parentNode.parentNode).find('input[name="equipe[id]"]').val();
            event.target.parentNode.parentNode.remove();
            $.ajax({
                url: '/delete_equipe/'+id,
                type: 'DELETE',
                success: function(result) {
                   alert("success delete !");
                }
            });
        });
    });
    $('.emp > div').draggable({
        revert: "invalid",
        containment: "window",
        helper: 'clone',
        cursor: "move",
        start: function (event, ui) {
            $(this).addClass('dragged');
        },
        stop: function (event, ui) {
            $(this).removeClass('dragged');
        }
    });
    $('.equipe-emp').droppable({
        accept: '.emp > div',
        activeClass: 'active',
        drop: function (event, ui) {
            let item = ui.draggable.clone().css('position', 'static');
            if (!$(this).has('#' + ui.draggable.attr('id')).length) {
                item.appendTo($(this));
                $('<i class="bi bi-x-square-fill"></i>').appendTo(item);
                item.find('i[class~= "bi-x-square-fill"]').on('click', () => {
                    item.remove();
                });
            }
        }
    });
})