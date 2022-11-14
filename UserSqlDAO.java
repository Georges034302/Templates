package com.edu.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.edu.model.User;
import com.edu.model.Users;

public class UserSqlDAO {

    private final Statement st;
    private PreparedStatement updateSt;
    private PreparedStatement deleteSt;
    private String updateQuery = "UPDATE USERS SET NAME=? ,PASSWORD=? ,DOB=? WHERE ID=?";
    private String deleteQuery = "DELETE FROM USERS WHERE EMAIL= ?";

    public UserSqlDAO(Connection connection) throws SQLException {
        st = connection.createStatement();
        updateSt = connection.prepareStatement(updateQuery);
        deleteSt = connection.prepareStatement(deleteQuery);
    }

    public void createUser(String name, String email, String password, String dob) throws SQLException {
        String columns = "INSERT INTO mydb.USERS(NAME,EMAIL,PASSWORD,DOB)";
        String values = "VALUES('" + name + "','" + email + "','" + password + "','" + dob + "')";
        st.executeUpdate(columns + values);
    }

    public User getUser(int ID) throws SQLException {
        String fetch = "SELECT * FROM mydb.USERS WHERE ID='" + ID + "'";
        ResultSet rs = st.executeQuery(fetch);
        while (rs.next()) {
            int userID = Integer.parseInt(rs.getString(1));

            if (ID == userID) {
                String name = rs.getString(2);
                String email = rs.getString(3);
                String password = rs.getString(4);
                String dob = rs.getString(5);
                return new User(ID, name, email, password, dob);
            }
        }
        return null;
    }

      public User getUser(String userEmail) throws SQLException {
        String fetch = "SELECT * FROM mydb.users WHERE EMAIL='" + userEmail + "'";
        ResultSet rs = st.executeQuery(fetch);
        while (rs.next()) {
            String email = rs.getString(3);
            if (email.equals(userEmail)) {
                int ID = Integer.parseInt(rs.getString(1));
                String name = rs.getString(2);
                String password = rs.getString(4);
                String dob = rs.getString(5);
                return new User(ID, name, email, password, dob);
            }
        }
        return null;
    }


    public User login(String email, String password) throws SQLException {
        String fetch = "SELECT * FROM mydb.users WHERE EMAIL='" + email + "' AND PASSWORD='" + password + "'";
        ResultSet rs = st.executeQuery(fetch);
        while (rs.next()) {
            String userEmail = rs.getString(3);
            String userPass = rs.getString(4);
            if (userEmail.equals(email) && userPass.equals(password)) {
                int ID = Integer.parseInt(rs.getString(1));
                String name = rs.getString(2);
                String dob = rs.getString(5);

                return new User(ID, name, email, password, dob);
            }
        }
        return null;
    }

    public void update(String name, String password, String dob, String ID) throws SQLException {
        updateSt.setString(1, name);
        updateSt.setString(2, password);
        updateSt.setString(3, dob);
        updateSt.setString(4, ID);
        int row = updateSt.executeUpdate();
        System.out.println("row " + row + " updated successfuly");
    }

    public void delete(String email) throws SQLException {
        deleteSt.setString(1, email);
        int row = deleteSt.executeUpdate();
        System.out.println("row " + row + " deleted successfuly");
    }

    public List<User> fetchUsers() throws SQLException {
        String fetch = "select * from mydb.users";
        ResultSet rs = st.executeQuery(fetch);
        List<User> temp = new ArrayList();

        while (rs.next()) {
            int ID = Integer.parseInt(rs.getString(1));
            String name = rs.getString(2);
            String email = rs.getString(3);
            String pass = rs.getString(4);
            String dob = rs.getString(5);;
            temp.add(new User(ID, name, email, pass, dob));
        }
        return temp;
    }

    public Users getUsers() throws SQLException {
        String fetch = "select * from mydb.users";
        ResultSet rs = st.executeQuery(fetch);
        List<User> temp = new ArrayList();

        while (rs.next()) {
            int ID = Integer.parseInt(rs.getString(1));
            String name = rs.getString(2);
            String email = rs.getString(3);
            String pass = rs.getString(4);
            String dob = rs.getString(5);;
            temp.add(new User(ID, name, email, pass, dob));
        }
        Users users = new Users();
        users.addAll(temp);
        return users;
    }
}
