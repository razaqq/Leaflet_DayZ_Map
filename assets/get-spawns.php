<?php
  $servername = "127.0.0.1";
  $username = "mysqluser";
  $password = "mysqlpass";
  $dbname = "mysqldbname";

  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
  // Check connection
  if ($conn->connect_error) {
      die("Connection failed: " . $conn->connect_error);
  }
  
  if ($result = $conn->query("SELECT * FROM vehicle_locations;")) {
    // "SELECT DISTINCT vg.group_info, vl.worldspace FROM vehicle_spawns AS vs, vehicle_locations AS vl, vehicle_spawns_groups AS vsp, vehicle_groups AS vg WHERE vs.location=vl.id AND vsp.Group_ID=vg.ID AND vsp.Spawn_ID=vs.ID ORDER BY vl.worldspace;"
    $tempArray = array();
    while($row = $result->fetch_array(MYSQLI_ASSOC)) {
      $tempArray[] = $row;
    }
    echo json_encode($tempArray);
  }
  
  $conn->close();
?>  
