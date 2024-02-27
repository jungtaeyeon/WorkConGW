package com.WorkConGW.approval.dto;

import lombok.ToString;
import org.apache.ibatis.type.Alias;

@ToString
@Alias("FormVO")
public class FormVO {

    private int form_Id;
    private String form_Name;

    private String form_sup_id;

    private String form_Content;

    private int level;

    public String getForm_Content() {
        return form_Content;
    }

    public void setForm_Content(String form_Content) {
        this.form_Content = form_Content;
    }
    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }
    public String getForm_sup_id() {
        return form_sup_id;
    }

    public void setForm_sup_id(String form_sup_id) {
        this.form_sup_id = form_sup_id;
    }

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








}
