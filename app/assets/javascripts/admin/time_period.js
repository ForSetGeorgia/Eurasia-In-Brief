function setupTimePeriodOrder() {
  // set the max sort order for a time period
  if($('input#time_period_order').length > 0){
    $('.btn-set-max-order').on('click', function(){
      // get the max order and add it to the input
      $('input#time_period_order').val($(this).data('max-order'));

      return false;
    });
  }

}

