package com.example.rmiller.CTA_Commuter_Buddy;

import android.Manifest;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.AsyncTask;
import android.os.Handler;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.text.InputType;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import static com.example.rmiller.CTA_Commuter_Buddy.Lines.Type.y;
import static com.example.rmiller.CTA_Commuter_Buddy.Stations.st;

public class MainActivity extends AppCompatActivity {

    private String TAG = MainActivity.class.getSimpleName();
    private static final int PERMISSION_REQUEST_CODE = 1;

    List<Alerts> alerts = new ArrayList<>();
    List<Stations> favList = st;

    NodeList nodeList;
    Runnable refresh;
    final Handler handler = new Handler();

    String message;
    String phoneNumber = "";
    Integer counter = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ListView listView = (ListView) findViewById(R.id.trainColors);
        listView.setAdapter(new LineAdapter());

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Intent intent = new Intent(MainActivity.this, StationActivity.class);
                intent.putExtra(getString(R.string.RailColor), LineColors[i].getType().toString());
                intent.putExtra(getString(R.string.ColorTitle), LineColors[i].getName());
                startActivity(intent);
            }
        });

        //above API level 23 permission needs to be given by the user before text messages can
        //be sent.
        if (checkSelfPermission(Manifest.permission.SEND_SMS) == PackageManager.PERMISSION_DENIED) {
            Log.d("permission", "permission denied to SEND_SMS - requesting it");
            String[] permissions = {Manifest.permission.SEND_SMS};
            requestPermissions(permissions, PERMISSION_REQUEST_CODE);
        }

        final Button favButton = (Button) findViewById(R.id.favorites);
        final ToggleButton alertButton = (ToggleButton) findViewById(R.id.alertButton);

        favButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                Intent intent = new Intent(MainActivity.this, FavoritesListActivity.class);
                startActivity(intent);
            }
        });

        alertButton.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {

            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                if (b) {
                    //5554
                    if (phoneNumber.equals("")) {
                        dialogPopup();
                    }
                        refresh = new Runnable() {
                            @Override
                            public void run() {
                                if (!st.isEmpty() && st.size() != counter && !phoneNumber.equals("")) {
                                    sendAlerts();
                                    counter++;
                                }
                                handler.postDelayed(refresh, 15000);
                            }
                        };
                    handler.post(refresh);
                } else {
                    handler.removeCallbacks(refresh);
                }
            }
        });
        new GetInfo().execute();
    }

    public void sendSMS() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                SmsManager smsManager = SmsManager.getDefault();
                ArrayList<String> parts = smsManager.divideMessage(message);
                smsManager.sendMultipartTextMessage(phoneNumber, null, parts, null, null);
            }
        }).start();
    }

    public void dialogPopup() {
        final AlertDialog.Builder alertDialog = new AlertDialog.Builder(MainActivity.this);
        alertDialog.setTitle(getString(R.string.dialog_title));
        alertDialog.setMessage(getString(R.string.dialog_message));

        final EditText input = new EditText(MainActivity.this);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
        input.setLayoutParams(layoutParams);
        input.setImeOptions(EditorInfo.IME_ACTION_DONE);
        input.setInputType(InputType.TYPE_CLASS_PHONE);
        alertDialog.setView(input);

        alertDialog.setPositiveButton(getString(R.string.confirm_option), new DialogInterface.OnClickListener() {

            @Override
            public void onClick(DialogInterface dialogInterface, int i) {

                if (input.length() > 0) {
                    phoneNumber = input.getText().toString();
                    Toast.makeText(MainActivity.this, getString(R.string.phoneNumberAdded), Toast.LENGTH_LONG).show();
                } else {
                    Toast.makeText(MainActivity.this, getString(R.string.field_blank), Toast.LENGTH_LONG).show();
                    dialogPopup();
                }
            }
        });

        alertDialog.setNegativeButton(getString(R.string.cancel_option), new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.cancel();
            }
        });
        final AlertDialog ad = alertDialog.show();

        input.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (i == EditorInfo.IME_ACTION_DONE) {
                    if (input.length() > 0) {
                        phoneNumber = input.getText().toString();
                        Toast.makeText(MainActivity.this, getString(R.string.phoneNumberAdded), Toast.LENGTH_LONG).show();
                        ad.dismiss();
                    } else {
                        Toast.makeText(MainActivity.this, getString(R.string.field_blank), Toast.LENGTH_LONG).show();
                    }
                    return true;
                }
                return false;
            }
        });
    }

    public void sendAlerts() {
                for (int i = 0; i < favList.size(); i++) {
                    for (int j = 0; j < alerts.size(); j++) {
                        if (favList.get(i).getMapID().trim().equals(alerts.get(j).serviceID.trim())) {
                            Log.d("mapid", favList.get(i).getMapID());
                            Log.d("serviceID", alerts.get(j).serviceID);
                            message = alerts.get(j).serviceName + "\n" + alerts.get(j).impact + "\n" + alerts.get(j).getShortDescription();
                            sendSMS();
                            alerts.remove(alerts.get(j));
                        }
                    }
                }
            }

    private class LineAdapter extends BaseAdapter {

        private LayoutInflater inflater;

        @Override
        public int getCount() {
            return LineColors.length;
        }

        @Override
        public Object getItem(int i) {
            return LineColors[i];
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
                    inflater = (LayoutInflater) MainActivity.this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                row = inflater.inflate(R.layout.main_layout, parent, false);
            }
            TextView railColor = row.findViewById(R.id.text1);
            TextView route = row.findViewById(R.id.text2);

            Lines lines = LineColors[position];
            railColor.setText(lines.getName());
            route.setText(lines.getRoutes());

            if (lines.getType() == y) {
                railColor.setTextColor(getBaseContext().getColor(R.color.fontColor));
                route.setTextColor(getBaseContext().getColor(R.color.fontColor));
            } else {
                railColor.setTextColor(getBaseContext().getColor(R.color.fontColorWhite));
                route.setTextColor(getBaseContext().getColor(R.color.fontColorWhite));
            }
            row.setBackgroundColor(getBaseContext().getColor(Lines.getColor(lines.getType())));
            return row;
        }
    }

    private static final Lines[] LineColors = {
            new Lines("Red", Lines.Type.red, "Howard-95th/Dan-Ryan"),
            new Lines("Blue", Lines.Type.blue, "O'Hare-Forest Park"),
            new Lines("Brown", Lines.Type.brn, "Kimball-Loop"),
            new Lines("Green", Lines.Type.g, "Harlem/Lake-Ashland/63rd-Cottage Grv"),
            new Lines("Orange", Lines.Type.o, "Midway-Loop"),
            new Lines("Purple", Lines.Type.p, "Linden-Howard-Loop"),
            new Lines("Pink", Lines.Type.pnk, "54th/Cermak-Loop"),
            new Lines("Yellow", Lines.Type.y, "Skokie-Howard")
    };

    private class GetInfo extends AsyncTask<Void, Void, Void> {

        @Override
        protected Void doInBackground(Void... voids) {

            alerts.clear();
                try {
                    URL url = new URL(getString(R.string.URLXML));
                    DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
                    DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
                    //download the xml file
                    Document document = documentBuilder.parse(new InputSource(url.openStream()));
                    document.getDocumentElement().normalize();
                    //located the tag name
                    nodeList = document.getElementsByTagName(getString(R.string.alert));
                } catch (Exception e) {
                    Log.e("Error", e.getMessage());
                    e.printStackTrace();
                }

                for (int temp = 0; temp < nodeList.getLength(); temp++) {
                    Node node = nodeList.item(temp);
                    Element element = (Element) node;
                    //Sets the items into the array
                    String serviceTypeDescription = getNode(getString(R.string.service_type), element);
                    if (serviceTypeDescription.equals(getString(R.string.train_station))) {
                        String serviceName = getNode(getString(R.string.serviceName), element);
                        String shortDescription = getNode(getString(R.string.shortDescription), element);
                        String headline = getNode(getString(R.string.headline), element);
                        String serviceId = getNode(getString(R.string.serviceID), element);
                        String impact = getNode(getString(R.string.impact), element);
                        alerts.add(new Alerts(serviceName, shortDescription, headline, serviceId, impact));
                    }
                }
                Log.d(TAG, Arrays.toString(alerts.toArray()));
            return null;
        }
    }
    // getNode function
    private static String getNode(String sTag, Element eElement) {
        NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
        Node nValue = (Node) nlList.item(0);
        return nValue.getNodeValue();
    }
}