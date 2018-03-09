
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/jquery.dataTables

////////////////////////////////////////
///////  Load dependencies here  ///////

// Bootstrap Javascript
//= require twitter/bootstrap/transition
//= require twitter/bootstrap/alert
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/scrollspy
//= require twitter/bootstrap/tab
//= require twitter/bootstrap/tooltip
//= require twitter/bootstrap/popover
//= require twitter/bootstrap/button
//= require twitter/bootstrap/collapse
//= require twitter/bootstrap/carousel
//= require twitter/bootstrap/affix

//= require ckeditor/init

//= require_tree .


(function() {

  $(document).ready(function() {
    RMRichTextArea.load();
    setupTimePeriodOrder();

    $('.datatable-stories').DataTable({
        lengthMenu: [[15, 30, 45, -1], [15, 30, 45, "All"]],
        initComplete: function () {
            this.api().columns().every( function () {
                var column = this;
                if ($(column.header()).hasClass('filter')) {
                  var select = $('<select><option value="">ALL</option></select>')
                      .appendTo( $(column.footer()).empty() )
                      .on( 'change', function () {
                          var val = $.fn.dataTable.util.escapeRegex(
                              $(this).val()
                          );

                          column
                              .search( val ? '^'+val+'$' : '', true, false )
                              .draw();
                      } );

                  column.data().unique().sort().each( function ( d, j ) {
                      select.append( '<option value="'+d+'">'+d+'</option>' )
                  } );
                }
            } );
        }
    });
  });
})();


