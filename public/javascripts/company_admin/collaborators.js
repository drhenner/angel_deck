var Hadean = window.Hadean || { };

// If we already have the Appointments namespace don't override
if (typeof Hadean.Collaborators == "undefined") {
    Hadean.Collaborators = {};
}
var kk = null;
// If we already have the Appointments object don't override
if (typeof Hadean.Collaborators.autocomplete == "undefined") {

    Hadean.Collaborators.autocomplete = {
        scheduled_at    : null,
        initialize      : function( ) {
          //  Get the widget's information;
          // callback to load the widget on the page
          jQuery('#query').autocomplete({
            serviceUrl : '/company_admin/users.json',
            minChars : 2,
            onSelect : function(value, data){Hadean.Collaborators.autocomplete.setCollaborator(value, data)}
          });

          jQuery('#collaborators_employee_list .delete-list-user').hover(
            function () {
              $(this).parent('li').addClass('deleteable-item');
            },
            function () {
              $(this).parent('li').removeClass('deleteable-item');
            }
          );
          jQuery('#collaborators_employee_list .delete-list-user').live('click', function() {
            Hadean.Collaborators.autocomplete.removeUser(this);// product_table_body
          })
        },
        setCollaborator : function(value, data){
          jQuery('#employee_user_id').val(data);
        },
        removeUser : function(obj) {
          jQuery.ajax( {
             type : "DELETE",
             data : { authenticity_token : $('meta[name="csrf-token"]').attr('content') },
             url : "/company_admin/companies/"+ $(obj).data('company_unique') + "/collaborators/"+ $(obj).data('user_id'),
             complete : function(json) {
              $(obj).parent('li').remove();
             },
             dataType : 'json'
          });
        }
    }

}
$(document).ready(function() {
  Hadean.Collaborators.autocomplete.initialize();
});