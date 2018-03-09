// To generate configuration: http://ckeditor.com/latest/samples/toolbarconfigurator/index.html#basic
// IMPORTANT - creating config here instead of in ckeditor/config.js because
//             the code below that loads the editor does not see the config file
var ckeditor_config = {
  /* Filebrowser routes */
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
  filebrowserBrowseUrl: "/ckeditor/attachment_files",

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
  filebrowserFlashBrowseUrl: "/ckeditor/attachment_files",

  // The location of a script that handles file uploads in the Flash dialog.
  filebrowserFlashUploadUrl: "/ckeditor/attachment_files",

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
  filebrowserImageBrowseLinkUrl: "/ckeditor/pictures",

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
  filebrowserImageBrowseUrl: "/ckeditor/pictures",

  // The location of a script that handles file uploads in the Image dialog.
  filebrowserImageUploadUrl: "/ckeditor/pictures?",

  // The location of a script that handles file uploads.
  filebrowserUploadUrl: "/ckeditor/attachment_files",

  allowedContent: true,

  toolbarGroups: [
    { name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
    { name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
    { name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
    { name: 'forms', groups: [ 'forms' ] },
    { name: 'tools', groups: [ 'tools' ] },
    '/',
    { name: 'styles', groups: [ 'styles' ] },
    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
    { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
    { name: 'links', groups: [ 'links' ] },
    { name: 'insert', groups: [ 'insert' ] },
    '/',
    { name: 'colors', groups: [ 'colors' ] },
    { name: 'others', groups: [ 'others' ] },
    { name: 'about', groups: [ 'about' ] }
  ],

  removeButtons: 'Flash,Table,Smiley,SpecialChar,PageBreak,Save,NewPage,Preview,Print,Templates,Source,SelectAll,Scayt,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,Strike,Subscript,Superscript,CreateDiv,BidiLtr,BidiRtl,Language,Anchor,Styles,Font,TextColor,BGColor,ShowBlocks,About,Find,Replace'

};

var RMRichTextArea = (function() {
  var exports = {};
  var selector = '.js-become-rich-text-editor';

  function removeInstance(editor_id) {
    // Remove any old ckeditor elements from page
    $('.cke_editor_' + editor_id).remove();

    // Remove CKEditor instances from JavaScript
    CKEDITOR.remove(CKEDITOR.instances[editor_id]);
  }

  exports.load = function() {
    // Get already loaded instances
    var loaded_instances = Object.getOwnPropertyNames(CKEDITOR.instances);

    $(selector).each(
      function() {
        var editor_id = $(this).attr('id');

        // Remove CKEditor instance if already loaded.
        // Necessary for compatibility with Turbolinks restoration visits,
        // in which the instances are not removed
        if (loaded_instances.includes(editor_id)) {
          removeInstance(editor_id);
        }

        // Initialize CKEditor instance
        CKEDITOR.replace($(this).attr('id'), ckeditor_config);
      }
    );

  }
  return exports;
})();
