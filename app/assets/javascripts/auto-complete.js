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

  if(name.length * twitter.length == 0) return;
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