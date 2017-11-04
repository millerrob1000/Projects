package com.example.rmiller.CTA_Commuter_Buddy;

import android.support.annotation.NonNull;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by RMILLER on 10/25/2017.
 */

public class Stations implements Comparable<Stations> {

    @Override
    public int compareTo(@NonNull Stations stations) {
        return toString().compareTo(stations.toString());
    }

    String stationName;
    String bool;
    String type;
    String mapID;

    public Stations(String stationName, String bool, String type, String mapID) {
        this.stationName = stationName;
        this.bool = bool;
        this.type = type;
        this.mapID = mapID;
    }

   public Stations() {}

    public String getMapID() {
        return mapID;
    }

    public void setMapID(String mapID) {
        this.mapID = mapID;
    }

    public String getBool() {
        return bool;
    }

    public void setBool(String bool) {
        this.bool = bool;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStationName() {
        return stationName;
    }

    public void setStationName(String stationName) {
        this.stationName = stationName;
    }

    @Override
    public String toString() {
        return stationName + " " + type;
    }

    public static int getColor(String type){
        switch(type){
            case "red": return R.color.redLine;
            case "blue": return R.color.blueLine;
            case "brn": return R.color.brownLine;
            case "g": return R.color.greenLine;
            case "o": return R.color.orangeLine;
            case "p": return R.color.purpleLine;
            case "pnk": return R.color.pinkLine;
            case "y": return R.color.yellowLine;
        }
        return -1;
    }

    public static List<Stations> st = new ArrayList<>();
}
