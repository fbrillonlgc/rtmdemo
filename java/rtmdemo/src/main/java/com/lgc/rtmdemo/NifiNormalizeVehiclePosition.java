package com.lgc.rtmdemo;

import java.net.URL;
import java.lang.String;
import java.util.HashMap;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.time.Instant;

import com.google.transit.realtime.GtfsRealtime.FeedEntity;
import com.google.transit.realtime.GtfsRealtime.FeedHeader;
import com.google.transit.realtime.GtfsRealtime.FeedMessage;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import com.lgc.rtmdemo.NifiNormalizeEtl;
import com.lgc.rtmdemo.NormalizedVehiclePosition;

public class NifiNormalizeVehiclePosition implements NifiNormalizeEtl {
  public void normalize( InputStream in, OutputStream out ) throws Exception {
    //URL url = new URL("http://opendata.rtm.quebec:2539/ServiceGTFSR/TripUpdate.pb?token=YOUR_TOKEN_HERE");
    //FeedMessage feed = FeedMessage.parseFrom(url.openStream());
    PrintStream outps = new PrintStream(out);
    FeedMessage feed = FeedMessage.parseFrom(in);
    for (FeedEntity entity : feed.getEntityList()) {
      if (entity.hasVehicle()) {
        printNormalized( feed.getHeader(), entity, outps );
      }
      // TO DO - print details of other entities for debugging
    }
  }

  private void printNormalized( FeedHeader header, FeedEntity entity, PrintStream out ) {
    Gson gson = new Gson();
    //Gson gson = new GsonBuilder().setPrettyPrinting().create();

    NormalizedVehiclePosition nvp = new NormalizedVehiclePosition();
    nvp.timestamp = entity.getVehicle().getTimestamp();
    nvp.datetime = Instant.ofEpochSecond(nvp.timestamp).toString();
    nvp.trip_id = entity.getVehicle().getTrip().getTripId();
    nvp.route_id = entity.getVehicle().getTrip().getRouteId();
    nvp.vehicle_id = entity.getVehicle().getVehicle().getId();
    nvp.latitude = entity.getVehicle().getPosition().getLatitude();
    nvp.longitude = entity.getVehicle().getPosition().getLongitude();
    nvp.bearing = entity.getVehicle().getPosition().getBearing();
    nvp.speed = entity.getVehicle().getPosition().getSpeed();
    out.println(gson.toJson(nvp));
  }
}
