$(document).ready ->
  $('#note_edit').froalaEditor({
    height: 500;
    toolbarButtons: ['undo', 'redo' , '|', 'bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', 'outdent', 'indent', 'clearFormatting', 'insertTable', 'html'],
    toolbarButtonsXS: ['undo', 'redo' , '-', 'bold', 'italic', 'underline']
  })

  toastr.success('O Bootcamp 2 vai ser incrível')
