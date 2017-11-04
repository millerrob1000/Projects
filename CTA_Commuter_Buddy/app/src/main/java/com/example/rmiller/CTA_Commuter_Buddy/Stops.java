package com.example.rmiller.CTA_Commuter_Buddy;

import android.support.annotation.NonNull;

/**
 * Created by RMILLER on 10/26/2017.
 */

public class Stops implements Comparable<Stops> {

    enum Type {Red, Blue, Brn, G, Org, P, Pink, Y}

    String rt;
    String stpDe;
    String diffTime;
    String isApp;
    String isDly;
    String trDr;

    public Stops(String rt, String stpDe, String diffTime, String isApp, String isDly, String trDr) {
        this.rt = rt;
        this.stpDe = stpDe;
        this.diffTime = diffTime;
        this.isApp = isApp;
        this.isDly = isDly;
        this.trDr = trDr;
    }

    public String getTrDr() {
        return trDr;
    }

    public void setTrDr(String trDr) {
        this.trDr = trDr;
    }

    public String getRt() {
        return rt;
    }

    public void setRt(String rt) {
        this.rt = rt;
    }

    public String getStpDe() {
        return stpDe;
    }

    public void setStpDe(String stpDe) {
        this.stpDe = stpDe;
    }

    public String getDiffTime() {
        return diffTime;
    }

    public void setDiffTime(String diffTime) {
        this.diffTime = diffTime;
    }

    public String getIsApp() {
        return isApp;
    }

    public void setIsApp(String isApp) {
        this.isApp = isApp;
    }

    public String getIsDly() {
        return isDly;
    }

    public void setIsDly(String isDly) {
        this.isDly = isDly;
    }

    @Override
    public String toString() {
        return rt;
    }

    @Override
    public int compareTo(@NonNull Stops stops) {
        return toString().compareTo(stops.toString());
    }

    public static int getColor(String type) {
        switch (type) {
            case "Red":
                return R.color.redLine;
            case "Blue":
                return R.color.blueLine;
            case "Brn":
                return R.color.brownLine;
            case "G":
                return R.color.greenLine;
            case "Org":
                return R.color.orangeLine;
            case "P":
                return R.color.purpleLine;
            case "Pink":
                return R.color.pinkLine;
            case "Y":
                return R.color.yellowLine;
        }
        return -1;
    }

    public static String getNameResource(String type) {
        switch (type) {
            case "Red":
                return "Red";
            case "Blue":
                return "Blue";
            case "Brn":
                return "Brown";
            case "G":
                return "Green";
            case "Org":
                return "Orange";
            case "P":
                return "Purple";
            case "Pink":
                return "Pink";
            case "Y":
                return "Yellow";
        }
        return "";
    }
}

