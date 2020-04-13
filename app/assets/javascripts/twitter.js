$(function(){
  $('.tweet-container').each(function(){
    if($(this).data('tweet-id')){
      twttr.widgets.createTweet(
        $(this).data('tweet-id'),
        $(this).get(0),
        {
          lang: 'ja'
        }
      );
    }
  });
});