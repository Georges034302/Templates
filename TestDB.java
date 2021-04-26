/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.controller;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;
import uts.isd.model.dao.*;

/**
 *
 * @author George
 */
public class TestDB {
    private static final Scanner in = new Scanner(System.in);
    
    public static void main(String[] args) throws ClassNotFoundException, SQLException{
        DBConnector connector = new DBConnector();
        Connection con = connector.connection();
        UserManager manager = new UserManager(con);
        
        System.out.print("Choices a/x: ");
        char c = in.nextLine().charAt(0);
        while(c != 'x'){
            System.out.print("Name: ");
            String name = in.nextLine();
            System.out.print("Email: ");
            String email = in.nextLine();
            System.out.print("Password: ");
            String pass = in.nextLine();
            System.out.print("Phone: ");
            String phone = in.nextLine();
            System.out.print("Gender: ");
            String gender = in.nextLine();
            System.out.print("DOB: ");
            String dob = in.nextLine();
            manager.addUser(name, email, pass, phone, gender, dob);
            
            System.out.print("Choices a/x: ");
            c = in.nextLine().charAt(0);
        }
    }
}
