package com.promptnow.network.service;

import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle; 
 

public class LocationHelper implements LocationListener{
	
	private LocationManager mLocationManager;
	private Location mCurrentLocation;

	private static final int LOCATION_UPDATE_INTERVAL = 5 * 60 * 1000;
	private static final int LOCATION_UPDATE_DISTANCE = 10;
	
	public LocationHelper(Context context){
		mLocationManager = (LocationManager)context.getSystemService(Context.LOCATION_SERVICE);
	}
	
	public void startUpdateLocation(){
		mLocationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER
				, LOCATION_UPDATE_INTERVAL
				, LOCATION_UPDATE_DISTANCE
				, this);
	}
	
	public Location getCurrentLocation(){
		if (mCurrentLocation != null){
			return mCurrentLocation;
		}else{
			return mLocationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
		}
	}
	
	public void clearLocationUpdates(){
		mLocationManager.removeUpdates(this);
	}
	
	public static boolean isGPSAvaliable(Context context){
		LocationManager manager = (LocationManager)context.getSystemService(Context.LOCATION_SERVICE);
//		log("GPS_PROVIDER : "+manager.isProviderEnabled(LocationManager.GPS_PROVIDER));
//		log("NETWORK_PROVIDER : "+manager.isProviderEnabled(LocationManager.NETWORK_PROVIDER));
		return manager.isProviderEnabled(LocationManager.GPS_PROVIDER)/* || manager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)*/;
	}

	@Override
	public void onLocationChanged(Location location) {
		if (location != null){
			mCurrentLocation = location;
		}
	}

	@Override
	public void onProviderDisabled(String provider) {}

	@Override
	public void onProviderEnabled(String provider) {}

	@Override
	public void onStatusChanged(String provider, int status, Bundle extras) {}
	 
	
}