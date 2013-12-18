'use strict'

angular.module('vns-app')
	.controller 'TextsCtrl', ($scope, angularFire) ->
		promise = angularFire('https://vns-sms-display.firebaseio.com/texts', $scope, 'texts', {})

		promise.then (texts) ->
			objToArray = (collection) ->
				array = []

				angular.forEach collection, (obj, id) ->
					array.push obj

				array

			textsArray = (textsObj) ->
				array = objToArray(texts).reverse()
				_.reject array, (text) ->
					text.deleted

			reverseSort = (texts) ->
				_.sortBy texts, (text) ->
					-text.timestamp

			$scope.updateQueue = []

			$scope.$watch 'texts', (newVal, oldVal) ->
				visible = _.reject newVal, (text) ->
					text.deleted
				$scope.adminTexts = reverseSort visible
			$scope.$watch ->
				return _.filter $scope.texts, (text) ->
					text.visible and not text.deleted
			, (newVal, oldVal) ->
				# if items were removed or we're initializing, update the display immediately
				if (newVal is oldVal) or (oldVal.length > newVal.length)
					$scope.projectedTexts = reverseSort newVal
				# otherwise queue additions
				else
					console.log 'Pushing update into queue'
					updates = _.reject newVal, (value) ->
						_.find oldVal, (oldValue) ->
							_.isEqual value, oldValue
					$scope.updateQueue = $scope.updateQueue.concat updates

			, true

			setInterval ->
				if $scope.updateQueue.length
					console.log 'pulling update off queue:'
					update = $scope.updateQueue.shift()
					console.log update
					$scope.$apply ->
						$scope.projectedTexts.unshift update
			, 3000

			$scope.toggleVisibility = (text) ->
				text.visible = !text.visible

			$scope.deleteText = (text) ->
				if confirm 'Are you sure you want to delete this message?'
					text.deleted = true
				else
					false