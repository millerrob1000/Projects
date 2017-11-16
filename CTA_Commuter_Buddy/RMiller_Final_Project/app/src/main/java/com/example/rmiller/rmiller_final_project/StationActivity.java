package com.example.rmiller.rmiller_final_project;

import android.content.Intent;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import static com.example.rmiller.rmiller_final_project.Stations.st;

public class StationActivity extends AppCompatActivity {

    String railColor = "";
    private RecyclerView stationList;

    List<Stations> StationLines = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_station);

        stationList = (RecyclerView) findViewById(R.id.trainStations);

        SwipeHelper swipeHelper = new SwipeHelper(this, stationList) {
            @Override
            public void instantiateUnderlayButton(RecyclerView.ViewHolder viewHolder, List<UnderlayButton> underlayButtons) {
                underlayButtons.add(new SwipeHelper.UnderlayButton(getString(R.string.fav_list), 0,
                        Color.parseColor(getString(R.string.addFavColor)), new SwipeHelper.UnderlayButtonClickListener(){

                    @Override
                    public void onClick(int pos) {
                        st.add(new Stations(StationLines.get(pos).getStationName(), StationLines.get(pos).getBool(),
                                StationLines.get(pos).getType(), StationLines.get(pos).getMapID()));
                        Toast.makeText(StationActivity.this, StationLines.get(pos).getStationName() + " station added to Favorites List", Toast.LENGTH_SHORT).show();
                        }
                     }
                ));
            }
        };

        Intent intent = getIntent();
        if(intent != null){
            railColor = (String) intent.getCharSequenceExtra(getString(R.string.RailColor));
            setTitle(intent.getStringExtra(getString(R.string.ColorTitle)) + " Line Stations");
        }

        new GetInfo().execute();
    }

    public class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        public final TextView name;

        public ViewHolder(ViewGroup row) {
            super(row);
            name = row.findViewById(R.id.text1);
        }

        @Override
        public void onClick(View view) {
            int position = getAdapterPosition(); // gets item position

            if (position != RecyclerView.NO_POSITION) {
                Intent intent = new Intent(StationActivity.this, StationArrivalDepartActivity.class);
                intent.putExtra(getString(R.string.MapID), StationLines.get(position).getMapID());
                intent.putExtra(getString(R.string.StationTitle), StationLines.get(position).getStationName());
                startActivity(intent);
            }
        }
    }

    class LineAdapter extends RecyclerView.Adapter<ViewHolder>{

        @Override
        //creates the viewholder and inflates the view.  called when view is created
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            ViewGroup row = (ViewGroup) LayoutInflater.from(parent.getContext()).inflate(R.layout.station_activity_layout, parent, false);
            ViewHolder vh = new ViewHolder(row);
            return vh;
        }

        @Override
        //called when RecycleView needs to fill in proper data into a view
        public void onBindViewHolder(ViewHolder holder, final int position) {
            final Stations stations = StationLines.get(position);

            holder.name.setText(stations.getStationName());
            holder.itemView.setBackgroundColor(getBaseContext().getColor(Stations.getColor(stations.getType())));
            if(stations.getType().equals("y")){
                holder.name.setTextColor(getBaseContext().getColor(R.color.fontColor));
            }else {
                holder.name.setTextColor(getBaseContext().getColor(R.color.fontColorWhite));
            }
            holder.itemView.setOnClickListener(holder);
        }

        @Override
        public int getItemCount() {
            return StationLines.size();
        }
    }

    private class GetInfo extends AsyncTask<Void, Void, Void> {

        @Override
        protected void onPostExecute(Void result){
            super.onPostExecute(result);

            stationList = (RecyclerView) findViewById(R.id.trainStations);
            RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(StationActivity.this);
            stationList.setLayoutManager(layoutManager);
            RecyclerView.Adapter adapter = new LineAdapter();
            stationList.setAdapter(adapter);
        }

        @Override
        protected Void doInBackground(Void... arg0){

                String temp = "";
                JSONParser jParser = new JSONParser();
                String jsonStr = jParser.makeServiceCall(getString(R.string.URLJSON));

                if (jsonStr != null) {
                    try {
                        JSONArray jsonArray = new JSONArray(jsonStr);
                        for (int i = 0; i < jsonArray.length(); i++) {
                            JSONObject nodes = jsonArray.getJSONObject(i);
                            String bool = nodes.getString(railColor);
                            String stationName = nodes.getString(getString(R.string.station_name));
                            String mapID = nodes.getString(getString(R.string.map_id));

                            if (bool.equals("true") && !stationName.equals(temp) && !stationName.equals(getString(R.string.CTAmistake))) {
                                temp = stationName;
                                StationLines.add(new Stations(stationName, bool, railColor, mapID));
                            }
                        }
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            return null;
        }
    }
}
