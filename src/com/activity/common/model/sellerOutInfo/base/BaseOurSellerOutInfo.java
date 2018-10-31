package com.activity.common.model.sellerOutInfo.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 运单记录
 * @author ChenXb
 *
 * 2017年11月6日
 */
@SuppressWarnings("serial")
public class BaseOurSellerOutInfo<M extends BaseOurSellerOutInfo<M>> extends Model<M> implements IBean {
	
	public void setRECORDID(java.math.BigDecimal RECORDID) {
		set("RECORDID", RECORDID);
	}
	public java.math.BigDecimal getRECORDID() {
		return get("RECORDID");
	}
	
	

	public void setUSERID(java.lang.Integer USERID) {
		set("USERID", USERID);
	}
	public java.lang.Integer getUSERID() {
		return get("USERID");
	}
	
	

	public void setSTOREID(java.lang.Integer STOREID) {
		set("STOREID", STOREID);
	}
	public java.lang.Integer getSTOREID() {
		return get("STOREID");
	}
	
	

	public void setPRODUCTID(java.lang.Integer PRODUCTID) {
		set("PRODUCTID", PRODUCTID);
	}
	public java.lang.Integer getPRODUCTID() {
		return get("PRODUCTID");
	}

	
	
	public void setSELLERID(java.lang.String SELLERID) {
		set("SELLERID", SELLERID);
	}
	public java.lang.String getSELLERID() {
		return get("SELLERID");
	}
	
	

	public void setOUTNO(java.lang.String OUTNO) {
		set("OUTNO", OUTNO);
	}
	public java.lang.String getOUTNO() {
		return get("OUTNO");
	}
	
	

	public void setPRODUCTNAME(java.lang.String PRODUCTNAME) {
		set("PRODUCTNAME", PRODUCTNAME);
	}
	public java.lang.String getPRODUCTNAME() {
		return get("PRODUCTNAME");
	}
	
	
	
	public void setOUTTYPE(java.lang.String OUTTYPE) {
		set("OUTTYPE", OUTTYPE);
	}
	public java.lang.String getOUTTYPE() {
		return get("OUTTYPE");
	}
	
	

	public void setSELLERNAME(java.lang.String SELLERNAME) {
		set("SELLERNAME", SELLERNAME);
	}

	public java.lang.String getSELLERNAME() {
		return get("SELLERNAME");
	}
	
	

	public void setPACKCODE(java.lang.String PACKCODE) {
		set("PACKCODE", PACKCODE);
	}
	public java.lang.String getPACKCODE() {
		return get("PACKCODE");
	}
	
	
	
	public void setBOXCODE(java.lang.String BOXCODE) {
		set("BOXCODE", BOXCODE);
	}
	public java.lang.String getBOXCODE() {
		return get("BOXCODE");
	}
	
	

	public void setBOTTLECODE(java.lang.String BOTTLECODE) {
		set("BOTTLECODE", BOTTLECODE);
	}
	public java.lang.String getBOTTLECODE() {
		return get("BOTTLECODE");
	}
	
	

	public void setSPEC(java.lang.String SPEC) {
		set("SPEC", SPEC);
	}
	public java.lang.String getSPEC() {
		return get("SPEC");
	}
	
	

	public void setDEGREE(java.lang.Number DEGREE) {
		set("DEGREE", DEGREE);
	}
	public java.lang.Number getDEGREE() {
		return get("DEGREE");
	}
	
	

	public void setVOLUME(java.lang.Number VOLUME) {
		set("VOLUME", VOLUME);
	}
	public java.lang.Number getVOLUME() {
		return get("VOLUME");
	}
	
	
	
	public void setOUTDATE(java.util.Date OUTDATE) {
		set("OUTDATE", OUTDATE);
	}
	public java.util.Date getOUTDATE() {
		return get("OUTDATE");
	}
	
	

	public void setLOGISNUM(java.lang.String LOGISNUM) {
		set("LOGISNUM", LOGISNUM);
	}
	public java.lang.String getLOGISNUM() {
		return get("LOGISNUM");
	}
	
	

	public void setPLATENUM(java.lang.String PLATENUM) {
		set("PLATENUM", PLATENUM);
	}
	public java.lang.String getPLATENUM() {
		return get("PLATENUM");
	}
	
	

	public void setRECSELLERCODE(java.lang.String RECSELLERCODE) {
		set("RECSELLERCODE", RECSELLERCODE);
	}
	public java.lang.String getRECSELLERCODE() {
		return get("RECSELLERCODE");
	}
	
	

	public void setRECSELLERNAME(java.lang.String RECSELLERNAME) {
		set("RECSELLERNAME", RECSELLERNAME);
	}
	public java.lang.String getRECSELLERNAME() {
		return get("RECSELLERNAME");
	}
	
	

