package com.WorkConGW.test;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class test {

    public static void main(String[] args) {

        LocalDate today = LocalDate.now();
       DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String strToday = today.format(formatter);
        System.out.println("strToday = " + strToday);


    }
}
