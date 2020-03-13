$(document).on('click', 'tbody tr[data-href]', function(){
    console.log('hhh');
    window.location.href = $(this).data('href');
});