app.controller('MainController', ["$scope", "$http", function($scope, $http) {

    $scope.activeTiles = [];

    $scope.tiles = [];

    $scope.sortBy = "calculated_rank";

    $scope.getArticles = function() {
        $http({
            method: 'GET',
            url: '/articles'
        }).success(function(data) {
            $scope.tiles = [];
            var merged = [];
            var exists = {};
            merged = merged.concat.apply(merged, data);
            // for (i = 0; i < merged.length; i++) {
            //     $scope.tiles.push(merged[i]);
            // }
            for (var i = 0; i < merged.length; i++) {
                if (!exists[merged[i]["canonical_url"]]) {
                    $scope.tiles.push(merged[i]);
                    exists[merged[i]["canonical_url"]] = true;
                }
                if (i === merged.length - 1) {
                    $scope.initializePage($scope.sortBy);
                }
            }
            // $scope.initializePage($scope.sortBy);
        })
    }

    $scope.initializePage = function(sortBy) {
        $scope.activeTiles = [];
        sortFeed($scope.tiles, sortBy);
        if ($scope.tiles.length < 18) {
            var minimumCount = $scope.tiles.length;
        } else {
            var minimumCount = 18;
        }
        for (i = 0; i < minimumCount; i++) {
            $scope.activeTiles.push($scope.tiles[i]);
        }
    }

    $scope.makeUsable = function(rawFloat) {
        return parseInt(rawFloat * 100000000000000000);
    }

    var sortFeed = function(sortMe, sortBy) {
        var spaceship = function(a, b) {
            if (a[sortBy] < b[sortBy]) {
                return 1;
            }
            else if (a[sortBy] > b[sortBy]) {
                return -1;
            }
            else {
                return 0;
            }
        }
        $scope.tiles = $scope.tiles.sort(spaceship);
        if (sortBy == "calculated_rank") {
            $scope.tiles.reverse();
        }
    }


    $scope.addFeedFromUrl = function() {
        $http.post('/feeds/create',
        { url: $scope.newFeedUrl })
        .success($scope.updateUserFeeds());
    }

    $scope.loadMoreTiles = function() {
        var lastTile = $scope.activeTiles.length;
        for (i = 0; i < 9; i++) {
            if ($scope.activeTiles.length < $scope.tiles.length) {
                $scope.activeTiles.push($scope.tiles[i + lastTile]);
            }
        }
    }

    $scope.timePublishedButtonActive = false;

    $scope.newsRankButtonActive = true;

    $scope.sortTimePublished = function(){
        $scope.sortBy = "published";
        $scope.initializePage($scope.sortBy);
        $scope.timePublishedButtonActive = true;
        $scope.newsRankButtonActive = false;
    }

    $scope.sortNewsRank= function(){
        $scope.sortBy = "calculated_rank";
        $scope.initializePage($scope.sortBy);
        $scope.timePublishedButtonActive = false;
        $scope.newsRankButtonActive = true;
    }

    $scope.checkedBoxes = [];

    $scope.log = function(){
        console.log($scope.checkedBoxes);
    }

    $scope.toggleResults = function(result){
        var found = $.inArray(result.feedId, $scope.checkedBoxes) > -1;
        if (found) {
            index = $scope.checkedBoxes.indexOf(result.feedId);
            $scope.checkedBoxes.splice(index, 1);
            result.selected = false;
        }
        else{
            $scope.checkedBoxes.push(result.feedId);
            result.selected = true;
        }
    }

    $scope.searchResults = [];

    $scope.hideSubscribeButton = true;

    $scope.search = function() {
        if ($scope.searchTerm.substring(0, 7) == "http://") {
            $http.post('/feeds/create',
            { url: $scope.searchTerm })
            .success(function() {
                $scope.resetAll();
                $scope.updateUserFeeds();
                $scope.getArticles();
            })
        }
        else {
            $http.post('/feeds/search',
            { url: $scope.searchTerm })
            .success(function(data) {
            $scope.searchResults = data;
            })
            $scope.hideSubscribeButton = false;
        }
    }

    $scope.addFromSearch = function() {
        for (i = 0; i < $scope.checkedBoxes.length; i++) {
            $http.post('/feeds/create',
            {url: $scope.checkedBoxes[i]})
            .success(function() {
                $scope.resetAll();
                $scope.updateUserFeeds();
                $scope.getArticles();
            })
        }
        $scope.updateUserFeeds();
    }

    $scope.toHour = function(published) {
        var age = new Date().getTime() - parseInt(published);
        var min = parseInt(age/60000);
        var string = "";
        if (min < 60) {
            string = min + "m";
        }
        else {
            hours = parseInt(min / 60);
            minutes = min % 60;
            if (minutes == 0) {
                string = hours + "h";
            }
            else {
                string = hours + "h " + minutes + "m";
            }
        }
        if (min > 1440) {
            string = parseInt(min/1440) + "d";
        }
        return string;
    }

    $scope.imgHelper = function(tile) {
        if (tile.visual_url == null) {
            return "http://i.imgur.com/JFZ8pp4.jpg";
        }
        else if (tile.visual_url.substring(0, 7) == "http://") {
            return tile.visual_url;
        }
        else {
            return "http://i.imgur.com/JFZ8pp4.jpg";
        }
    }

    $scope.userFeeds = [];

    $scope.updateUserFeeds = function() {
        $http({
            method: 'GET',
            url: '/feeds'
        }).success(function(data) {
            $scope.userFeeds = [];
            $scope.userFeeds = data;
        })
    }

    $scope.deleteFeed = function(feed_id) {
        $http.delete('/feeds/delete/' + feed_id);
        $scope.updateUserFeeds();
    }

    $scope.resetAll = function() {
        $("input[type=text], textarea").val("");
        $('#fade, .popup:visible').fadeOut('normal', function() { $('#fade, .popup:visible').css('display','none')});
        $scope.initializePage($scope.sortBy);
        $scope.searchResults = [];
        $scope.hideSubscribeButton = true;
    }

}]);
