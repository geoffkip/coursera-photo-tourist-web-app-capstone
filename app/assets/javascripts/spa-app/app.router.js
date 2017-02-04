(function() {
  'use strict';

  angular
    .module('spa-app')
    .config(RouterFunction);

  RouterFunction.$inject = ['$stateProvider',
                            '$urlRouterProvider',
                            'spa-app.APP_CONFIG'];

  function RouterFunction($stateProvider,
                          $urlRouterProvider,
                          APP_CONFIG) {
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: APP_CONFIG.main_page_html
      });

    $urlRouterProvider.otherwise('/');
  }
})();