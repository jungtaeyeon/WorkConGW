package com.WorkConGW.treeview.command;

import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.util.List;

@ToString
@Alias("ProjectWithDuties")
public class ProjectWithDuties {
    public ProjectOrgCommand getProject() {
        return project;
    }

    public void setProject(ProjectOrgCommand project) {
        this.project = project;
    }

    public List<ProjectOrgCommand> getDuties() {
        return duties;
    }

    public void setDuties(List<ProjectOrgCommand> duties) {
        this.duties = duties;
    }

    private ProjectOrgCommand project;
    private List<ProjectOrgCommand> duties;

}
