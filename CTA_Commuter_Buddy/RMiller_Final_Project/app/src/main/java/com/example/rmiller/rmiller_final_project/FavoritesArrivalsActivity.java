package com.example.rmiller.rmiller_final_project;

import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public class FavoritesArrivalsActivity extends AppCompatActivity {

    private String TAG = FavoritesArrivalsActivity.class.getSimpleName();
    List<Stops> StationStopsFavsN = new ArrayList<>();
    List<Stops> StationStopsFavsS = new ArrayList<>();
    String mapID = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_favorites_arrivals);

        Intent intent = getIntent();
        if (intent != null) {
            mapID = (String) intent.getCharSequenceExtra(getString(R.string.MapID));
            setTitle(intent.getStringExtra(getString(R.string.StationTitle)) + " Arrivals");
        }
        new GetStops().execute();
    }

    class LineAdapter extends BaseAdapter {

        private LayoutInflater inflater;
        private List<Stops> arrayList;

        public LineAdapter(List<Stops> arrayList) {
            this.arrayList = arrayList;
        }

        @Override
        public int getCount() {
            return arrayList.size();
        }

        @Override
        public Object getItem(int i) {
            return arrayList.get(i);
        }

        @Override
        public long getItemId(int i) {
            return i;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            View row = convertView;
            if (convertView == null) {
                if (inflater == null)
                    inflater = (LayoutInflater) FavoritesArrivalsActivity.this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                row = inflater.inflate(R.layout.station_arrival_layout, parent, false);
            }
            TextView stationName = row.findViewById(R.id.text1);
            TextView time = row.findViewById(R.id.text2);

            Stops stops = arrayList.get(position);
            String stopName = Stops.getNameResource(stops.getRt());

            stationName.setText(stopName + " >  " + stops.getStpDe());
            if(stops.getIsApp().equals("1")){
                time.setText("DUE");
            }
            if(stops.getIsDly().equals("1")){
                time.setText("DELAYED");
            }
            if(stops.getIsApp().equals("0") & stops.getIsDly().equals("0")) {
                time.setText(stops.getDiffTime() + " mins");
            }

            if (stops.getRt().equals("Y")) {
                stationName.setTextColor(getBaseContext().getColor(R.color.fontColor));
                time.setTextColor(getBaseContext().getColor(R.color.fontColor));

            } else {
                stationName.setTextColor(getBaseContext().getColor(R.color.fontColorWhite));
                time.setTextColor(getBaseContext().getColor(R.color.fontColorWhite));
            }
            row.setBackgroundColor(getBaseContext().getColor(Stops.getColor(stops.getRt())));
            return row;
        }
    }

    private class GetStops extends AsyncTask<Void, Void, Void> {

        @Override
        protected void onPostExecute(Void result) {
            super.onPostExecute(result);
            ListView listView = (ListView) findViewById(R.id.trainStops);
            Collections.sort(StationStopsFavsN);
            Collections.sort(StationStopsFavsS);
            StationStopsFavsN.addAll(StationStopsFavsS);
            listView.setAdapter(new FavoritesArrivalsActivity.LineAdapter(StationStopsFavsN));
        }

        @Override
        protected Void doInBackground(Void... arg0) {

            JSONParser jParser = new JSONParser();
            String jsonStr = jParser.makeServiceCall("http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=59d25f874f544e8daf237b1e5859d7a9&mapid=" + mapID + "&outputType=JSON");

            Log.e(TAG, "Response from url: " + jsonStr);
            if (jsonStr != null) {
                try {
                    JSONObject jsonObj = new JSONObject(jsonStr);
                    JSONObject jsonObj2 = jsonObj.getJSONObject("ctatt");
                    JSONArray jsonArray = jsonObj2.getJSONArray("eta");

                    for (int i = 0; i < jsonArray.length(); i++) {
                        JSONObject nodes = jsonArray.getJSONObject(i);
                        String route = nodes.getString("rt");
                        String stopDes = nodes.getString("destNm");
                        String arrTime = nodes.getString("arrT");
                        String prdTime = nodes.getString("prdt");
                        String isApproch = nodes.getString("isApp");
                        String isDly = nodes.getString("isDly");
                        String trDr = nodes.getString("trDr");

                        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss");
                        SimpleDateFormat newTime = new SimpleDateFormat("m");

                        Date arrive = df.parse(arrTime);
                        Date prd = df.parse(prdTime);
                        long diffTime = arrive.getTime() - prd.getTime();
                        String finalTime = newTime.format(diffTime);

                        if(trDr.equals("1")) {
                            StationStopsFavsN.add(new Stops(route, stopDes, finalTime, isApproch, isDly, trDr));
                        }
                        if(trDr.equals("5")){
                            StationStopsFavsS.add(new Stops(route, stopDes, finalTime, isApproch, isDly, trDr));
                        }
                    }
                } catch (JSONException | ParseException e) {
                    e.printStackTrace();
                }
            }
            return null;
        }
    }
}