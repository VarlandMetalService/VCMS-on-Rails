/** Object for displaying Dept. Info documents. */
var DeptInfo = {

  /**
   * Object properties.
   */
  fullHeightEmbed: '.embed-fill-height',
  bottomMargin: 15,
  intervalID: null,
  folderContainerSelector: '.panel-heading',
  folderTitleSelector: '.panel-title',
  folderIconSelector: 'i',
  openFolderClass: 'fa-folder-open',
  closedFolderClass: 'fa-folder',
  collapsingClass: 'collapsing',
  showEvent: 'shown.bs.collapse',
  hideEvent: 'hidden.bs.collapse',
  contentSelector: '.panel-body, .list-group',

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

    // Save folder states and toggle open/closed icons.
    $(DeptInfo.contentSelector).on(DeptInfo.showEvent, function() {
      var item = $(this);
      var icon = item.parent().children(DeptInfo.folderContainerSelector).children(DeptInfo.folderTitleSelector).children(DeptInfo.folderIconSelector);
      icon.removeClass(DeptInfo.closedFolderClass).addClass(DeptInfo.openFolderClass);
      var cookieValue = item.parent().children(DeptInfo.folderContainerSelector).children(DeptInfo.folderTitleSelector).data('target');
      Cookies.set(cookieValue, 'open', { expires: 1 });
    });
    $(DeptInfo.contentSelector).on(DeptInfo.hideEvent, function() {
      var item = $(this);
      if (!item.hasClass(DeptInfo.collapsingClass)) return;
      var icon = item.parent().children(DeptInfo.folderContainerSelector).children(DeptInfo.folderTitleSelector).children(DeptInfo.folderIconSelector);
      icon.removeClass(DeptInfo.openFolderClass).addClass(DeptInfo.closedFolderClass);
      var cookieValue = item.parent().children(DeptInfo.folderContainerSelector).children(DeptInfo.folderTitleSelector).data('target');
      Cookies.remove(cookieValue);
    });

    $(DeptInfo.folderTitleSelector).each(function() {
      var item = $(this);
      var target = item.data('target');
      if (Cookies.get(target) !== undefined) {
        $(target).collapse('show');
      }
    });

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