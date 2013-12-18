'use strict'

angular.module('vns-app', ['firebase'])
  .config ($routeProvider) ->
    $routeProvider
      .when '/admin',
        templateUrl: 'views/admin.html',
        controller: 'TextsCtrl'
      .when '/projection',
        templateUrl: 'views/projection.html',
        controller: 'TextsCtrl'
      .otherwise
        redirectTo: '/projection'
