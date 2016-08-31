/** Object for displaying Dept. Info documents. */
var DeptInfo = {

  /**
   * Object properties.
   */
  fullHeightEmbed: '.embed-fill-height',
  bottomMargin: 15,
  intervalID: null,

  /**
   * Change height of embeds.
   */
  setupEmbedSizing: function() {

    // Calculate total height of page.
    var totalHeight = $(window).height();

    // Set embed height.
    $(DeptInfo.fullHeightEmbed).each(function() {
      var embed = $(this);
      var position = embed.offset();
      var height = totalHeight - position.top - DeptInfo.bottomMargin;
      embed.height(height);
    });

  },

  /**
   * Initialization method to be called when page loaded.
   */
  initialize: function() {

    // Set interval for iframe sizing.
    DeptInfo.intervalID = setInterval(DeptInfo.setupEmbedSizing, 200);

    // Resize again if window size changes.
    $(window).resize(function() {
      clearInterval(DeptInfo.intervalID);
      DeptInfo.intervalID = setInterval(DeptInfo.setupEmbedSizing, 200);
    });

  },

};

/** Method to run when page loaded. */
$(function() {
  DeptInfo.initialize();
});