var autoComplete = autoComplete || {};

autoComplete.personChain = (params) => {
  const name = $(params.name);
  const twitter = $(params.twitter); 
  const nameUrl = params.nameUrl;
  const nameVal = params.nameVal;
  const twitterUrl = params.twitterUrl;
  const twitterVal = params.twitterVal;
  const displayVal = params.displayVal;
  const onSelected = params.onSelected;

  // if(name.length * twitter.length == 0) return;
  name.autocomplete({
    source: nameUrl,
    delay: 100,
    minLength: 1,
    focus: (event, ui) => {
      name.val(ui.item[nameVal]);
      // if(twitter.val() === '') parent.val(ui.item[twitterVal]);
      return false;
    },
    select: (event, ui) => {
      name.val(ui.item[nameVal]);
      if(twitter.val() === '') twitter.val(ui.item[twitterVal]);
      onSelected(name, twitter);
      return false;
    }
  }).data("ui-autocomplete")._renderItem = (ul, item) => {
    return $("<li>").attr("data-value", item.name).data("ui-autocomplete-item", item).append("<a>" + item[displayVal] + "</a>").appendTo(ul);
  };

  twitter.autocomplete({
    source: twitterUrl,
    delay: 100,
    minLength: 1,
    focus: (event, ui) => {
      twitter.val(ui.item[twitterVal]);
      // if(child.val() === '') parent.val(ui.item.name);
      return false;
    },
    select: (event, ui) => {
      twitter.val(ui.item[twitterVal]);
      if(name.val() === '') name.val(ui.item[nameVal]);
      onSelected(name, twitter)
      return false;
    }
  }).data("ui-autocomplete")._renderItem = function(ul, item) {
    return $("<li>").attr("data-value", item.name).data("ui-autocomplete-item", item).append("<a>" + item[displayVal] + "</a>").appendTo(ul);
  };
}

// キャラクター関係
autoComplete.characterWorkChain = (params) => {
  const character = $(params.character);
  const work = $(params.work); 
  const characterUrl = params.characterUrl;
  const characterVal = params.characterVal;
  const workUrl = params.workUrl;
  const workVal = params.workVal;
  const characterDisplayVal = params.characterDisplayVal;
  const onSelected = params.onSelected;

  // if(name.length * twitter.length == 0) return;
  character.autocomplete({
    source: characterUrl,
    delay: 100,
    minLength: 1,
    focus: (event, ui) => {
      character.val(ui.item[characterVal]);
      // if(twitter.val() === '') parent.val(ui.item[twitterVal]);
      return false;
    },
    select: (event, ui) => {
      character.val(ui.item[characterVal]);
      if(work.val() === '') work.val(ui.item.work[workVal]);
      return false;
    }
  }).data("ui-autocomplete")._renderItem = (ul, item) => {
    return $("<li>").attr("data-value", item.name).data("ui-autocomplete-item", item).append("<a>" + item[characterDisplayVal] + "</a>").appendTo(ul);
  };

  work.autocomplete({
    source: workUrl,
    delay: 100,
    minLength: 1,
    focus: (event, ui) => {
      work.val(ui.item[workVal]);
      // if(child.val() === '') parent.val(ui.item.name);
      return false;
    },
    select: (event, ui) => {
      work.val(ui.item[workVal]);
      return false;
    }
  }).data("ui-autocomplete")._renderItem = function(ul, item) {
    return $("<li>").attr("data-value", item.name).data("ui-autocomplete-item", item).append("<a>" + item[workVal] + "</a>").appendTo(ul);
  };
}

// 工房関係
$(function(){
  $('#factoryId').on('change',function(){
    console.log('Hi');
    const val = $(this).val();
    $.get({
      url: '/factories/bases.json',
      dataType: 'json',
      data: {
      factory_id: val
      }
    }).done(function(data){
      $('#baseId option').remove();
      $('#baseId').append($('<option>').text('').attr('value',''));
      $.each(data, function(id, base){
        $('#baseId').append($('<option>').text(base.name).attr('value',base.id));
      })
    });
  });
});