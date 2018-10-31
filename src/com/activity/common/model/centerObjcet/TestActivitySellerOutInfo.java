package com.activity.common.model.centerObjcet;

public class TestActivitySellerOutInfo {
	private String SELLEROUTINFO_RECORDID;
	private String OUTNO;
	private String SELLERID;

	public String getSELLEROUTINFO_RECORDID() {
		return SELLEROUTINFO_RECORDID;
	}

	public void setSELLEROUTINFO_RECORDID(String sELLEROUTINFO_RECORDID) {
		SELLEROUTINFO_RECORDID = sELLEROUTINFO_RECORDID;
	}

	public String getOUTNO() {
		return OUTNO;
	}

	public void setOUTNO(String oUTNO) {
		OUTNO = oUTNO;
	}

	public String getSELLERID() {
		return SELLERID;
	}

	public void setSELLERID(String sELLERID) {
		SELLERID = sELLERID;
	}

	public TestActivitySellerOutInfo() {
		super();
	}

	@Override
	public String toString() {
		return "TestActivitySellerOutInfo [SELLEROUTINFO_RECORDID=" + SELLEROUTINFO_RECORDID + ", OUTNO=" + OUTNO
				+ ", SELLERID=" + SELLERID + "]";
	}

}
