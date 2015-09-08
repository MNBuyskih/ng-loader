(function() {
  angular.module('ngLoader', []).provider("$ngLoader", (function() {
    function _Class($httpProvider) {
      var $this;
      $this = this;
      $httpProvider.interceptors.push(function($q) {
        return {
          request: function(config) {
            $this.ajaxCount++;
            return config;
          },
          response: function(config) {
            if ($this.ajaxCount > 0) {
              $this.ajaxCount--;
            }
            return config;
          },
          responseError: function(config) {
            if ($this.ajaxCount > 0) {
              $this.ajaxCount--;
            }
            return $q.reject(config);
          }
        };
      });
    }

    _Class.prototype.ajaxCount = 0;

    _Class.prototype.$get = function() {
      return this;
    };

    return _Class;

  })()).directive('loader', function() {
    return {
      template: '<div class="loader-cont"><div class="loader-progress progress progress-xs"><div class="progress-bar progress-bar-success"></div></div></div>',
      restrict: 'E',
      replace: true,
      controller: function($ngLoader, $scope) {
        return $scope.loader = $ngLoader;
      }
    };
  }).directive('loaderProgress', function() {
    return {
      restrict: "CA",
      require: "^loader",
      link: function($scope, $element) {
        return $scope.$watch('loader.ajaxCount', function(count) {
          var method;
          method = 'removeClass';
          if (!count) {
            method = 'addClass';
          }
          return $element[method]('loader-collapse');
        });
      }
    };
  });

}).call(this);