	public void setUSERNAME(java.lang.String USERNAME) {
		set("USERNAME", USERNAME);
	}
	public java.lang.String getUSERNAME() {
		return get("USERNAME");
	}
	
	

	public void setRECSELLERAREA(java.lang.String RECSELLERAREA) {
		set("RECSELLERAREA", RECSELLERAREA);
	}
	public java.lang.String getRECSELLERAREA() {
		return get("RECSELLERAREA");
	}
	
	
	
	public void setLOGISTICID(java.lang.Integer LOGISTICID) {
		set("LOGISTICID", LOGISTICID);
	}
	public java.lang.Integer getLOGISTICID() {
		return get("LOGISTICID");
	}
	
	
	
	public void setCONTACTS(java.lang.String CONTACTS) {
		set("CONTACTS", CONTACTS);
	}
	public java.lang.String getCONTACTS() {
		return get("CONTACTS");
	}
	
	
	
	public void setLOGISTICNAME(java.lang.String LOGISTICNAME) {
		set("LOGISTICNAME", LOGISTICNAME);
	}
	public java.lang.String getLOGISTICNAME() {
		return get("LOGISTICNAME");
	}
	
	
	
	public void setSTORENAME(java.lang.String STORENAME) {
		set("STORENAME", STORENAME);
	}
	public java.lang.String getSTORENAME() {
		return get("STORENAME");
	}
	
	
	
	public void setPRODUCTTYPE(java.lang.String PRODUCTTYPE) {
		set("PRODUCTTYPE", PRODUCTTYPE);
	}
	public java.lang.String getPRODUCTTYPE() {
		return get("PRODUCTTYPE");
	}
	
	
	
	public void setBRANDSID(java.lang.Integer BRANDSID) {
		set("BRANDSID", BRANDSID);
	}
	public java.lang.Integer getBRANDSID() {
		return get("BRANDSID");
	}
	
	
	
	public void setBRANDSNAME(java.lang.String BRANDSNAME) {
		set("BRANDSNAME", BRANDSNAME);
	}
	public java.lang.String getBRANDSNAME() {
		return get("BRANDSNAME");
	}
	
	
	
	public void setSTATUS(java.lang.Integer STATUS) {
		set("STATUS", STATUS);
	}
	public java.lang.Integer getSTATUS() {
		return get("STATUS");
	}
	
	
	
	public void setLOGISTICNO(java.lang.String LOGISTICNO) {
		set("LOGISTICNO", LOGISTICNO);
	}
	public java.lang.String getLOGISTICNO() {
		return get("LOGISTICNO");
	}
	
	
	
	public void setREMARK(java.lang.String REMARK) {
		set("REMARK", REMARK);
	}
	public java.lang.String getREMARK() {
		return get("REMARK");
	}
	
	
	
	public void setBILLNUMBER(java.lang.String BILLNUMBER) {
		set("BILLNUMBER", BILLNUMBER);
	}
	public java.lang.String getBILLNUMBER() {
		return get("BILLNUMBER");
	}
	
	
	
	public void setWLYSIGN(java.lang.Number WLYSIGN) {
		set("WLYSIGN", WLYSIGN);
	}
	public java.lang.Number getWLYSIGN() {
		return get("WLYSIGN");
	}
	
	
	
	public void setSELLERPHONE(java.lang.String SELLERPHONE) {
		set("SELLERPHONE", SELLERPHONE);
	}
	public java.lang.String getSELLERPHONE() {
		return get("SELLERPHONE");
	}
	
	
	
	public void setRECSELLERPHONE(java.lang.String RECSELLERPHONE) {
		set("RECSELLERPHONE", RECSELLERPHONE);
	}
	public java.lang.String getRECSELLERPHONE() {
		return get("RECSELLERPHONE");
	}
	
	
	
	public void setSYSSIGN(java.lang.Number SYSSIGN) {
		set("SYSSIGN", SYSSIGN);
	}
	public java.lang.Number getSYSSIGN() {
		return get("SYSSIGN");
	}
	
	
	
	public void setRECYSELLERCODE(java.lang.String RECYSELLERCODE) {
		set("RECYSELLERCODE", RECYSELLERCODE);
	}
	public java.lang.String getRECYSELLERCODE() {
		return get("RECYSELLERCODE");
	}
	
	
	
	public void setPLSSIGN(java.lang.Number PLSSIGN) {
		set("PLSSIGN", PLSSIGN);
	}
	public java.lang.Number getPLSSIGN() {
		return get("PLSSIGN");
	}
	
	
	public void setACTIVESIGN(java.lang.String ACTIVESIGN) {
		set("ACTIVESIGN", ACTIVESIGN);
	}
	public java.lang.String getACTIVESIGN() {
		return get("ACTIVESIGN");
	}
	
}
