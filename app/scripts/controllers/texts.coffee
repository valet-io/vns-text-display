'use strict'

angular.module('vns-app')
	.controller 'TextsCtrl', ($scope, angularFire) ->
		promise = angularFire('https://vns-sms-display.firebaseio.com/texts', $scope, 'textsObject', {})

		promise.then (texts) ->
			objToArray = (collection) ->
				array = []

				angular.forEach collection, (obj, id) ->
					console.log obj.$id
					array.push obj

				array
					
			$scope.texts = ->
				array = objToArray($scope.textsObject).reverse()
				_.reject array, (text) ->
					text.deleted

			$scope.toggleVisibility = (text) ->
				text.visible = !text.visible

			$scope.deleteText = (text) ->
				if confirm 'Are you sure you want to delete this message?'
					text.deleted = true
				else
					false