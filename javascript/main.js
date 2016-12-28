$(document).ready(function(){
  // this is for jquery actions

  console.log("hello from the jquery file!!");

  // Grab all line links.
  var $links = $("a");

  $links.each(function(){
    var $link = this;

    if ($link.name[0] != 's') {
      // add anchor tag to line for line number.
      var $anchorTag = "<a class='anchor-line-link' href='#"+ $link.name + "'>" + $link.name + "</a>";
      $($anchorTag).insertAfter($($link));
    }
  })

})();
