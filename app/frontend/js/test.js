$(function() {

    $('.js-menu-toggle').click(function(e) {
        var $this = $(this);
        console.log($this)

        $('body').toggleClass('show-sidebar');
        $this.toggleClass('active');

        e.preventDefault();
    });

    $('.js-menu-link-toggle').click(function(e) {
        var $this = $(this);
        console.log($this)
        $('body').toggleClass('show-sidebar');
        $('.burger').toggleClass('active');
        console.log($('.burger'))
    });

    $(document).mouseup(function(e) {
    var container = $(".sidebar");
    if (!container.is(e.target) && container.has(e.target).length === 0) {
        if ( $('body').hasClass('show-sidebar') ) {
                $('body').removeClass('show-sidebar');
                $('body').find('.js-menu-toggle').removeClass('active');
            }
    }
    }); 
});