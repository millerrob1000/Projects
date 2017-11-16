package com.example.rmiller.rmiller_final_project;

/**
 * Created by RMILLER on 10/25/2017.
 */

public class Lines {

    enum Type { red, blue, brn, g, o, p, pnk, y }

    String name;
    Type type;
    String routes;

    public Lines(String name, Type type, String routes) {
        this.name = name;
        this.type = type;
        this.routes = routes;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getRoutes() {
        return routes;
    }

    public void setRoutes(String routes) {
        this.routes = routes;
    }

    @Override
    public String toString() {
        return name;
    }

    public static int getColor(Type type){
        switch(type){
            case red: return R.color.redLine;
            case blue: return R.color.blueLine;
            case brn: return R.color.brownLine;
            case g: return R.color.greenLine;
            case o: return R.color.orangeLine;
            case p: return R.color.purpleLine;
            case pnk: return R.color.pinkLine;
            case y: return R.color.yellowLine;
        }
        return -1;
    }
}
