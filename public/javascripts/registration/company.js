var Hadean = window.Hadean || { };

// If we already have the Registration namespace don't override
if (typeof Hadean.Registration == "undefined") {
    Hadean.Registration = {};
}
var debug_variable = null;
// If we already have the Cart object don't override
if (typeof Hadean.Registration.company == "undefined") {

    Hadean.Registration.company = {
        initialize      : function( ) {
          Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
          $("#new_company").submit(function(event) {
            // disable the submit button to prevent repeated clicks
            if (jQuery('#company_stripe_card_token').length > 0) {
              $('.company-submit-button').attr("disabled", "disabled");

              //var amount = 1000; //amount you want to charge in cents
              Hadean.Registration.company.submitForm();
            }

            // prevent the form from submitting with the default action
            return false;
          });
          jQuery(".chzn-select").chosen();
        },
        submitForm : function () {
          // don't submit if this isn't valid
          Hadean.Validators.CreditCards.validateNumber(Hadean.Validators.CreditCards.creditCardInput);
          if (Hadean.Validators.CreditCards.valid) {
            $(".payment-errors").fadeOut();
            // get the amount

                Stripe.createToken({
                    number:     $('#number').val(),
                    cvc:        $('#verification_value').val(),
                    exp_month:  $('#month').val(),
                    exp_year:   $('#year').val()
                }, Hadean.Registration.company.stripeResponseHandler);

          } else {
            $('.company-submit-button').attr("disabled", false);
            $(".payment-errors").html("Credit Card is not valid.");
            $(".payment-errors").fadeIn();

          }
        },
        stripeResponseHandler : function(status, response) {
            if ((status != 200) ||  response.error) {
                //show the errors on the form
                $('.company-submit-button').attr("disabled", false);
                $(".payment-errors").html(response.error.message);
                $(".payment-errors").fadeIn();
            } else  {
                var form = $("#new_company");
                // token contains id, last4, and card type
                var token = response['id'];
                // insert the token into the form so it gets submitted to the server
                $('#company_stripe_card_token').val(token);
                //$('#token_amount').val(response['amount']);

                // and submit
                form.get(0).submit();
                //$('.company-submit-button').attr("disabled", false);
            }
        },
        lastFour : function(){
          var str = $('#number').val();
          return str.replace(/\D/g,'').substring(str.length - 4, str.length );
        },
        orderAmount : function() {

        }
    };

    // Start it up
    jQuery(function() {
      Hadean.Registration.company.initialize();
    });
}
