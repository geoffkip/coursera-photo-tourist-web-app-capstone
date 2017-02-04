(function() {
  'use strict';

  angular
    .module('spa-app.resources')
    .directive('spaResources', ResourcesDirective);

  ResourcesDirective.$inject = ['spa-app.APP_CONFIG'];

  function ResourcesDirective(APP_CONFIG) {
    var directive = {
      templateUrl: APP_CONFIG.cities_html,
      replace: true,
      bindToController: true,
      controller: 'spa-app.resources.ResourcesController',
      controllerAs: 'res',
      restrict: 'E',
      scope: {},
      link: link
    };
    console.log(directive);
    return directive;

    function link(scope, element, attrs) {
      console.log('ResourcesDirective', scope);
    }
  }

})();