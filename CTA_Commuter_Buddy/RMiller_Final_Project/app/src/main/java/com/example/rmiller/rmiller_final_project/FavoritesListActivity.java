package com.example.rmiller.rmiller_final_project;

import android.content.Intent;
import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;
import java.util.Arrays;
import java.util.List;
import static com.example.rmiller.rmiller_final_project.Stations.st;

public class FavoritesListActivity extends AppCompatActivity{

    private String TAG = FavoritesListActivity.class.getSimpleName();
    private RecyclerView.Adapter adapter;

    List<Stations> StationLines = st;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_favorites_list);

        RecyclerView favStations = (RecyclerView) findViewById(R.id.favListStations);
        RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(FavoritesListActivity.this);
        favStations.setLayoutManager(layoutManager);
        adapter = new Adapter();
        favStations.setAdapter(adapter);

        setTitle(getString(R.string.favTitle));

        SwipeHelper swipeHelper2 = new SwipeHelper(FavoritesListActivity.this, favStations) {
            @Override
            public void instantiateUnderlayButton(RecyclerView.ViewHolder viewHolder, List<UnderlayButton> underlayButtons) {
                underlayButtons.add(new SwipeHelper.UnderlayButton(getString(R.string.deleteButton), 0, Color.parseColor(getString(R.string.deleteColor)), new SwipeHelper.UnderlayButtonClickListener() {

                    @Override
                    public void onClick(int pos) {
                        Toast.makeText(FavoritesListActivity.this, StationLines.get(pos).getStationName() + " removed", Toast.LENGTH_SHORT).show();
                        StationLines.remove(pos);
                        adapter.notifyItemRemoved(pos);
                        Log.d(TAG, Arrays.toString(st.toArray()));
                    }
                }));
            }
        };
    }

    class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        private final TextView name;

        ViewHolder(View row) {
            super(row);
            name = row.findViewById(R.id.text1);
        }

        @Override
        public void onClick(View view) {
            int position = getAdapterPosition(); //gets item position

            if(position != RecyclerView.NO_POSITION){
                Intent intent = new Intent(FavoritesListActivity.this, FavoritesArrivalsActivity.class);
                intent.putExtra(getString(R.string.MapID), StationLines.get(position).getMapID());
                intent.putExtra(getString(R.string.StationTitle), StationLines.get(position).getStationName());
                startActivity(intent);
            }
        }
    }

    private class Adapter extends RecyclerView.Adapter<ViewHolder>{

        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            ViewGroup row = (ViewGroup) LayoutInflater.from(parent.getContext()).inflate(R.layout.fav_stations_layout, parent, false);
            return new ViewHolder(row);
        }

        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
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
}
