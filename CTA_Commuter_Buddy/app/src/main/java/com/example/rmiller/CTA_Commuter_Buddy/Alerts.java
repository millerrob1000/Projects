package com.example.rmiller.CTA_Commuter_Buddy;


/**
 * Created by RMILLER on 10/31/2017.
 */

public class Alerts {

    String serviceName;
    String shortDescription;
    String headline;
    String serviceID;
    String impact;

    public Alerts(String route, String routeStatus, String routeURL, String serviceID, String impact) {
        this.serviceName = route;
        this.shortDescription = routeStatus;
        this.headline = routeURL;
        this.serviceID = serviceID;
        this.impact = impact;
    }

    public String getImpact() {
        return impact;
    }

    public void setImpact(String impact) {
        this.impact = impact;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getHeadline() {
        return headline;
    }

    public void setHeadline(String headline) {
        this.headline = headline;
    }

    public String getServiceID() {
        return serviceID;
    }

    public void setServiceID(String serviceID) {
        this.serviceID = serviceID;
    }

    @Override
    public String toString() {
        return serviceID;
    }
}

