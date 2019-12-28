var mapSize = 15360;
var minZoom = 1;
var maxZoom = 7;

var zoom = zoomLevel();
function zoomLevel() {
    return Math.ceil(Math.log(mapSize / 256) / Math.log(2));
};

var map = L.map('map', {
  minZoom: minZoom,
  maxZoom: maxZoom,
  crs: L.CRS.Simple
});

function project(coords) {
   return map.project(coords, zoom);
};

function unproject(coords) {
   return map.unproject(coords, zoom);
};

/*
loot: http://maps.izurvive.com/maps/CH-Top/1.4.0/lootmap.gz.json
*/

map.setView(unproject([mapSize / 2, mapSize / 2]), minZoom + 1);

var tiles = L.tileLayer('./assets/tiles/{z}/{x}/{y}.png', {minZoom: 1, maxZoom: 8, tms: false, noWrap: false, continuousWorld: true}).addTo(map);

map.on('mousemove', function (event) {
  var coords = project(event.latlng);
  document.getElementById("locoverlay").innerHTML = (coords.x / 100).toFixed(2) + ' | ' + ((mapSize - coords.y) / 100).toFixed(2);
});

function addMarker(x, y) {
  y = mapSize - y;
  L.marker(unproject([x, y])).addTo(map);
  return;
}

function addText(x, y, text) {
  y = mapSize - y;
  new L.Marker(unproject([x, y]), {
    icon: new L.DivIcon({
      className: 'townLabel',
        html: '<span class="townlabel" id="townlabel">' + text + '</span>'
        // '<img class="my-div-image" src="http://png-3.vector.me/files/images/4/0/402272/aiga_air_transportation_bg_thumb"/>'+
                
    })
  }).addTo(map);
  return;
}

function addIcon(x, y, iconUrl, tooltip) {
  y = mapSize - y;
  var icon = new L.Icon({
    iconUrl: iconUrl,
    iconSize: [25, 25],
    className: 'vehicleIcon'
  })
  new L.Marker(unproject([x, y]), {icon: icon}).addTo(map).bindTooltip(tooltip, {className: 'tooltip'});
  return;
}

async function addCityLabels() {
  var landmarks = await fetch("./assets/landmarks.json");
  landmarks = await landmarks.json();
  for (i = 0; i < landmarks.landmarks.length; i++) {
    var lm = landmarks.landmarks[i];
    addText(lm.pos[0], lm.pos[1], lm.name);
  }
  return;
}
addCityLabels();

async function addVehicleSpawns() {
  const url = './assets/get-spawns.php';
  var spawn_json = await fetch(url).then(response => response.json());
  var spawns = {};

  for (i = 0; i < spawn_json.length; i++) {
    var s = spawn_json[i];
    var pos = '[' + JSON.parse(s.Worldspace)[1].toString() + ']';
    if (!(pos in spawns)) {
      spawns[pos] = [s.ID];
    } else {
      spawns[pos].push(s.ID);
    }
  }
  
  Object.keys(spawns).forEach(function(posString) {
    var pos = JSON.parse(posString);
    var names = '';

    for (i = 0; i < spawns[posString].length; i++) {
      if (!!names) {
        names += '<br>';
      }
      names += displayNames[spawns[posString][i]];
    }
    addIcon(pos[0], pos[1], icons[spawns[posString][0]], names);
  });
  return;
}
addVehicleSpawns();
