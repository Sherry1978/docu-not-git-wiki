(function($) {
  
  function initaliseShowPage(){
    function edit(){
      window.location.pathname = window.location.pathname+'/edit';
    }
    $(window)
      .bind("dblclick", edit)
      .keydown(function(event){
        if (event.keyCode == 69 && event.metaKey){
          edit();
          return false;
        }
      });
  }
  
  function initaliseEditPage(){
    var save_button = $('form#edit .save');
    var textarea    = $('#editor textarea');
    var preview     = $('#preview');
    var saved_value = textarea.val();
    
    textarea.focus();
    
    function updatePreview(){
      $.post("/preview", { 'body': textarea.val() }, function(a,b){
        preview.html(a);
      });      
    }
    
    function save(){
      $.post($('form#edit').attr('action'), {body:textarea.val()});
      console.log('SAVED');
    }
    
    function saveAndClose(){
      save_button.removeAttr('disabled');
      save_button.click();
    }
    
    textarea.keyup(function(){
      if (saved_value == textarea.val()){
        save_button.attr('disabled',true);
      }else{
        save_button.removeAttr('disabled');
        updatePreview();
      }
      
    });
    
    $(window).keydown(function(event){
      if (event.keyCode == 83 && event.metaKey){
        if (event.shiftKey){
          save();
        }else{
          saveAndClose();
        }
        return false;
      }
    });
    
  }
  

  $(document).ready(function(){
    var page = $('#page');
    if (page.hasClass('show')) initaliseShowPage();
    if (page.hasClass('edit')) initaliseEditPage();
  });

})(jQuery);