'use strict'

angular.module('vns-app')
	.controller 'TextsCtrl', ($scope, angularFire) ->
		promise = angularFire('https://vns-sms-display.firebaseio.com/texts', $scope, 'textsObject', {})

		promise.then (texts) ->
			objToArray = (collection) ->
				array = []

				angular.forEach collection, (obj) ->
					array.push obj

				array
					
			$scope.texts = ->
				array = objToArray($scope.textsObject).reverse()

			$scope.toggleVisibility = (text) ->
				text.visible = !text.visible	