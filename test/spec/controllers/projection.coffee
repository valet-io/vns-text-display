'use strict'

describe 'Controller: ProjectionCtrl', () ->

  # load the controller's module
  beforeEach module '.App'

  ProjectionCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ProjectionCtrl = $controller 'ProjectionCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
