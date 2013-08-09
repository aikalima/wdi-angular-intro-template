Angular JS
===

A SPA framework = Single Page Application

It's awesome!

- AngularJS Features
- Getting Started
- Directives, Filters and Data Binding
- Views, Controllers and Scope
- Modules and Routes


SPA: Content is loaded upfront, different views loaded on the fly and embedded in the web page.

Features:

- Changing the DOM without DOM manipulation
- Data Binding: DOM elements <-> code
- Routing: Track where we are, where are we going?
- History : Back button!
- Object Modeling : client side MVC
- Routing View Loading: When to show what, templates, routes

One core library, don't worry about including many other scripts. Nice solid core!

**Let's get started**

Got to http://www.angularjs.org - grep CDN link and include it in a new html page

HTML output:
<html>
<body>
Not much to see here .. yet.
<script src=""https://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min.js"></script>
</body>
</html>


Directives
--
**Teach HTML new tricks**
Extending html by adding elements, attributes etc.

- ng-app - *inialize angular app*
- ng-model - *bind model to DOM*

HTML output:
<html ng-app>
<head>
</head>
<body>

<div class="container">
  Check this out: <input type="text" ng-model="name" /> {{name}}
</div>

<script src ="https://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min.js">
</script>
</script>
</body>
</html>

**Basic expressions - curly brackets**
  <h3>Basic expressions</h3>
  {{ 3 + 4 }}
  {{ "foo" == "bar" }}
  
- ng-init
- ng-repeat

<div class="container" ng-init="names=['Dave','Brian','Lauren','Laura',Karl']">
  <h3>Looping using ng-repeat</h3>
  <ul>
    <li ng-repeat="name in names"> {{name}}
  </ul>
</div>

**Time to look at Angular API, different directives**
Look for filter, find uppercase

- uppercase

<ul>
  <li ng-repeat="name in names "> {{name | uppercase}}
</ul>

- orderBy

<div class="container" ng-init="peeps=[{name:'Dave',city:'SF'},{name:'Brian',city:'SF'},{name:'Lauren',city:'SF'},{name:'Laura',city:'NY'}]">
  <ul>
    <li ng-repeat="peep in peeps | orderBy:'name'"> {{ peep.name | uppercase }}
  </ul>
</div>  

- filter

<div class="container" ng-init="students=[{name:'Dave',city:'SF'},{name:'Brian',city:'SF'},{name:'Lauren',city:'SF'},{name:'Laura',city:'NY'}]">
  <h3>Looping using ng-repeat</h3>
  <input type="text" ng-model="name" />
  <ul>
    <li ng-repeat="student in students | filter:name | orderBy:'name'"> {{ student.name | uppercase }} - {{student.city}}
  </ul>
</div>

{{ 12.45 | currency }}

I can write my on filters - very powerful

MVC
--

So far, we put all our logic in view. Not a good idea

View  <--- Scope ---> Controller

Scope: glue between View and Controller

ViewModel: data for the view

Let's move data to controller and make it available to view through scope. Scope is injected by angular

```
var SimpleController = function($scope) {
    return $scope.students = [
        {
          name: 'Dave',
          city: 'SF'
        }, {
          name: 'Brian',
          city: 'SF'
        }, {
          name: 'Lauren',
          city: 'SF'
        }, {
          name: 'Laura',
          city: 'NY'
        }
      ];
};
```


<script src ="simple_controller.js"></script>
<div class="container" ng-controller="SimpleController">

Modules & Routes - Show Angular Diagram
--



```
demoApp = angular.module("demoApp", [])

..

demoApp.controller "SimpleController", SimpleController


```

**In html -> <html ng-app="demoApp">**


Clean up index,html, use ng-view
The big picture: 

Module -> config() used to definres routes. Sounds familiar? Define View and Controller

/view1
/view2
etc

load different views in shell page. That Magic that glues a view to a controller

```
demoApp.config(function ($routeProvider){
  $routeProvider
    .when('/',
      {
        controller: 'SimpleController',
        templateUrl: 'Partials/View1.html'
      })
    .when('/partial2',
      {
        controller: 'SimpleController',
        templateUrl: 'Partials/View2.html'
      })
    .otherwise({ redirectTo: '/' }) ;
});
```

Create Partial/View templates

Interacting with controller
--

**Final version of interacting with controller **

```
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
```

Creates a new property on the scope - just like that:
<input type="text" ng-model="newStudent.name" />

- ng-click

Because the view binds to the scope, we implement addCustomer() in the controller's scope

Notice: no controller definition in view, that's taken care of in routes.

Don't have to write the DOM code to make change view, it's taken care of.

Angular manages the Back button - nice feature.


Factories
--

**Final version of module**

```
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
```







