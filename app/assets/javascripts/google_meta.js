/** Object for looking up Google Docs properties from URL. */
var GoogleMeta = {

  /**
   * Object properties.
   */
  urlField: '.google-docs-form #document_google_url',
  nameField: '.google-docs-form #document_name',
  contentTypeField: '.google-docs-form #document_content_type',
  googleIDField: '.google-docs-form #document_google_id',
  googleContentsField: '.google-docs-form #document_google_contents',
  googleUpdatedAtField: '.google-docs-form #document_google_updated_at',
  isValidField: '.google-docs-form #document_is_valid',
  updateURL: '/documents/get_google_meta',
  submitButton: '.google-docs-form button[type="submit"]',

  /**
   * Handles Google Docs URL field changes. Looks up metadata and populates form fields.
   */
  handleURLChange: function() {

    // Get field value.
    var value = $(GoogleMeta.urlField).val();

    // If field cleared, clear hidden fields and exit.
    if (value == '') {
      $(GoogleMeta.nameField).val('');
      $(GoogleMeta.contentTypeField).val('');
      $(GoogleMeta.googleIDField).val('');
      $(GoogleMeta.googleContentsField).val('');
      $(GoogleMeta.googleUpdatedAtField).val('');
      $(GoogleMeta.isValidField).val('');
      return;
    }

    // Call AJAX script to update info.
    $(GoogleMeta.submitButton).html('<i class="fa fa-fixed fa-refresh fa-spin"></i>');
    $.ajax({
      url: GoogleMeta.updateURL,
      dataType: 'json',
      data: {
        url: value
      },
      success: function(data) {
        $(GoogleMeta.nameField).val(data.name);
        $(GoogleMeta.contentTypeField).val(data.content_type);
        $(GoogleMeta.googleIDField).val(data.google_id);
        $(GoogleMeta.googleUpdatedAtField).val(data.google_updated_at);
        $(GoogleMeta.isValidField).val(data.is_valid);
        $(GoogleMeta.googleContentsField).val(data.google_contents ? data.google_contents.replace(/(\r\n|\n|\r)/gm, '') : '');
        $(GoogleMeta.submitButton).html('Add Document').prop('disabled', '');
      }
    });

  },

  /**
   * Initialization method for when page loaded.
   */
  initialize: function() {

    // Configure handler for URL field changing.
    $(GoogleMeta.urlField).on('change', function() {
      GoogleMeta.handleURLChange();
    });

  }

};

/** Method to run when page loaded. */
$(function() { GoogleMeta.initialize(); });