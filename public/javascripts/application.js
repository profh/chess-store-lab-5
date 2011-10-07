$(function(){
  $('tr').live('click', function(){
    $tr = $(this);
    
    if($tr.attr('href')) {
      $tr.css({'cursor':'pointer'});
      window.location.href = $tr.attr('href');
      return false;
    }
  });
});