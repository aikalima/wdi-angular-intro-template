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

#added for index_c
SimpleController = ($scope) ->
  $scope.students = [
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

  #added for index_v
  $scope.addStudent = () ->
    $scope.students.push(
      name: $scope.newStudent.name,
      city: $scope.newStudent.city
      )

demoApp.controller "SimpleController", SimpleController
