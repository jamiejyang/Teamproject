<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>간단한 지도 표시하기</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ucem476njs&submodules=geocoder"></script>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
</head>
<body>
<div>
<div class="search" style="">
			<select id="address" name="address" >
				<option value="" selected="selected">도서관 선택</option>
				<option value="서울특별시 강남구 선릉로 116길 45">강남도서관</option>
				<option value="서울특별시 강동구 양재대로116길57">강동도서관</option>
				<option value="서울특별시 강서구 등촌로51나길 29">강서도서관</option>
				<option value="서울특별시 강남구 선릉로4길 30">개포도서관</option>
				<option value="서울특별시 강동구 고덕로 295">고덕평생학습관</option>
				<option value="서울특별시 구로구 고척로45길 31">고척도서관</option>
				<option value="서울특별시 구로구 공원로 15">구로도서관</option>
				<option value="서울 특별시 용산구 소월로 109">남산도서관</option>
				<option value="서울 노원구 동일로204길 13">노원평생학습관</option>
				<option value="서울특별시 도봉구 삼양로 556">도봉도서관</option>
				<option value="서울특별시 동대문구 천호대로4길 22">동대문도서관</option>
				<option value="서울특별시 동작구 장승배기로 94">동작도서관</option>
				<option value="서울특별시 마포구 마포대로 224">마포평생학습관 아현분관</option>
				<option value="서울특별시 마포구 홍익로2길 16">마포평생학습관</option>
				<option value="서울특별시 서대문구 모래내로 412">서대문도서관</option>
				<option value="서울특별시 송파구 동남로 263">송파도서관</option>
				<option value="서울 양천구 목동서로 113">양천도서관</option>
				<option value="서울특별시 종로구 사직로9길 7">어린이도서관</option>
				<option value="서울특별시 영등포구 버드나루로15길 10">영등포평생학습관</option>
				<option value="서울특별시 용산구 두텁바위로 160">용산도서관</option>
				<option value="서울특별시 종로구 북촌로5길 48">정독도서관</option>
				<option value="서울특별시 종로구 사직로9길 15-14">종로도서관</option>
			</select>
            <input id="submit" type="submit" value="주소 검색">
        </div>
<div id="map" style="width:1000px;height:900px;">
</div>
</div>
<script>
var map = new naver.maps.Map("map", {
	  center: new naver.maps.LatLng(37.3595316, 127.1052133),
	  zoom: 17,
	  mapTypeControl: true
	});

	var infoWindow = new naver.maps.InfoWindow({
	  anchorSkew: true
	});

	map.setCursor('pointer');

	function searchCoordinateToAddress(latlng) {

	  infoWindow.close();

	  naver.maps.Service.reverseGeocode({
	    coords: latlng,
	    orders: [
	      naver.maps.Service.OrderType.ADDR,
	      naver.maps.Service.OrderType.ROAD_ADDR
	    ].join(',')
	  }, function(status, response) {
	    if (status === naver.maps.Service.Status.ERROR) {
	      if (!latlng) {
	        return alert('ReverseGeocode Error, Please check latlng');
	      }
	      if (latlng.toString) {
	        return alert('ReverseGeocode Error, latlng:' + latlng.toString());
	      }
	      if (latlng.x && latlng.y) {
	        return alert('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
	      }
	      return alert('ReverseGeocode Error, Please check latlng');
	    }

	    var address = response.v2.address,
	        htmlAddresses = [];

	    if (address.jibunAddress !== '') {
	        htmlAddresses.push('[지번 주소] ' + address.jibunAddress);
	    }

	    if (address.roadAddress !== '') {
	        htmlAddresses.push('[도로명 주소] ' + address.roadAddress);
	    }

	    infoWindow.setContent([
	      '<div style="padding:10px;min-width:200px;line-height:150%;">',
	      '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
	      htmlAddresses.join('<br />'),
	      '</div>'
	    ].join('\n'));

	    infoWindow.open(map, latlng);
	  });
	}

	function searchAddressToCoordinate(address) {
	  naver.maps.Service.geocode({
	    query: address
	  }, function(status, response) {
	    if (status === naver.maps.Service.Status.ERROR) {
	      if (!address) {
	        return alert('Geocode Error, Please check address');
	      }
	      return alert('Geocode Error, address:' + address);
	    }

	    if (response.v2.meta.totalCount === 0) {
	      return alert('No result.');
	    }

	    var htmlAddresses = [],
	      item = response.v2.addresses[0],
	      point = new naver.maps.Point(item.x, item.y);

	    if (item.roadAddress) {
	      htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
	    }

	    if (item.jibunAddress) {
	      htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
	    }

	    if (item.englishAddress) {
	      htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
	    }

	    infoWindow.setContent([
	      '<div style="padding:10px;min-width:200px;line-height:150%;">',
	      '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
	      htmlAddresses.join('<br />'),
	      '</div>'
	    ].join('\n'));

	    map.setCenter(point);
	    infoWindow.open(map, point);
	  });
	}

	function initGeocoder() {
	  map.addListener('click', function(e) {
	    searchCoordinateToAddress(e.coord);
	  });

	  $('#address').on('keydown', function(e) {
	    var keyCode = e.which;

	    if (keyCode === 13) { // Enter Key
	      searchAddressToCoordinate($('#address').val());
	    }
	  });

	  $('#submit').on('click', function(e) {
	    e.preventDefault();

	    searchAddressToCoordinate($('#address').val());
	  });

	  searchAddressToCoordinate('경기도 성남시 분당구 돌마로 46');
	}

	naver.maps.onJSContentLoaded = initGeocoder;
</script>
</body>
</html>