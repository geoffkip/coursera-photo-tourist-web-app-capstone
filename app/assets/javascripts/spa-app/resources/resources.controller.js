(function() {
  'use strict';

  angular
    .module('spa-app.resources')
    .controller('spa-app.resources.ResourcesController', ResourcesController);

  ResourcesController.$inject = ['spa-app.resources.Resource'];

  function ResourcesController(Resource) {
    var vm = this;
    vm.cities;
    vm.city;
    vm.edit   = edit;
    vm.create = create;
    vm.update = update;
    vm.remove = remove;

    activate();
    return;
    ////////////////
    function activate() {
      newResource();
      vm.cities = Resource.query();
    }

    function newResource() {
      vm.city = new Resource();
    }
    function handleError(response) {
      console.log(response);
    }
    function edit(object) {
      vm.city = object;
    }

    function create() {
      vm.city.$save()
        .then(function(response){
          vm.cities.push(vm.city);
          newResource();
        })
        .catch(handleError);
    }

    function update() {
      vm.city.$update()
        .then(function(response){
          newResource();
        })
        .catch(handleError);
    }

    function remove() {
      vm.city.$delete()
        .then(function(response){
          removeElement(vm.cities, vm.city);
          newResource();
        })
        .catch(handleError);
    }


    function removeElement(elements, element) {
      for (var i=0; i<elements.length; i++) {
        if (elements[i].id == element.id) {
          elements.splice(i,1);
          break;
        }
      }
    }
  }
})();