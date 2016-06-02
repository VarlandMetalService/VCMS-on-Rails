/** Object for working with mobile form. */
var MobileForm = {

  /* Selectors. */
  employeeNumberField: '.mobile-login-container input[name="session[employee_number]"]',
  pinField: '.mobile-login-container input[name="session[pin]"]',
  form: '.mobile-login-container form',
  numberButton: '.mobile-login-container .number-button',
  deleteButton: '.mobile-login-container .delete-button',
  enterButton: '.mobile-login-container .enter-button',
  buttonEvent: 'touchend',
  upEvent: 'touchend',
  downEvent: 'touchstart',

  initialize: function() {

    // Setup events based on touchability.
    if(MobileForm.isTouchable()) {
      MobileForm.buttonEvent = 'touchend';
      MobileForm.upEvent = 'touchend';
      MobileForm.downEvent = 'touchstart';
    } else {
      MobileForm.buttonEvent = 'click';
      MobileForm.upEvent = 'mouseup';
      MobileForm.downEvent = 'mousedown';
    }

    // Configure the enter button.
    $(MobileForm.enterButton).on(MobileForm.buttonEvent, function() {
      $(MobileForm.form).submit();
    });

    // Configure number buttons.
    $(MobileForm.numberButton).on(MobileForm.buttonEvent, function() {
      var thisNumber = $(this).text();
      var number = $(MobileForm.employeeNumberField).val();
      var pin = $(MobileForm.pinField).val();
      if (number.length == 3 && pin.length == 4) return;
      if (number.length == 3) {
        pin += thisNumber;
        $(MobileForm.pinField).val(pin);
      } else {
        number += thisNumber;
        $(MobileForm.employeeNumberField).val(number);
      }
    });

    // Configure delete button.
    $(MobileForm.deleteButton).on(MobileForm.buttonEvent, function() {
      var number = $(MobileForm.employeeNumberField).val();
      var pin = $(MobileForm.pinField).val();
      if (pin.length > 0) {
        pin = pin.substring(0, pin.length - 1);
        $(MobileForm.pinField).val(pin);
      } else if (number.length > 0) {
        number = number.substring(0, number.length - 1);
        $(MobileForm.employeeNumberField).val(number);
      }
    });

    // Setup keydown handler.
    /*
    MobileForm.deregisterKeypress();
    $(document).on('keydown', function(event) {
      var ch = (event.keyChar == null) ? event.keyCode : event.keyChar;
      if (ch >= 96 && ch <= 105) {
        ch -= 48;
      }
      if (ch >= 48 && ch <= 57) {
        event.preventDefault();
        var thisNumber = ch - 48;
        var number = $(MobileForm.employeeNumberField).val();
        var pin = $(MobileForm.pinField).val();
        if (number.length == 3 && pin.length == 4) return;
        if (number.length == 3) {
          pin += thisNumber;
          $(MobileForm.pinField).val(pin);
        } else {
          number += thisNumber;
          $(MobileForm.employeeNumberField).val(number);
        }
      } else if (ch == 8 || ch == 46) {
        event.preventDefault();
        var number = $(MobileForm.employeeNumberField).val();
        var pin = $(MobileForm.pinField).val();
        if (pin.length > 0) {
          pin = pin.substring(0, pin.length - 1);
          $(MobileForm.pinField).val(pin);
        } else if (number.length > 0) {
          number = number.substring(0, number.length - 1);
          $(MobileForm.employeeNumberField).val(number);
        }
      } else if (ch == 13) {
        event.preventDefault();
        $(MobileForm.form).submit();
      }
    });
    */

  },

  isTouchable: function() {
    var el = document.createElement('button');
    eventName = 'ontouchend';
    var isSupported = (eventName in el);
    if (!isSupported) {
      el.setAttribute(eventName, 'return;');
      isSupported = (typeof el[eventName] == 'function');
    }
    el = null;
    return isSupported;
  },

  deregisterKeypress: function() {
    $(document).off('keydown');
  },

}

/** Method to run when page loaded. */
$(function() { MobileForm.initialize(); });