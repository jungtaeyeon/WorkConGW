package com.WorkConGW.common.dto;

import org.apache.ibatis.type.Alias;

@Alias("MenuVO")
public class MenuVO {
	
    private String mcode;
    private String mname;
    private String murl;
    private String mstate;
    private String msequence;

    public MenuVO(){}

    public MenuVO(String mcode,String mname, String murl, String mstate,String msequence)
    {
        this.mcode = mcode;
        this.mname = mname;
        this.murl = murl;
        this.mstate = mstate;
        this.msequence = msequence;
    }

    public String getMcode() {
        return this.mcode;
    }

    public void setMcode(String mcode) {
        this.mcode = mcode;
    }

    public String getMname() {
        return this.mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getMurl() {
        return this.murl;
    }

    public void setMurl(String murl) {
        this.murl = murl;
    }

    public String getMstate() {
        return this.mstate;
    }

    public void setMstate(String mstate) {
        this.mstate = mstate;
    }

    public String getMsequence() {
        return this.msequence;
    }

    public void setMsequence(String msequence) {
        this.msequence = msequence;
    }


}
