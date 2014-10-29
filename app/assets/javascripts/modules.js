var app = angular.module('newsRankApp', ['infinite-scroll']);

// app.factory('Tiles', function() {
// 	return []
// })

app.directive('backImg', function() {
    return function(scope, element, attrs) {
        attrs.$observe('backImg', function(value) {
            element.css({
                'background-image': 'url(' + value + ')',
                'background-size' : 'cover'
            });
        });
    };
});

app.directive('myTiles', function() {
	return {
		restrict: 'E',
		template: '<li ng-repeat="tile in activeTiles">' +
    			    '<a ng-href="{{tile.canonical_url}}" class="item-box" back-img="{{imgHelper(tile)}}">' +
    			      '<div class="item-box-title">' +
    			        '<span>' +
    			          '<div class="title-text">{{tile.title}}</div>' +
    			          '<div class="source-text">{{tile.site_url}}</div>' +
    			          '<div class="age">{{toHour(tile.published)}}</div>' +
    			        '</span>' +
    			      '</div>' +
    			   '</a>' +
    			  '</li>'

	}
})