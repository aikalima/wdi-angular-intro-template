demoApp = angular.module("demoApp", [])

#added for index_v
demoApp.config ($routeProvider) ->
  $routeProvider.when("/",
    controller: "SimpleController"
    templateUrl: "Partials/View1.html"
  ).when("/view2",
    controller: "SimpleController"
    templateUrl: "Partials/View2.html"
  ).otherwise redirectTo: "/"

demoApp.factory 'simpleFactory', () ->
  students = [
    name: "Dave"
    city: "San Francisco"
  ,
    name: "Brian"
    city: "San Francisco"
  ,
    name: "Lauren"
    city: "New York"
  ,
    name: "Laura"
    city: "Phoenix"
  ]

  factory = {}
  factory.getStudents = () ->
    students

  factory

#added for index_c
SimpleController = ($scope, simpleFactory) ->
  #added for index_v
  $scope.students = simpleFactory.getStudents()

  $scope.addStudent = () ->
    $scope.students.push(
      name: $scope.newStudent.name,
      city: $scope.newStudent.city
      )

demoApp.controller "SimpleController", SimpleController
