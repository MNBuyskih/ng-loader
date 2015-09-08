angular.module('ngLoader', [])
    .provider "$ngLoader", class
        constructor: ($httpProvider) ->
            $this = @
            $httpProvider.interceptors.push ($q) ->
                request: (config) ->
                    $this.ajaxCount++
                    config
                response: (config) ->
                    $this.ajaxCount-- if $this.ajaxCount > 0
                    config
                responseError: (config) ->
                    $this.ajaxCount-- if $this.ajaxCount > 0
                    $q.reject config

        ajaxCount: 0

        $get: -> @

    .directive 'loader', ->
        template: '<div class="loader-cont"><div class="loader-progress progress progress-xs"><div class="progress-bar progress-bar-success"></div></div></div>'
        restrict: 'E'
        replace: true
        controller: ($ngLoader, $scope) -> $scope.loader = $ngLoader

    .directive 'loaderProgress', ->
        restrict: "CA"
        require: "^loader"
        link: ($scope, $element) ->
            $scope.$watch 'loader.ajaxCount', (count) ->
                method = 'removeClass'
                method = 'addClass' if !count
                $element[method]('loader-collapse')
