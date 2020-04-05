$(document).on('click', '.clickable', function(){
    window.location.href = $(this).data('href');
});