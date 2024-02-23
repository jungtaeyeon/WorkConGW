package com.WorkConGW.approval.dto;

import org.apache.ibatis.type.Alias;

@Alias("FormVO")
public class FormVO {

    private int form_Id;
    private String form_Name;
    private String form_Content;


    public int getForm_Id() {
        return form_Id;
    }

    public void setForm_Id(int form_Id) {
        this.form_Id = form_Id;
    }

    public String getForm_Name() {
        return form_Name;
    }

    public void setForm_Name(String form_Name) {
        this.form_Name = form_Name;
    }

    public String getForm_Content() {
        return form_Content;
    }

    public void setForm_Content(String form_Content) {
        this.form_Content = form_Content;
    }


    public FormVO(int form_Id, String form_Name, String form_Content) {
        this.form_Id = form_Id;
        this.form_Name = form_Name;
        this.form_Content = form_Content;
    }




}
