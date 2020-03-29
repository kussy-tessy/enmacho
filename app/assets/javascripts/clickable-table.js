$(document).on('click', '.card-body[data-href]', function(){
    window.location.href = $(this).data('href');
});