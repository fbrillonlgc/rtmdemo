package com.lgc.rtmdemo;

import java.net.URL;
import java.lang.String;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.time.Instant;

import com.google.transit.realtime.GtfsRealtime.FeedEntity;
import com.google.transit.realtime.GtfsRealtime.FeedHeader;
import com.google.transit.realtime.GtfsRealtime.FeedMessage;
import com.google.transit.realtime.GtfsRealtime.TripUpdate;
import com.google.transit.realtime.GtfsRealtime.TripUpdate.StopTimeUpdate;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import com.lgc.rtmdemo.NifiNormalizeEtl;
import com.lgc.rtmdemo.NormalizedTripUpdate;

public class NifiNormalizeTripUpdates implements NifiNormalizeEtl {
  public void normalize( InputStream in, OutputStream out ) throws Exception {
    //URL url = new URL("http://opendata.rtm.quebec:2539/ServiceGTFSR/TripUpdate.pb?token=YOUR_TOKEN_HERE");
    //FeedMessage feed = FeedMessage.parseFrom(url.openStream());
    PrintStream outps = new PrintStream(out);
    FeedMessage feed = FeedMessage.parseFrom(in);
    for (FeedEntity entity : feed.getEntityList()) {
      if (entity.hasTripUpdate()) {
        printNormalized( feed.getHeader(), entity, outps );
      }
      // TO DO - print details of non-trip updates entiry for debugging
    }
  }

  // Normalize
  // tripid,startTime,routeId,stopId,stopSequence,arrival_delay,departure_delay
  private void printNormalized( FeedHeader header, FeedEntity entity, PrintStream outps ) {
    Gson gson = new Gson();
    //Gson gson = new GsonBuilder().setPrettyPrinting().create();

    long timestamp =  header.getTimestamp();
    TripUpdate tripupdate = entity.getTripUpdate();
    String trip_id = tripupdate.getTrip().getTripId();
    String start_time = tripupdate.getTrip().getStartTime();
    String route_id = tripupdate.getTrip().getRouteId();

    for (StopTimeUpdate stop : tripupdate.getStopTimeUpdateList()) {
      NormalizedTripUpdate ntu = new NormalizedTripUpdate();
      ntu.timestamp = timestamp;
      ntu.datetime = Instant.ofEpochSecond(ntu.timestamp).toString();
      ntu.trip_id = trip_id;
      ntu.start_time = start_time;
      ntu.route_id = route_id;
      ntu.stop_id = stop.getStopId();
      ntu.stop_sequence = stop.getStopSequence();
      ntu.arrival_delay_secs = stop.getArrival().getDelay();
      ntu.departure_delay_secs = stop.getDeparture().getDelay();
      outps.println(gson.toJson(ntu));
    }
  }
}
