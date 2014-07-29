app.controller('MainController', ["$scope", "$http", function($scope, $http) {

    $scope.activeTiles = []

    $scope.tiles = []

    var getArticles = function() {
        $http({
            method: 'GET',
            url: '/articles'
        }).success(function(data) {
            var merged = []
            merged = merged.concat.apply(merged, data)
            for (i = 0; i < merged.length; i++) {
                $scope.tiles.push(merged[i])
            }
            // currently defaults to sort by published date
            initializePage("published")
        })
    }

    getArticles()

    var initializePage = function(sortBy) {
        $scope.activeTiles = []
        sortFeed($scope.tiles, sortBy)
        if ($scope.tiles.length < 30) {
            var minimumCount = $scope.tiles.length
        } else {
            var minimumCount = 30
        }
        for (i = 0; i < minimumCount; i++) {
            $scope.activeTiles.push($scope.tiles[i])
        }
    }

    var sortFeed = function(sortMe, sortBy) {
        var spaceship = function(a, b) {
            if (a[sortBy] < b[sortBy]) {
                return -1
            }
            else if (a[sortBy] > b[sortBy]) {
                return 1
            }
            else {
                return 0
            }
        }
        sortMe = sortMe.sort(spaceship)
    }

    $scope.addFeedFromUrl = function() {
        $http.post('/feeds/from_url', { url: $scope.newFeedUrl })
    }

    $scope.loadMoreTiles = function() {
        var lastTile = $scope.activeTiles.length
        for (i = 0; i < 9; i++) {
            if ($scope.activeTiles.length < $scope.tiles.length) {
                $scope.activeTiles.push($scope.tiles[i + lastTile])
            }
        }
    }

    $scope.searchResults = []

    $scope.search = function() {
        $http.post('/feeds/search', { url: $scope.searchTerm })
        .success(function(data) {
            $scope.searchResults = data
        })
    }

    $scope.sortTimePublished = function(){
        initializePage("published")
        $(".box-right").find(".bb").removeClass("active")
        $(".box-right").find(".bb").eq(0).addClass("active")
    }

    $scope.sortNewsRank= function(){
        initializePage("calculated_rank")
        $(".box-right").find(".bb").removeClass("active")
        $(".box-right").find(".bb").eq(1).addClass("active")
    }

}]);
