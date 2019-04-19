// remove this if cms provides a $ object on its own
window.$ = require('jquery');

$(function () {
    let updateMaxHeight = function () {
        let targets = $('[data-update-max-height]');

        targets.each(function () {
            let $this = $(this),
                totalChildHeight = 0;

            $this.children().each(function () {
                let $this = $(this);
                totalChildHeight += $this.outerHeight(true);
            })

            this.style.setProperty('--expand-max-height', totalChildHeight + 'px');
        });
    }

    $(window).resize(function () {
        updateMaxHeight();
    });

    updateMaxHeight();
})