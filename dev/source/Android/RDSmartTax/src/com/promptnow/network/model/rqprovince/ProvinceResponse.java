package com.promptnow.network.model.rqprovince;

import java.util.List;

import com.promptnow.network.model.CommonResponseRD;

public class ProvinceResponse extends CommonResponseRD {
	public List<Province> province;
	
	// for spinner
	public String[] proName;
	public String[] proID;
}
